require "spec_helper"

RSpec.describe(Store) do
  it { should have_many :inventories }
  it { should have_many :brands }

  it 'will capitalize every word in the a string' do
    my_store = Store.new({:name => "dave's shoes emporium"})
    my_store.save
    expect(my_store.name).to eq "Dave's Shoes Emporium"
  end
end
