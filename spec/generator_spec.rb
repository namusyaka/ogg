$:.unshift(File.dirname(__FILE__))
require 'spec_helper'

module Ogg
  describe Generator do
    it "support basic properties" do
      ogg = Ogg::Generator.new
      ogg.title = "Site Title"
      ogg.type  = "Article"
      ogg.image = "http://example.com/example.png"
      ogg.url   = "http://example.com/"
      actual_html = ogg.html
      expect(actual_html).to have_tag("meta", :with => {:property => "og:title", :content => "Site Title"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:type", :content => "Article"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:image", :content => "http://example.com/example.png"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:url", :content => "http://example.com/"})
    end

    it "support basic properties with block" do
      ogg = Ogg::Generator.new do |o|
        o.title = "Site Title"
        o.type  = "Article"
        o.image = "http://example.com/example.png"
        o.url   = "http://example.com/"
      end
      actual_html = ogg.html
      expect(actual_html).to have_tag("meta", :with => {:property => "og:title", :content => "Site Title"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:type", :content => "Article"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:image", :content => "http://example.com/example.png"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:url", :content => "http://example.com/"})
    end

    it "support optional properties" do
      ogg = Ogg::Generator.new do |o|
        o.audio       = "Audio"
        o.description = "Description"
        o.determiner  = "Determiner"
        o.locale      = "en_US"
        o.site_name   = "Example Site"
        o.video       = "Video"
      end
      actual_html = ogg.html
      expect(actual_html).to have_tag("meta", :with => {:property => "og:audio", :content => "Audio"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:description", :content => "Description"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:determiner", :content => "Determiner"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:locale", :content => "en_US"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:site_name", :content => "Example Site"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:video", :content => "Video"})
    end

    it "support structured properties as accessor" do
      ogg = Ogg::Generator.new do |o|
        o.image.url        = "http://example.com/example.png"
        o.image.secure_url = "https://example.com/example.png"
        o.image.type       = "image/png"
        o.image.width      = "400"
        o.image.height     = "300"

        o.video.secure_url = "https://example.com/example.swf"
        o.video.type       = "application/x-shockwave-flash"
        o.video.width      = "400"
        o.video.height     = "300"

        o.audio.secure_url = "https://example.com/example.mp3"
        o.audio.type       = "audio/mpeg"
      end
      actual_html = ogg.html
      expect(actual_html).to have_tag("meta", :with => {:property => "og:image", :content => "http://example.com/example.png"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:image:secure_url", :content => "https://example.com/example.png"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:image:type", :content => "image/png"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:image:width", :content => "400"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:image:height", :content => "300"})

      expect(actual_html).to have_tag("meta", :with => {:property => "og:video:secure_url", :content => "https://example.com/example.swf"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:video:type", :content => "application/x-shockwave-flash"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:video:width", :content => "400"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:video:height", :content => "300"})

      expect(actual_html).to have_tag("meta", :with => {:property => "og:audio:secure_url", :content => "https://example.com/example.mp3"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:audio:type", :content => "audio/mpeg"})
    end

    it "support structured properties like hash" do
      ogg = Ogg::Generator.new do |o|
        o.image[:url]        = "http://example.com/example.png"
        o.image[:secure_url] = "https://example.com/example.png"
        o.image[:type]       = "image/png"
        o.image[:width]      = "400"
        o.image[:height]     = "300"

        o.video[:secure_url] = "https://example.com/example.swf"
        o.video[:type]       = "application/x-shockwave-flash"
        o.video[:width]      = "400"
        o.video[:height]     = "300"

        o.audio[:secure_url] = "https://example.com/example.mp3"
        o.audio[:type]       = "audio/mpeg"
      end
      actual_html = ogg.html
      expect(actual_html).to have_tag("meta", :with => {:property => "og:image", :content => "http://example.com/example.png"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:image:secure_url", :content => "https://example.com/example.png"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:image:type", :content => "image/png"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:image:width", :content => "400"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:image:height", :content => "300"})

      expect(actual_html).to have_tag("meta", :with => {:property => "og:video:secure_url", :content => "https://example.com/example.swf"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:video:type", :content => "application/x-shockwave-flash"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:video:width", :content => "400"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:video:height", :content => "300"})

      expect(actual_html).to have_tag("meta", :with => {:property => "og:audio:secure_url", :content => "https://example.com/example.mp3"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:audio:type", :content => "audio/mpeg"})
    end

    it "prioritizes parent property if duplicates parent property and alternative property" do
      ogg = Ogg::Generator.new do |o|
        o.image            = "http://example.com/example.jpg"
        o.image.url        = "http://example.com/example.png"
      end
      expect(ogg.html).to have_tag("meta", :with => {:property => "og:image", :content => "http://example.com/example.jpg"})
    end

    it "returns empty string if property is not set" do
      ogg = Ogg::Generator.new
      actual_html = ogg.html
      expect(actual_html).to eq("")
    end

    it "occurs InvalidBasicProperty if :raise is set and basic properties are inadequacy" do
      ogg = Ogg::Generator.new(:raise => true)
      expect{ ogg.html }.to raise_error(Ogg::Generator::InvalidBasicProperty)
    end

    describe "#basic_properties" do
      it "occurs InvalidBasicProperty if :raise is set and basic properties are inadequacy" do
        ogg = Ogg::Generator.new(:raise => true) do |o|
          o.image = "http://example.com/example.jpg"
        end
        expect{ ogg.basic_properties }.to raise_error(Ogg::Generator::InvalidBasicProperty)
      end

      it "support only basic properties" do
        ogg = Ogg::Generator.new do |o|
          o.title = "Site Title"
          o.type  = "Article"
          o.image = "http://example.com/example.png"
          o.url   = "http://example.com/"
          o.description = "Description"
        end
        actual_html = ogg.basic_properties
        expect(actual_html).to have_tag("meta", :with => {:property => "og:title", :content => "Site Title"})
        expect(actual_html).to have_tag("meta", :with => {:property => "og:type", :content => "Article"})
        expect(actual_html).to have_tag("meta", :with => {:property => "og:image", :content => "http://example.com/example.png"})
        expect(actual_html).to have_tag("meta", :with => {:property => "og:url", :content => "http://example.com/"})
        expect(actual_html).to have_tag("meta", :without => {:property => "og:description"})
      end
    end

    describe "#optional_properties" do
      it "support only optional properties" do
        ogg = Ogg::Generator.new do |o|
          o.audio       = "Audio"
          o.description = "Description"
          o.determiner  = "Determiner"
          o.locale      = "en_US"
          o.site_name   = "Example Site"
          o.video       = "Video"
          o.title       = "Site Title"
        end
        actual_html = ogg.optional_properties
        expect(actual_html).to have_tag("meta", :with => {:property => "og:audio", :content => "Audio"})
        expect(actual_html).to have_tag("meta", :with => {:property => "og:description", :content => "Description"})
        expect(actual_html).to have_tag("meta", :with => {:property => "og:determiner", :content => "Determiner"})
        expect(actual_html).to have_tag("meta", :with => {:property => "og:locale", :content => "en_US"})
        expect(actual_html).to have_tag("meta", :with => {:property => "og:site_name", :content => "Example Site"})
        expect(actual_html).to have_tag("meta", :with => {:property => "og:video", :content => "Video"})
        expect(actual_html).to have_tag("meta", :without => {:property => "og:title"})
      end
    end
  end
end
