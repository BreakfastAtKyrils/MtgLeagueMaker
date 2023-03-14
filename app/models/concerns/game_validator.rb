class GameValidator < ActiveModel::Validator
  def validate(game)
    validate_results_presence_if_completed(game)
    validate_2_or_more_players_if_completed(game)
    validate_no_duplicate_player(game)
    validate_no_duplicate_deck(game)
    validate_no_single_draw(game)
    validate_no_draws_if_winner_if_completed(game)
    validate_not_all_losses(game)
  end

  private

  def validate_2_or_more_players_if_completed(game)
    return unless game[:state] && game[:state].to_sym == :completed
    return if game.game_records.to_a.count > 1

    game.errors.add(:game_records, 'Must have 2 or more players')
  end

  def validate_no_duplicate_player(game)
    player_ids = player_ids(game)
    return unless player_ids.uniq.length != player_ids.length

    game.errors.add(:game_records, 'Cannot have duplicate players')
  end

  def validate_no_duplicate_deck(game)
    deck_ids = deck_ids(game)
    return unless deck_ids.uniq.length != deck_ids.length

    game.errors.add(:game_records, 'Cannot have duplicate decks')
  end

  def validate_no_draws_if_winner_if_completed(game)
    return unless game[:state] && game[:state].to_sym == :completed
    return unless wins(game).positive? && draws(game).positive?

    game.errors.add(:game_records, 'Cannot have any draws if there is at least 1 winner')
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

  def validate_no_single_draw(game)
    draws = draws(game)
    return unless draws == 1

    game.errors.add(:game_records, 'Cannot have less than 2 players with a draw')
  end

  def validate_not_all_losses(game)
    losses = losses(game)
    return unless losses == game.game_records.to_a.count

    game.errors.add(:game_records, 'Must have 1 winner or at least 2 draws')
  end

  def results(game)
    results = []

    game.game_records.each do |game_record|
      next if game_record[:result].nil?

      result = game_record[:result].to_sym
      results.append(result)
    end

    results
  end

  def wins(game)
    wins = 0

    game.game_records.each do |game_record|
      next if game_record[:result].nil?

      wins += 1 if game_record[:result].to_sym == :win
    end

    wins
  end

  def draws(game)
    draws = 0

    game.game_records.each do |game_record|
      next if game_record[:result].nil?

      draws += 1 if game_record[:result].to_sym == :draw
    end

    draws
  end

  def losses(game)
    losses = 0

    game.game_records.each do |game_record|
      next if game_record[:result].nil?

      losses += 1 if game_record[:result].to_sym == :loss
    end

    losses
  end

  def deck_ids(game)
    submitted_deck_ids = []

    game.game_records.each do |game_record|
      deck_id = game_record[:deck_id].to_i
      submitted_deck_ids.push(deck_id)
    end

    submitted_deck_ids
  end

  def player_ids(game)
    submitted_player_ids = []

    game.game_records.each do |game_record|
      player_id = game_record[:player_id].to_i
      submitted_player_ids.push(player_id)
    end

    submitted_player_ids
  end
end
