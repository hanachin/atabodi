require 'yaml'
require 'json'
require 'forwardable'
require 'jsonism'

module Atabodi
  DEFAULT_SCHEMA = YAML.load_file File.expand_path('../../idobata.yml', __dir__)

  class Client
    extend Forwardable

    def_delegator :client, :respond_to?, :respond_to_missing?

    def initialize(schema: DEFAULT_SCHEMA
      @schema = schema
      client.connection.headers = client.connection.headers.merge(headers)
    end

    def method_missing(name, *args)
      if client.respond_to?(name)
        client.send(name, *args)
      else
        raise NoMethodError, name
      end
    end

    def update_bot_icon(id:, file_path:)
      c = Faraday.new(url: client.base_url) do |connection|
        connection.request :multipart
        connection.request :url_encoded
        connection.response :json
        connection.adapter :net_http
      end

      # FIXME MIME TYPE
      params = {'bot[icon]' => Faraday::UploadIO.new(file_path, 'image/jpeg')}
      res = c.put("/api/bots/#{id}", params, headers)

      Jsonism::Response.new(
        client:         client,
        resource_class: Jsonism::Resources.const_get('Bot'),
        response:       res
      )
    end

    private

    def client
      @client ||= Jsonism::Client.new(schema: @schema)
    end

    def headers
      {
        'User-Agent'  => "Atabodi v#{Atabodi::VERSION}",
      }
    end
  end

  class Bot < Client
    def initialize(api_token:)
      @api_token = api_token
      super()
    end

    private
    def headers
      super.merge('X-API-Token' => @api_token)
    end
  end
end
