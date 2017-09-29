require "spec_helper"

RSpec.describe(Inventory) do
  it { should belong_to(:store) }
  it { should belong_to(:brand) }
end
