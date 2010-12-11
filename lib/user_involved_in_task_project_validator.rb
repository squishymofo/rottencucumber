class UserInvolvedInTaskProjectValidator < ActiveModel::EachValidator  
  def validate_each(object, attribute, value)  
    task = Task.where(:id => object.task_id).first
    user = User.where(:id => object.user_id).first
    if task && user
      can_access = task.can_user_access?(user)
      unless can_access
        object.errors[attribute] << (options[:message] || "user can't commnet becuase they aren't involved in this tasks's project")
      end
    end
  end
end 
