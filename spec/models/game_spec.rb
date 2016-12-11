require 'rails_helper'

describe Game do

  subject(:game) { create :game }

  it { is_expected.to respond_to :player_one }
  it { is_expected.to respond_to :player_two }
  it { is_expected.to respond_to :moves }
  it { is_expected.to respond_to :board }
  it { is_expected.to respond_to :over? }

  it { is_expected.to validate_presence_of :player_one }
  it { is_expected.to validate_presence_of :player_two }

  it { is_expected.to_not be_over }

  context 'when four in a row' do
    before do
      4.times { |column| create :move, game: game, row: 0, column: column }
    end
    it { is_expected.to be_over }
  end
end
