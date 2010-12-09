class Task < ActiveRecord::Base
  #belongs_to :organization
  belongs_to :group
  belongs_to :project

  def translate_status
    case self.status
    when 0
      "Not yet started"
    when 1
      "Started"
    when 2
      "On Halt"
    when 3
      "Finished"
    else
      raise Exception
    end
  end

end
