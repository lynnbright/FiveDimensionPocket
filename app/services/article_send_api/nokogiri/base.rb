class ArticleSendApi
  module Nokogiri
    class Base
      def initialize(url)
        @url = url
      end

      def perform
        p @url
      end
      
    end
  end
end
