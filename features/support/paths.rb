module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
      
    when /the organization creation page/
      '/organizations/new'
    when /the user preferences page/
      edit_user_path(User.find_by_email("spitfire67@berkeley.edu"))
    when /the show page for task with id "(.+)"/
      task_path(Task.find($1))
    when /the show page for the first task assigned to me/
      task_path(User.find_by_email("spitfire67@berkeley.edu").tasks.order("created_at desc").first)
    when/the show page for the first task for a project that I am involved in but not assigned to/

    when /the project creation page/
      '/projects/new/1'

    when /the finish registration page for user with email "spitfire67@berkeley.edu"/
      "/register/#{User.find_by_email("spitfire67@berkeley.edu").perishable_token}"
      
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
