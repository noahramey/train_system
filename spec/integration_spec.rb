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
