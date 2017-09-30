require "spec_helper"

describe 'the store creation path', {:type => :feature} do
  it 'takes the user to the page where they can create a store' do
    # An inelegant solution to my capybara authorization issues
    visit '/sign_in'
    fill_in('username', :with => 'admin')
    fill_in('pass', :with => 'isarubyist')
    click_button('Login')
    click_link 'Stores' # redirects home
    ###########################################################
    fill_in('name', :with => 'Kyle\'s Kicks')
    click_button('Save New Store')
    expect(page).to have_content('Kyle\'s Kicks')
  end
end

describe 'the brand creation path', {:type => :feature} do
  it 'takes the user to the page where they can create a brand' do
    # An inelegant solution to my capybara authorization issues
    visit '/sign_in'
    fill_in('username', :with => 'admin')
    fill_in('pass', :with => 'isarubyist')
    click_button('Login')
    click_link 'Brands'
    ###########################################################
    fill_in('name', :with => 'Super Shoes')
    fill_in('price', :with => '37.99')
    click_button('Save New Brand')
    expect(page).to have_content('Super Shoes')
  end
end

describe 'the error alert feature', {:type => :feature} do
  it 'shows an error when an input is blank' do
    # An inelegant solution to my capybara authorization issues
    visit '/sign_in'
    fill_in('username', :with => 'admin')
    fill_in('pass', :with => 'isarubyist')
    click_button('Login')
    click_link 'Brands'
    ###########################################################
    fill_in('name', :with => 'Super Shoes')
    fill_in('price', :with => '')
    click_button('Save New Brand')
    expect(page).to have_content('can\'t be blank')
  end

  it 'shows an error when a duplicate entry is added' do
    # An inelegant solution to my capybara authorization issues
    visit '/sign_in'
    fill_in('username', :with => 'admin')
    fill_in('pass', :with => 'isarubyist')
    click_button('Login')
    click_link 'Brands'
    ###########################################################
    fill_in('name', :with => 'Super Shoes')
    fill_in('price', :with => '99.99')
    click_button('Save New Brand')
    # Same brand, diff price
    fill_in('name', :with => 'Super Shoes')
    fill_in('price', :with => '65.00')
    click_button('Save New Brand')
    expect(page).to have_content('already been taken')
  end
end

describe 'the store update path', {:type => :feature} do
  it 'allows a user to change the name of the store' do
    test_store = Store.new({:name => 'Daves\'s Shoes Emporium'})
    test_store.save
    # An inelegant solution to my capybara authorization issues
    visit '/sign_in'
    fill_in('username', :with => 'admin')
    fill_in('pass', :with => 'isarubyist')
    click_button('Login')
    click_link 'Stores'
    ###########################################################
    click_link('Edit Store')
    fill_in('name', :with => 'Kyle\'s Kicks')
    click_button('Confirm')
    expect(page).to have_content('Kyle\'s Kicks')
  end
end

describe 'the store delete path', {:type => :feature} do
  it 'allows a user to delete a project' do
    test_store = Store.new({:name => 'Dave\'s Shoes Emporium'})
    test_store.save
    # An inelegant solution to my capybara authorization issues
    visit '/sign_in'
    fill_in('username', :with => 'admin')
    fill_in('pass', :with => 'isarubyist')
    click_button('Login')
    click_link 'Stores'
    ###########################################################
    click_button("#{test_store.name}")
    expect(page).not_to have_content('Dave\'s Shoes Emporium')
  end
end

describe 'the store brands page', {:type => :feature} do
  it 'shows all brands a store carries' do
    test_store = Store.new({:name => 'Dave\'s Shoes Emporium'})
    test_store.save
    store_id = test_store.id
    test_shoe = Brand.new({:name => 'Ruttes', :price => "34.65"})
    test_shoe.save
    # An inelegant solution to my capybara authorization issues
    visit '/sign_in'
    fill_in('username', :with => 'admin')
    fill_in('pass', :with => 'isarubyist')
    click_button('Login')
    ###########################################################
    visit "/store/brands/#{store_id}"
    expect(page).to have_content('Ruttes')
  end
end
