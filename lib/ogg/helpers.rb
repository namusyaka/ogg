
module Ogg
  module Helpers
    def og_tag(*args, &block)
      Ogg.new(*args, &block).html
    end
  end
end
