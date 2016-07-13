require('capybara/rspec')
require('./app')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the trains path', {:type => :feature}) do
  it('render the page that displays a list of trains') do
    visit('/')
    click_on("View Trains")
    expect(page).to have_content("Trains")
  end
end

describe('the new train path', {:type => :feature}) do
  it('adds a new train to the transit system') do
    visit('/trains')
    click_on("Add Train")
    expect(page).to have_content("Add A Train")
    fill_in('line', :with => 1)
    fill_in('seats', :with => 250)
    click_button("Submit")
    expect(page).to have_content("Transit System")
  end
end

describe('the specific train path', {:type => :feature}) do
  it('shows a specific trains attributes in a list format') do
    train1 = Train.new({line: 60, seats: 30})
    train1.save()
    visit('/trains')
    click_on(train1.line())
    expect(page).to have_content('Seats: 30')
  end

  it('allows the user to edit a particular train') do
    train1 = Train.new({line: 60, seats: 30})
    train1.save()
    visit("/trains/#{train1.id()}")
    click_on("Edit")
    expect(page).to have_content("Edit Train: #{train1.line()}")
    fill_in('line', :with => 2)
    fill_in('seats', :with => 400)
    click_on("Update")
    expect(page).to have_content('Update successful!')
  end
end
