class GameValidator < ActiveModel::Validator
  def validate(game)
    validate_results_presence_if_completed(game)
    validate_2_or_more_players_if_completed(game)
    validate_no_duplicate_player(game)
    validate_no_duplicate_deck(game)
    validate_at_least_2_draws(game)
    validate_max_1_winner(game)
    validate_not_all_losses(game)
  end

  private

  def validate_2_or_more_players_if_completed(game)
    return unless game[:state] && game[:state].to_sym == :completed
    return if game.game_records.to_a.count > 1

    game.errors.add(:game_records, 'Must have 2 or more players')
  end

  def validate_no_duplicate_player(game)
    submitted_player_ids = []

    game.game_records.each do |game_record|
      player_id = game_record[:player_id].to_i

      game.errors.add(:game_records, 'Cannot have duplicate players') if submitted_player_ids.include?(player_id)

      submitted_player_ids.push(player_id)
    end
  end

  def validate_no_duplicate_deck(game)
    submitted_deck_ids = []

    game.game_records.each do |game_record|
      deck_id = game_record[:deck_id].to_i

      game.errors.add(:game_records, 'Cannot have duplicate decks') if submitted_deck_ids.include?(deck_id)

      submitted_deck_ids.push(deck_id)
    end
  end

  def validate_max_1_winner(game)
    wins = 0

    game.game_records.each do |game_record|
      next if game_record[:result].nil?

      result = game_record[:result].to_sym

      wins += 1 if result == :win
    end

    game.errors.add(:game_records, 'Cannot have more than 1 player with a win result') if wins > 1
  end

  def validate_results_presence_if_completed(game)
    return unless game[:state] && game[:state].to_sym == :completed

    game.game_records.each do |game_record|
      if game_record[:result].nil?
        game.errors.add(:game_records,
          'All players must have a result for a completed game')
      end
    end
  end

  def validate_at_least_2_draws(game)
    draws = 0

    game.game_records.each do |game_record|
      next if game_record[:result].nil?

      result = game_record[:result].to_sym

      draws += 1 if result == :draw
    end

    game.errors.add(:game_records, 'Cannot have less than 2 players with a draw') if draws == 1
  end

  def validate_not_all_losses(game)
    losses = 0

    game.game_records.each do |game_record|
      next if game_record[:result].nil?

      result = game_record[:result].to_sym

      losses += 1 if result == :loss
    end

    game.errors.add(:game_records, 'Must have 1 winner or at least 2 draws') if losses == game.game_records.to_a.count
  end
end
