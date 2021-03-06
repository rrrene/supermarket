require 'spec_feature_helper'

describe 'viewing a cookbook' do
  it 'displays cookbook details if the cookbook exists' do
    maintainer = create(:user)
    cookbook = create(:cookbook) # TODO: give this cookbook a real maintainer

    visit '/'
    follow_relation 'cookbooks'

    within '.recently-updated' do
      follow_relation 'cookbook'
    end

    expect(page).to have_selector('.cookbook')
  end
end
