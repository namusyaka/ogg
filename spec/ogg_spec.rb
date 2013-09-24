$:.unshift(File.dirname(__FILE__))
require 'spec_helper'

module Ogg
  describe do
    it "new method" do
      ogg = Ogg.new
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

    it "new method with block" do
      ogg = Ogg.new do |o|
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
  end
end
