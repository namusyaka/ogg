$:.unshift(File.dirname(__FILE__))
require 'spec_helper'

module Ogg
  describe Helpers do
    include Ogg::Helpers

    it "og_tag" do
      actual_html = og_tag do |ogg|
        ogg.title = "Site Title"
        ogg.type  = "Article"
        ogg.image = "http://example.com/example.png"
        ogg.url   = "http://example.com/"
      end
      expect(actual_html).to have_tag("meta", :with => {:property => "og:title", :content => "Site Title"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:type", :content => "Article"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:image", :content => "http://example.com/example.png"})
      expect(actual_html).to have_tag("meta", :with => {:property => "og:url", :content => "http://example.com/"})
    end
  end
end
