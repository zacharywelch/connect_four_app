require 'rails_helper'

describe MovePresenter do
  include ActionView::TestCase::Behavior
  
  let(:game) { create :game }
  let(:move) { create :move, game: game, row: 0, column: 0, value: 'x' }
  
  subject(:presenter) do
    MovePresenter.new({ game: game, row: move.row, column: move.column }, view)
  end
  
  it { is_expected.to respond_to :game }
  it { is_expected.to respond_to :row }
  it { is_expected.to respond_to :column }
  it { is_expected.to respond_to :move }
  it { is_expected.to respond_to :available? }
  it { is_expected.to respond_to :color }
  it { is_expected.to respond_to :value }

  describe '#color' do
    context 'when value is x' do
      it 'returns blue' do
        expect(presenter.color).to eq 'bg-primary'
      end
    end

    context 'when value is o' do
      let(:move) { create :move, game: game, row: 0, column: 0, value: 'o' }
      it 'returns red' do
        expect(presenter.color).to eq 'bg-danger'
      end
    end

    context 'when move is not taken' do
      subject(:presenter) do
        MovePresenter.new({ game: game, row: 5, column: 5 }, view)
      end
      it 'returns nil' do
        expect(presenter.color).to be_nil
      end      
    end
  end

  describe '#value' do
    context 'when move is taken' do
      it 'returns move' do
        expect(presenter.value).to eq move.value
      end
    end

    context 'when move is not taken' do
      subject(:presenter) do
        MovePresenter.new({ game: game, row: 5, column: 5 }, view)
      end

      context 'when game is over' do
        before do 
          allow_any_instance_of(Game).to receive(:over?).and_return(true)
        end
        it 'returns nil' do
          expect(presenter.value).to be_nil  
        end
      end

      context 'when blue player''s turn' do
        before { game.turn = game.blue_player }
        it 'returns x' do
          expect(presenter.value).to eq 'x'
        end      
      end

      context 'when red player''s turn' do
        before { game.turn = game.red_player }
        it 'returns o' do
          expect(presenter.value).to eq 'o'
        end      
      end
    end
  end
end