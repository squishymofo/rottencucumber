# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|  
  # Specify a custom renderer if needed. 
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # navigation.renderer = Your::Custom::Renderer
  
  # Specify the class that will be applied to active navigation items. Defaults to 'selected'
  # navigation.selected_class = 'your_selected_class'
    
  # Item keys are normally added to list items as id.
  # This setting turns that off
  # navigation.autogenerate_item_ids = false
  
  # You can override the default logic that is used to autogenerate the item ids.
  # To do this, define a Proc which takes the key of the current item as argument.
  # The example below would add a prefix to each key.
  # navigation.id_generator = Proc.new {|key| "my-prefix-#{key}"}

  # The auto highlight feature is turned on by default.
  # This turns it off globally (for the whole plugin)
  # navigation.auto_highlight = false

  # Define the primary navigation
  navigation.items do |primary| #F
    # Add an item to the primary navigation. The following params apply:
    # key - a symbol which uniquely defines your navigation item in the scope of the primary_navigation
    # name - will be displayed in the rendered navigation. This can also be a call to your I18n-framework.
    # url - the address that the generated item links to. You can also use url_helpers (named routes, restful routes helper, url_for etc.)
    # options - can be used to specify attributes that will be included in the rendered navigation item (e.g. id, class etc.)
    #
    #primary.auto_highlight = false
    if @current_user
      primary.auto_highlight = false
      primary.item :projects, 'projects', projects_path, :class => 'main_nav'
      primary.item :groups, 'groups', groups_path, :class => 'main_nav'
      primary.item :tasks, 'tasks' + "<span>#{@current_user.active_tasks.size}</span>", tasks_path, :id => 'tasks-nav', :class => 'main_nav' do |secondary|
        secondary.item :all, "all", tasks_path(:show_all=>1), :class => 'secondary_nav'
        secondary.item :in_progress, "in progress", tasks_path(:show_in_progress => 1), :class => 'secondary_nav'
        secondary.item :completed, "completed", tasks_path(:show_completed=> 1), :class => 'secondary_nav'
      end
    end
      #primary.item :login, "Login", new_user_session_path, :class => 'main_nav logged-in-as', :data_remote => true
      #primary.item :sign_up, "Sign up", new_user_path, :class => 'main_nav logged-in-as', :data_remote => true
  end # end F

    
=begin
    # Add an item which has a sub navigation (same params, but with block)
    primary.item :key_2, 'name', url, options do |sub_nav|
      # Add an item to the sub navigation (same params again)
      sub_nav.item :key_2_1, 'name', url, options
    end 
=end
  
    # You can also specify a condition-proc that needs to be fullfilled to display an item.
    # Conditions are part of the options. They are evaluated in the context of the views,
    # thus you can use all the methods and vars you have available in the views.
    #primary.item :key_3, 'Admin', url, :class => 'special', :if => Proc.new { current_user.admin? }
    #primary.item :key_4, 'Account', url, :unless => Proc.new { logged_in? }

    # you can also specify a css id or class to attach to this particular level
    # works for all levels of the menu
    # primary.dom_id = 'menu-id'
    # primary.dom_class = 'menu-class'
    
    # You can turn off auto highlighting for a specific level
  
  
end
