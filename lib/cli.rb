require "pry"

class CLI
    def run
        #greet user
        greeting
        # call get_pokemon
        API.get_pokemon
        # call list of pokemon
        page_switcher
    end

    def greeting
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
        # tell user what to do
        puts "
            Please choose a pokemon from the list below"
        puts " "
    end

    def page_switcher
        current_page = 0
        list_pokemon
        puts " "
        instructions = "    Please type next or prev to see more pokemon. When you are ready\n             to make a selection type stop, or type exit"
        puts instructions
        input = gets.strip
        while input.downcase != "stop"
            if input.downcase == "next"
                current_page += 1
                if current_page > Pokemon.all.count/20.to_i || current_page < 0
                    current_page = 0
                end
                greeting
                list_pokemon(current_page)
                puts " "
                puts instructions
                input = gets.strip
            elsif input.downcase == "prev"
                current_page -=1
                if current_page > Pokemon.all.count/20.to_i || current_page < 0
                    current_page = Pokemon.all.count/20.to_i
                end
                greeting
                list_pokemon(current_page)
                puts " "
                puts instructions
                input = gets.strip
            elsif input.downcase == "exit"
                goodbye
                exit
            else 
                puts "invalid input, type next, prev, stop, or exit"
                input = gets.strip
            end
        end
        menu
    end

    def list_pokemon(current_page=0)
        revised_pokemon_list = Pokemon.all.each_slice(20).to_a
        revised_pokemon_list[current_page].each do |pokemon|
            puts "                             #{pokemon.url.gsub("v2", "").match(/\d+/)}) #{pokemon.name}"
        end
        # # call pokemon.all and loop it to list pokemon
        # Pokemon.all.each.with_index(1) do |pkmn, i|
        #     puts "
        #                     #{i}) #{pkmn.name}"
        # end
    end
    def menu
        puts "
                Please choose a number between 1 and #{Pokemon.all.count}\n            (or type in the pokemon's name) to see more info. \n                   Type back to scroll through pokemon\n                       Or type exit at any time."
        input =  gets.strip
        # make sure user input is good
        # checks if user input is between 1 and the count of the array we are using
        if input.downcase == "exit"
            goodbye
            exit
        else
            if !input.to_i.between?(1, Pokemon.all.count)
                if input.downcase == "back"
                    greeting
                    page_switcher
                else
                    desired_pokemon = ""
                    Pokemon.all.each do |pokemon|
                        desired_pokemon = pokemon if pokemon.name == input.downcase
                    end
                    desired_pokemon == "" ? menu : display_pokemon_details(desired_pokemon)
                end
            else
                # if valid, it grabs the pokemon details
                pokemon = Pokemon.all[input.to_i-1]
                display_pokemon_details(pokemon)
            end
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
            greeting
            page_switcher
        elsif input.capitalize == "N"
            goodbye
            exit
        else
            search_again
        end
    end

    def goodbye
        puts "
         _____ _           _                     ___           
        |_   _| |_ ___ ___| |_    _ _ ___ _ _   |  _|___ ___   
          | | |   | .'|   | '_|  | | | . | | |  |  _| . |  _|  
          |_| |_|_|__,|_|_|_,_|  |_  |___|___|  |_| |___|_|    
         _ _ ___|_|___ ___    ___|___|___    ___ ___ ___       
        | | |_ -| |   | . |  | . | | |  _|  | .'| . | . |      
        |___|___|_|_|_|_  |  |___|___|_|    |__,|  _|  _|      
                      |___|                     |_| |_|  "

    end

end