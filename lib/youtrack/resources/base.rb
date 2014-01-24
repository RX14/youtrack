module Youtrack
  class Base
    include HTTParty

    # The base route URL
    attr_accessor :base_url

    # The Server Endpoint
    attr_accessor :service

    # Stores the response of the previous request
    attr_accessor :response


    def initialize(client, resource_name)
      @service = client
      @base_url = join(@service.endpoint, resource_name)
    end

    protected

      def join(*args)
        File.join(*args)
      end

      def prepare_options(options={})
        options[:headers] ||= {}
        options[:headers]['Cookie'] = service.cookies['Cookie']
        options
      end
      
      def post(path, options={})
        options = prepare_options(options)
        @response = self.class.post( join(base_url, path), options )
      end

      def put(path, options={})
        options = prepare_options(options)
        @response = self.class.put( join(base_url, path), options )
      end

      def get(path, options={})
        options = prepare_options(options)
        @response = self.class.get( join(base_url, path), options )
      end

      def delete(path, options={})
        options = prepare_options(options)
        @response = self.class.delete( join(base_url, path), options )
      end

  end
end