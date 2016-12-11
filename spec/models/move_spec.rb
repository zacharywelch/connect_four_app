require 'rails_helper'

describe Move do  

  subject(:move) { create :move }

  it { is_expected.to respond_to :row }
  it { is_expected.to respond_to :column }
  it { is_expected.to respond_to :value }
  it { is_expected.to respond_to :game }

  it { is_expected.to validate_presence_of :row }
  it { is_expected.to validate_presence_of :column }
  it { is_expected.to validate_presence_of :value }
  it { is_expected.to validate_presence_of :game }
  it { is_expected.to validate_inclusion_of(:row).in_range(0..5) }
  it { is_expected.to validate_inclusion_of(:column).in_range(0..6) }
  it { is_expected.to validate_uniqueness_of(:row).scoped_to(:game_id, :column) }
  it { is_expected.to validate_uniqueness_of(:column).scoped_to(:game_id, :row) }

  describe 'availablity' do
    
    let(:game) { create :game }
    
    context 'when space is the next available' do
      before { create :move, row: 0, column: 0, game: game }
      subject(:move) { build :move, row: 1, column: 0, game: game }
      it { is_expected.to be_valid }
    end

    context 'when space is not the next available' do
      before { create :move, row: 0, column: 0, game: game }
      subject(:move) { build :move, row: 2, column: 0, game: game }
      it { is_expected.to_not be_valid }
    end
  end
end
