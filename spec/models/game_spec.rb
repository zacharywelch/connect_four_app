require 'rails_helper'

describe Game do

  subject(:game) { create :game }

  it { is_expected.to respond_to :blue_player }
  it { is_expected.to respond_to :red_player }
  it { is_expected.to respond_to :turn }
  it { is_expected.to respond_to :moves }
  it { is_expected.to respond_to :board }
  it { is_expected.to respond_to :over? }

  it { is_expected.to validate_presence_of :blue_player }
  it { is_expected.to validate_presence_of :red_player }

  it { is_expected.to_not be_over }

  context 'when four in a row' do
    before do
      4.times { |column| create :move, game: game, row: 0, column: column }
    end
    it { is_expected.to be_over }
  end

  describe 'taking turns' do    
    it 'starts with blue player' do
      expect(game.turn).to eq game.blue_player
    end
    
    describe '#next_turn' do
      before { game.next_turn }
      it 'switches to next player' do
        expect(game.turn).to eq game.red_player
      end
    end
  end
end
