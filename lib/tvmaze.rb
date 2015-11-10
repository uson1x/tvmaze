require 'rest-client'
require 'json'
require 'tvmaze/show'
require 'tvmaze/episode'
require 'tvmaze/season'

module TVMaze
  @@api_base = 'http://api.tvmaze.com'

  def self.request(path, params = {})
    url = @@api_base + path
    res = RestClient.get(url, params: params) do |response, request, result, &block|
      case response.code
      when 200
        response.return!(request, result, &block)
      when 401
        fail TVMaze::Unauthorized
      when 403
        fail TVMaze::Forbidden
      when 404
        fail TVMaze::NotFound
      end
    end
    JSON.parse(res)
  end
end
