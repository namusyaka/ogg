require 'ogg/generator'
require 'ogg/helpers'

module Ogg
  def self.new(*args, &block)
    Generator.new(*args, &block)
  end
end
