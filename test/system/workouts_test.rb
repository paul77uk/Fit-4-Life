require 'application_system_test_case'

class WorkoutsTest < ApplicationSystemTestCase
  setup do
    @workout = Workout.ordered.first # Reference to the first fixture workout
  end

  test 'Creating a new workout' do
    # When we visit the Quotes#index page
    # we expect to see a title with the text "Workouts"
    visit workouts_path
    assert_selector 'h1', text: 'Workouts'

    # When we click on the link with the text "New Workout
    # we expect to stay on the same page with the title "Workouts"
    click_on 'New workout'

    # When we fill in the name input with "Capybara workout
    # and we click on "Create Workout"
    fill_in 'Name', with: 'Capybara workout'

    assert_selector 'h1', text: 'Workouts'
    click_on 'submit'

    # We expect to still be on the same page with the title "Workout"
    # and to see our "Capybara workout" added to the list
    assert_selector 'h1', text: 'Workouts'
    assert_text 'Capybara workout'
  end

  test 'Showing a workout' do
    visit workouts_path
    click_link @workout.name

    assert_selector 'h1', text: @workout.name
  end

  test 'Updating a workout' do
    visit workouts_path
    assert_selector 'h1', text: 'Workouts'

    click_on 'Edit', match: :first
    fill_in 'Name', with: 'Updated workout'

    assert_selector 'h1', text: 'Workouts'
    click_on 'submit'

    assert_selector 'h1', text: 'Workouts'
    assert_text 'Updated workout'
  end

  test 'Destroying a workout' do
    visit workouts_path
    assert_text @workout.name

    click_on 'Delete', match: :first
    assert_no_text @workout.name
  end
end
