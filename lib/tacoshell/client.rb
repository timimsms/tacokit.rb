require 'forwardable'
require 'faraday'
require 'faraday_middleware'
require 'hashie/mash'

module Tacoshell
  class Client
    extend Forwardable

    def_delegators :configuration, *Configuration.keys

    API_ENDPOINT = "https://api.trello.com"

    def initialize(options = {})
      self.configuration.options = options
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def member(username)
      get "/1/members/#{username}", { key: app_key }
    end

    def get(url, options = {})
      request :get, url, options
    end

    def request(method, url, options)
      response = connection.send(method, url, options)
      response.body
    end

    def connection
      @connection = Faraday.new(url: API_ENDPOINT) do |http|
        http.response :mashify
        http.response :json
        http.response :logger
        http.adapter Faraday.default_adapter
      end
    end

  end
end
