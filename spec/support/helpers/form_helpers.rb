module FormHelpers
  def select_option(css_selector, value)
    find(:css, css_selector).find(:option, value).select_option
  end

  def fill_in_player_data(index, player_name:, deck_name:, result:)
    select_option("#game_game_records_attributes_#{index}_player_id", player_name)
    select_option("#game_game_records_attributes_#{index}_deck_id", deck_name)
    select_option("#game_game_records_attributes_#{index}_result", result)
  end

  def game_state(state)
    select_option('#game_state', state.to_s)
  end

  def game_played_at(date)
    fill_in 'game_played_at', with: date
  end

  def input_game_results(amount_of_player_spots:, amount_of_players:, players:, decks:, results:)
    amount_of_player_spots.times do |index|
      if index < amount_of_players
        player_name = players[index].name
        deck_name = decks[index].name
        fill_in_player_data(index, player_name: player_name, deck_name: deck_name, result: results[index])
      else
        find("#game_game_records_attributes_#{index}__destroy").set(true)
      end
    end
  end
end
