module TVMaze
  class Episode
    EPISODE_MAPPING = { id: :id, url: :url, name: :name, season: :season,
                        number: :number, airtime: :airtime, runtime: :runtime,
                        summary: :summary }

    EPISODE_MAPPING.values.each do |value|
      attr_accessor value
    end

    attr_accessor :image_medium, :image_original, :airdate, :airstamp

    def initialize(json = {})
      return if json.nil?

      EPISODE_MAPPING.each do |source, destination|
        send("#{destination}=", json[source.to_s] || json[source.to_sym])
      end

      @airdate = Date.parse(json['airdate']) unless json['airdate'].nil?
      @airstamp = DateTime.parse(json['airstamp']) unless json['airstamp'].nil?

      unless json['image'].nil?
        @image_original = json['image']['original']
        @image_medium   = json['image']['medium']
      end
    end
  end
end
