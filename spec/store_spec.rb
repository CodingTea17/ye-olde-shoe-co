require "spec_helper"

RSpec.describe(Store) do
  it { should have_many :inventories }
  it { should have_many :brands }
end
