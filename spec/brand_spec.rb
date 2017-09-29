require "spec_helper"

RSpec.describe(Brand) do
  it { should have_many :inventories }
  it { should have_many :stores }

  it 'will capitalize every word in the a string' do
    my_brand = Brand.new({:name => "super shoes", :price => "25.09"})
    my_brand.save
    expect(my_brand.name).to eq "Super Shoes"
  end

  it 'will format a number to currencys' do
    my_brand = Brand.new({:name => "super shoes", :price => "25"})
    my_brand.save
    expect(my_brand.price).to eq "25.00"
  end
end
