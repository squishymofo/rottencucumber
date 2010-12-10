class UserInvolvedInTaskValidator < ActiveModel::EachValidator  
  def validate_each(object, attribute, value)  
    task = Task.find object.task_id
    can_access = task.can_user_access?(User.find(object.user_id))
    unless can_access
      object.errors[attribute] << (options[:message] || "user can't commnet becuase they aren't involved in this tasks's project")
    end
  end
end 
