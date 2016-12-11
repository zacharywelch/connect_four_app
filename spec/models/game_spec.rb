require 'rails_helper'

describe Game do

  subject(:game) { create :game }

  it { is_expected.to respond_to :player_one }
  it { is_expected.to respond_to :player_two }
  it { is_expected.to respond_to :moves }

  it { is_expected.to validate_presence_of :player_one }
  it { is_expected.to validate_presence_of :player_two }
end
