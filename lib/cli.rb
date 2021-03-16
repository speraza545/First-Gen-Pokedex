class CLI
    def run
        #greet user
        puts "
                ────────▄███████████▄──────── 
                ─────▄███▓▓▓▓▓▓▓▓▓▓▓███▄─────
                ────███▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███────
                ───██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██───
                ──██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██──
                ─██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██─
                ██▓▓▓▓▓▓▓▓▓███████▓▓▓▓▓▓▓▓▓██
                ██▓▓▓▓▓▓▓▓██░░░░░██▓▓▓▓▓▓▓▓██
                ██▓▓▓▓▓▓▓██░░███░░██▓▓▓▓▓▓▓██
                ███████████░░███░░███████████
                ██░░░░░░░██░░███░░██░░░░░░░██
                ██░░░░░░░░██░░░░░██░░░░░░░░██
                ██░░░░░░░░░███████░░░░░░░░░██
                ─██░░░░░░░░░░░░░░░░░░░░░░░██─
                ──██░░░░░░░░░░░░░░░░░░░░░██──
                ───██░░░░░░░░░░░░░░░░░░░██───
                ────███░░░░░░░░░░░░░░░███────
                ─────▀███░░░░░░░░░░░███▀─────
                ────────▀███████████▀────────"
        puts " "
        puts " 
         _ _ _     _                          _         
        | | | |___| |___ ___ _____ ___       | |_ ___   
        | | | | -_| |  _| . |     | -_|      |  _| . |  
        |_____|___|_|___|___|_|_|_|___|      |_| |___|  
                                                        
                                                        
         _   _              _____ _         _           
        | |_| |_ ___       |   __|_|___ ___| |_         
        |  _|   | -_|      |   __| |  _|_ -|  _|        
        |_| |_|_|___|      |__|  |_|_| |___|_|          
                                                        
                                                        
         _____            _____     _         _         
        |   __|___ ___   |  _  |___| |_ ___ _| |___ _ _ 
        |  |  | -_|   |  |   __| . | '_| -_| . | -_|_'_|
        |_____|___|_|_|  |__|  |___|_,_|___|___|___|_,_|"
        puts " "
        puts " "
        # tell user what to do
        puts "
            Please choose a pokemon from the list below"
        puts " "
        # call get_pokemon
        API.get_pokemon
        # call list of pokemon
        list_pokemon
        menu
    end

    def list_pokemon
        # call pokemon.all and loop it to list pokemon
        Pokemon.all.each.with_index(1) do |pkmn, i|
            puts "
                            #{i}) #{pkmn.name}"
        end
    end

    def menu
        puts "
            Please choose a number between 1 and #{Pokemon.all.count} to see more info"
        input =  gets.strip
        # make sure user input is good
        if !input.to_i.between?(1, Pokemon.all.count)
            menu
        else
            pokemon = Pokemon.all[input.to_i-1]
            display_pokemon_details(pokemon)
        end
    end

    def display_pokemon_details(pokemon)
        API.load_character_details(pokemon)
        puts "Name: \n #{pokemon.name.capitalize}"
        puts "\nId: \n #{pokemon.id}"
        puts "\nType: \n"
        pokemon.type.each do |each_type|
            puts " #{each_type.capitalize}"
        end
        puts "\nHeight: \n #{pokemon.height}"
        puts "\nWeight: \n #{pokemon.weight}"
        puts "\nAbilities: \n"
        pokemon.abilities.each do |each_ability|
            puts " #{each_ability.capitalize}"
        end
        puts "\nStats: \n"
        pokemon.stats.each do |each_stat|
            puts " #{each_stat[0].capitalize}: #{each_stat[1]}"
        end
        puts "\nPossible moves: \n"
        pokemon.moves.each do |move|
            split_move = move.split("-")
            if split_move.length <= 1
                print " #{split_move[0]},"
            else
             print " #{split_move[0]} #{split_move[1]},"
            end
        end
        puts " "
        puts " "
        search_again?
    end

    def search_again?
        puts "Would you like to look up another pokemon? (Y/N)"
        input = gets.strip
        if input.capitalize == "Y"
            list_pokemon
            menu
        elsif input.capitalize == "N"
            exit
        else
            search_again
        end
    end
end