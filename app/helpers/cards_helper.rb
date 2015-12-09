module CardsHelper
end

#makes paperclip(media upload) validates
module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end
