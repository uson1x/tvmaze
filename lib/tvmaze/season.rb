module TVMaze
  class Season
    attr_accessor :number, :episodes

    def initialize
      @episodes = []
    end

    def self.from_episodes(episodes)
      seasons = []
      episodes.each do |e|
        next if e.season.nil?
        season = seasons.find { |s| s.number == e.season }
        if season.nil?
          season = Season.new
          season.number = e.season
          seasons << season
        end
        season.episodes << e
      end
      seasons
    end
  end
end
