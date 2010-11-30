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