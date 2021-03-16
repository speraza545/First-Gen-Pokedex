

# URL = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=151"

class API
    URL = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=151"
    def self.get_pokemon
        uri = URI.parse(URL)
        response = Net::HTTP.get_response(uri)
        pokemon_hash = JSON.parse(response.body)
        pokemon_array = pokemon_hash["results"]

        pokemon = pokemon_array.collect do |pkmn|
            Pokemon.new(pkmn)
        end
    end

    #get individual pokemon info when requested
    def self.load_character_details(pokemon)
        uri = URI.parse(pokemon.url)
        response = Net::HTTP.get_response(uri)
        pokemon_hash = JSON.parse(response.body)
        
        pokemon.stats = pokemon_hash["stats"].collect do |stat|
            var = stat["stat"]["name"], stat["base_stat"]
        end

        pokemon.type = pokemon_hash["types"].collect do |type|
            type["type"]["name"]
        end

        pokemon.height = pokemon_hash["height"]

        pokemon.abilities = pokemon_hash["abilities"].collect do |ability|
            ability["ability"]["name"]
        end
        
        pokemon.moves = pokemon_hash["moves"].collect do |move|
            move["move"]["name"]
        end

        pokemon.weight = pokemon_hash["weight"]

        pokemon.id = pokemon_hash["id"]
    end
end

# def self.load_character_details(pokemon)
#     uri = URI.parse(pokemon.url)
#     response = Net::HTTP.get_response(uri)
#     pokemon_hash = JSON.parse(response.body)
    
#     stats_array = pokemon_hash["stats"].collect do |stat|
#         var = stat["stat"]["name"], stat["base_stat"]
#     end
#     Pokemon.stats = stats_array
#     binding.pry
# end
