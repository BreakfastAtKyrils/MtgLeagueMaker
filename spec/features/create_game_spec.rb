require 'rails_helper'

RSpec.describe 'games/create' do
  let!(:players) do
    create_list(:player, 6) do |player, index|
      unique_id = index + 1
      player.id = unique_id
      player.name = "player#{unique_id}"
      player.save
    end
  end

  let!(:decks) do
    create_list(:deck, 6) do |deck, index|
      unique_id = index + 1
      deck.id = unique_id
      deck.name = "deck#{unique_id}"
      deck.player_id = unique_id
      deck.save
    end
  end

  before do
    visit games_path
  end

  context 'when clicking the create game button' do
    before do
      click_on 'Create a New Game'
    end

    it 'navitages to the new game form' do
      expect(page).to have_current_path(new_game_path)
    end
  end

  context 'when submitting the form' do
    context 'with 6 players' do
      before do
        click_on 'Create a New Game'
        game_played_at(Date.current)
        game_state(:completed)
        input_game_results(
          amount_of_player_spots: 6,
          amount_of_players: 6,
          players: players,
          decks: decks,
          results: %i[draw draw draw draw draw draw]
        )

        click_button 'Create Game'
      end

      it 'redirects to the list of games' do
        expect(page).to have_current_path(games_path)
      end

      it 'displays a success notice message' do
        visit games_path
        expect(page).to have_content('New game successfully added to the database.')
      end

      it 'displays the game in the list of games' do
        visit games_path
        expect(page).to have_content(Date.current.strftime('%d %B, %Y'))
      end
    end

    context 'without a date' do
      before do
        click_on 'Create a New Game'
        game_played_at(nil)
        game_state(:completed)

        input_game_results(
          amount_of_player_spots: 6,
          amount_of_players: 6,
          players: players,
          decks: decks,
          results: %i[draw draw draw draw draw draw]
        )

        click_button 'Create Game'
      end

      it 'stays on the form' do
        expect(page).to have_current_path(new_game_path)
      end

      it 'displays an error message' do
        expect(page).to have_content('Must enter a valid date')
      end
    end

    context 'with no wins or draws for a completed game' do
      before do
        click_on 'Create a New Game'
        game_played_at(Date.current)

        input_game_results(
          amount_of_player_spots: 6,
          amount_of_players: 6,
          players: players,
          decks: decks,
          results: %i[loss loss loss loss loss loss]
        )

        click_button 'Create Game'
      end

      it 'stays on the form' do
        expect(page).to have_current_path(new_game_path)
      end

      it 'displays an error message' do
        expect(page).to have_content('Must have 1 winner or at least 2 draws')
      end
    end

    context 'with 2 players' do
      before do
        click_on 'Create a New Game'
        game_played_at(Date.current)

        input_game_results(
          amount_of_player_spots: 6,
          amount_of_players: 2,
          players: players,
          decks: decks,
          results: %i[draw draw]
        )

        click_button 'Create Game'
      end

      it 'redirects to the list of games' do
        expect(page).to have_current_path(games_path)
      end

      it 'displays a success notice message' do
        visit games_path
        expect(page).to have_content('New game successfully added to the database.')
      end

      it 'displays the game in the list of games' do
        visit games_path
        expect(page).to have_content(Date.current.strftime('%d %B, %Y'))
      end

      it 'creates a game with 2 game records' do
        game = Game.last
        expect(game.game_records.to_a.count).to eq(2)
      end
    end

    context 'with 1 player' do
      before do
        click_on 'Create a New Game'
        game_played_at(Date.current)

        input_game_results(
          amount_of_player_spots: 6,
          amount_of_players: 1,
          players: players,
          decks: decks,
          results: %i[draw]
        )

        click_button 'Create Game'
      end

      it 'stays on the form' do
        expect(page).to have_current_path(new_game_path)
      end

      it 'displays an error message' do
        expect(page).to have_content('Must have 2 or more players')
      end
    end
  end
end
