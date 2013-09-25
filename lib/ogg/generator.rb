
module Ogg
  class Generator
    class InvalidBasicProperty < ArgumentError
    end

    class Property
      attr_accessor :content
      attr_reader :property

      def initialize(property)
        @property = property
        @children = []
      end

      def add_child(structured_property)
        raise ArgumentError unless @children
        @children << structured_property
      end

      def [](name)
        return nil unless @children
        name = name.to_s
        @children.find{|child| child.property == name }
      end

      def []=(name, value)
        child = __send__(:[], name)
        raise ArgumentError unless child
        child.content = value
      end

      def method_missing(name, *args)
        super unless @children
        name = name.to_s
        structured_property = @children.find{|child| [child.property, "#{child.property}="].include?(name) }
        super unless structured_property
        if name[-1] == "="
          structured_property.content = args.shift
        else
          structured_property
        end
      end

      def changed?
        content
      end

      def meta_tag
        tags = []
        tags << "<meta property=\"og:#{@property}\" content=\"#{content}\">" if changed?
        @children.each do |child|
          next unless child.changed?
          if child.alternative?
            tags << "<meta property=\"og:#{@property}\" content=\"#{child.content}\"><a></a>" unless changed?
          else
            tags << child.meta_tag
          end
        end
        tags.compact.join("\n")
      end
    end

    class StructuredProperty < Property
      def initialize(property, options = {})
        @property    = property
        @parent      = options[:parent]
        @alternative = options[:alternative]
      end

      def alternative?
        @alternative
      end

      def meta_tag
        "<meta property=\"og:#{@parent}:#{@property}\" content=\"#{content}\">"
      end
    end

    class << self
      def define_property(name, options = {})
        define_method(name) do
          properties = instance_variable_get(:@properties)
          return properties[name] if properties.is_a?(Hash) and properties[name]
          properties = instance_variable_set(:@properties, {}) unless properties.is_a?(Hash)
          property = properties[name] = Property.new(name)
          options[:children].each do |child|
            options_for_child = {:parent => name, :alternative => child == "url"}
            property.add_child(StructuredProperty.new(child, options_for_child))
          end if options[:children]
          property
        end
        define_method("#{name}=") do |value|
          property = __send__(name)
          property.content = value
        end
      end

      def define_properties(names, options = {})
        names.each{|name| define_property(name, options) }
      end
    end

    BASIC_PROPERTIES = %w[title type url image]
    OPTIONAL_PROPERTIES = %w[
      audio description determiner locale
      site_name video
    ]
    STRUCTURED_PROPERTIES = {
      :image  => %w[url secure_url type width height],
      :video  => %w[secure_url type width height],
      :audio  => %w[secure_url type],
      :locale => %w[alternate]
    }

    (BASIC_PROPERTIES + OPTIONAL_PROPERTIES).each do |property|
      options = {}
      properties = STRUCTURED_PROPERTIES[property.to_sym]
      options[:children] = properties if properties
      define_property(property, options)
    end

    def initialize(options = {}, &block)
      @raise = options[:raise]
      instance_eval(&block) if block_given?
    end

    def [](name)
      raise ArgumentError unless respond_to?(name)
      __send__(name)
    end

    def []=(name, value)
      __send__(:[], name).content = value
    end

    def basic_properties
      BASIC_PROPERTIES.map{|name|
        property_instance = __send__(name)
        raise_invalid_basic_property(name) if @raise and !property_instance.content
        property_instance.meta_tag
      }.delete_if(&:empty?).join("\n")
    end

    def optional_properties
      OPTIONAL_PROPERTIES.map{|name|
        property_instance = __send__(name)
        property_instance.meta_tag
      }.delete_if(&:empty?).join("\n")
    end

    def html
      @properties ||= {}
      if @raise
        diff = BASIC_PROPERTIES - @properties.keys
        raise_invalid_basic_property(diff * ", ") unless diff.empty?
      end
      @properties.values.map(&:meta_tag).delete_if(&:empty?).join("\n")
    end

    def raise_invalid_basic_property(name)
      raise InvalidBasicProperty, "`#{name}` should be set."
    end
  end
end
