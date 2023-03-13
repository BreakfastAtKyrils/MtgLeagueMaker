RSpec.describe GameValidator do
  describe '#validate' do
    context 'when there is less than 2 game records' do
      let(:game) { build(:game_with_records, state: :completed, game_records_count: 1) }

      it 'is invalid' do
        expect(game.valid?).to be false
      end

      it 'raises the correct error' do
        game.save
        expect(game.errors.messages[:game_records]).to include('Must have 2 or more players')
      end
    end

    context 'when there are duplicate player ids' do
      let(:player) { build(:player) }
      let(:decks) do
        build_list(:deck, 2) do |deck, index|
          deck.id = 1 + index
          deck.save!
        end
      end
      let(:game_record1) { build(:game_record, player: player, deck_id: 1) }
      let(:game_record2) { build(:game_record, player: player, deck_id: 2) }
      let(:game) { build(:game, state: :completed) }

      before do
        game.game_records << game_record1
        game.game_records << game_record2
      end

      it 'is invalid' do
        expect(game.valid?).to be false
      end

      it 'raises the correct error' do
        game.save
        expect(game.errors.messages[:game_records]).to include('Cannot have duplicate players')
      end
    end

    context 'when there are duplicate deck ids' do
      let(:deck) { build(:deck) }
      let(:players) do
        build_list(:player, 2) do |player, index|
          player.id = 1 + index
          player.save!
        end
      end
      let(:game_record1) { build(:game_record, player_id: 1, deck: deck) }
      let(:game_record2) { build(:game_record, player_id: 2, deck: deck) }
      let(:game) { build(:game, state: :pending) }

      before do
        game.game_records << game_record1
        game.game_records << game_record2
      end

      it 'is invalid' do
        expect(game.valid?).to be false
      end

      it 'raises the correct error' do
        game.save
        expect(game.errors.messages[:game_records]).to include('Cannot have duplicate decks')
      end
    end

    context 'when there is only 1 draw for a completed game' do
      let(:game_record1) { build(:game_record, result: :draw) }
      let(:game_record2) { build(:game_record, result: :loss) }
      let(:game) { build(:game, state: :completed) }

      before do
        game.game_records << game_record1
        game.game_records << game_record2
      end

      it 'is invalid' do
        expect(game.valid?).to be false
      end

      it 'raises the correct error' do
        game.save
        expect(game.errors.messages[:game_records]).to include('Cannot have less than 2 players with a draw')
      end
    end

    context 'when there is more than 1 winner for a completed game' do
      let(:game_record1) { build(:game_record, result: :win) }
      let(:game_record2) { build(:game_record, result: :win) }
      let(:game) { build(:game, state: :completed) }

      before do
        game.game_records << game_record1
        game.game_records << game_record2
      end

      it 'is invalid' do
        expect(game.valid?).to be false
      end

      it 'raises the correct error' do
        game.save
        expect(game.errors.messages[:game_records]).to include('Cannot have more than 1 player with a win result')
      end
    end

    context 'when there are nul results for a completed game' do
      let(:game_record1) { build(:game_record, result: nil) }
      let(:game_record2) { build(:game_record, result: :win) }
      let(:game) { build(:game, state: :completed) }

      before do
        game.game_records << game_record1
        game.game_records << game_record2
      end

      it 'is invalid' do
        expect(game.valid?).to be false
      end

      it 'raises the correct error' do
        game.save
        expect(game.errors.messages[:game_records]).to include('All players must have a result for a completed game')
      end
    end
  end
end
