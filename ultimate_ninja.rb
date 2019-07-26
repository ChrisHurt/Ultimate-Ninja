require 'pry'
require 'timeout'

def auto_ninja num_players
    players = []
    player_turns_taken = []
    exit_game = false

    puts 
    puts "To quit the game, press 'q' and enter"
    puts "To pause the game and eliminate players, press 'p' and enter"

    if num_players.class == Integer
        num_players.times do |num|
            players << num + 1
            player_turns_taken << false
        end
    else 
        num_players.times do |num|
            players << num + 1
            player_turns_taken << false
        end
    end

    puts ""
    print players
    puts ""
    puts ""

    while players.length > 1 && exit_game == false
        player_turn_taken = false
        while player_turn_taken == false
            random_index = (rand*(players.length)).floor

            if (player_turns_taken.select{|player_turn_taken| player_turn_taken == true}.length == players.length)
                player_turns_taken = []
                players.length.times do
                    player_turns_taken << false
                end 
            end 
            if player_turns_taken[random_index] == false
                player_turns_taken[random_index] = true
                player_turn_taken = true
                `say "Ninja #{players[random_index]}"`
                puts "Ninja #{players[random_index]}"
                puts ""
            end
        end
        puts "Type 'q' and enter to quit"
        puts "Type player number to remove them"
        puts "Otherwise, press enter to continue"
        input = gets.chomp
        puts
        case input

        when 'q'
            exit_game = true
        else
            players_still_to_be_removed = ''
            while input != 'n' && input != "" && players.length > 1 && exit_game == false
                if players.include?(input.to_i)
                    players.delete_at(players.index(input.to_i))
                    puts "Player #{input.to_i} eliminated."
                    player_turns_taken = []
                    players.length.times do
                        player_turns_taken << false
                    end
                    if players.length == 1 || input == 'q'
                        exit_game = true
                    end
                else 
                    puts "Not a player."
                end
                puts 
                print players
                puts
                if players.length > 1
                    puts "Which player number was eliminated? (n or '' to exit)"
                    input = gets.chomp
                end
            end
        end
    end
    if players.length == 1
        `say "Ninja #{players[0]} wins!"`
        puts "Ninja #{players[0]} wins!"
    end
end

binding.pry