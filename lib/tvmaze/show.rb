module TVMaze
  class Show
    SHOW_MAPPING = { id: :id, url: :url, name: :name, type: :type,
                     language: :language, genres: :genres, status: :status,
                     runtime: :runtime, premiered: :premiered,
                     schedule: :schedule, rating: :rating, weight: :weight,
                     network: :network, webChannel: :web_channel,
                     summary: :summary, updated: :updated }

    SHOW_MAPPING.values.each do |value|
      attr_accessor value
    end

    attr_accessor :next_episode, :episodes, :image_medium, :image_original,
                  :seasons

    def initialize(json = {})
      @seasons = []
      @episodes = []

      return if json.nil?
      SHOW_MAPPING.each do |source, destination|
        send("#{destination}=", json[source.to_s] || json[source.to_sym])
      end

      unless json['image'].nil?
        @image_original = json['image']['original']
        @image_medium   = json['image']['medium']
      end

      unless json['_embedded'].nil?
        embedded_json = json['_embedded']
        @next_episode = TVMaze::Episode.new(embedded_json['nextepisode'])
        @episodes = parse_episodes(embedded_json['episodes'])
        @seasons = parse_seasons(@episodes)
      end
    end

    def self.search(query = '', params = {})
      params[:q] = query.to_s.strip
      result = TVMaze.request('/search/shows', params)
      build_search_results(result)
    end

    def self.find(id, params = {})
      embed = params.delete(:embed)
      embed ||= []
      result = TVMaze.request(find_url(id, embed), params)
      Show.new(result)
    end

    protected

    def self.find_url(id, embeds_array = [])
      url = "/shows/#{id}"

      prefix = 'embed'
      prefix << '[]' if embeds_array.count > 1
      query = embeds_array.map { |e| prefix + '=' + e }.join('&')

      [url, query].compact.join('?')
    end

    def self.build_search_results(search_results_json)
      search_results_json.map { |entry_json| Show.new(entry_json['show']) }
    end

    def parse_episodes(json_array)
      return [] if json_array.nil? || json_array.count == 0
      json_array.map { |episode_json| TVMaze::Episode.new(episode_json) }
    end

    def parse_seasons(json_array)
      return [] if json_array.nil? || json_array.count == 0
      TVMaze::Season.from_episodes(json_array)
    end
  end
end
