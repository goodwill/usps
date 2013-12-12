module USPS::Request
  class Base
    class << self
      attr_reader :api, :tag, :secure, :response, :require_password

      alias :secure? :secure
      
      alias :require_password? :require_password

      # Config given
      #   api: The USPS API name as given in the request URL
      #   tag: The root tag used for the request
      #   secure: Whether or not the request is against the secure server
      #   response: The USPS::Response class used to handle responses
      def config(options = {})
        @api = USPS.config.certify ? (options[:api_certify] || options[:api]).to_s : options[:api].to_s 
        @tag = USPS.config.certify ? (options[:tag_certify] || options[:tag]).to_s : options[:tag].to_s
        @secure = !!options[:secure]
        @response = options[:response]
        @require_password = !!options[:require_password]
      end
    end

    def send!
      USPS.client.request(self)
    end

    def secure?
      !!self.class.secure?
    end
    
    def require_password?
      self.class.require_password?
    end

    def api
      self.class.api
    end

    def response_for(xml)
      self.class.response.parse(xml)
    end


    def build(&block)
      builder = Builder::XmlMarkup.new(:indent => 0)
      hash={:USERID => USPS.config.username}
      hash[:PASSWORD]=USPS.config.password if self.require_password?
      builder.tag!(self.class.tag, hash, &block)
    end
  end
end
