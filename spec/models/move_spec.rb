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
end
