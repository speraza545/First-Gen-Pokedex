

class Pokemon
    attr_accessor :name, :url, :abilities, :height, :moves, :type, :stats, :weight, :id
    
    # :hp, :attack, :defense, :special_attack, :special_defense, :speed

    @@all = []

    def initialize(pkmn)
        @name = pkmn["name"]
        @url = pkmn["url"]
        @@all << self
    end

    def self.all
        @@all
    end

    # def self.stats=(stats_array)
    #     @stats = stats_array.map { |key, value| [key, value]}
    # end
end