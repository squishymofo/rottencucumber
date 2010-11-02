
And /^an organization will be created$/ do
  @o = Organization.create!(:name => "Organization Test", :description => "Organization Test")
end

# When I visit the project creation page
# And I fill in "project_name" with "Grow More Cucumbers"
# And I fill in "project_description" with "All of our cucumbers are rotten"
# And I press "Create Project"
# Then I should see "Grow More Cucumbers"