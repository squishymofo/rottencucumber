Factory.define :user do |f|
  f.sequence(:email) { |n| "foo#{n}@abcdoq.com"}
  f.sequence(:id) { |n| n}
  f.password "password"
end

Factory.define :organization do |f|
  f.sequence(:id) {|n| n}
  f.sequence(:name) { |n| "Org#{n}"}
  f.description "ABCDEFG"
  f.sequence(:creator_id) {|n| n}
end


Factory.define :group do |f|
  f.sequence(:id) {|n| n}
  f.sequence(:name) { |n| "Group#{n}"}
  f.sequence(:organization_id) {|n| n}
end

Factory.define :project do |f|
  f.sequence(:id) {|n| n}
  f.sequence(:name) { |n| "Project#{n}"}
  f.sequence(:description) { |n| "Project Description#{n}"}
  f.sequence(:organization_id) {|n| n}
  
end

Factory.define :task do |f|
  f.sequence(:id) {|n| n}
  f.sequence(:name) {|n| "Task#{n}"}
  f.sequence(:description)  {|n| "Descritpion#{n}"}
  f.sequence(:group_id) {|n| n}
  f.sequence(:project_id) {|n| n}
  f.due Time.now
  f.point (rand(3) + 1)
  f.status (rand(1))
end