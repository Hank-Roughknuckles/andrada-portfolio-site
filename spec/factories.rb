FactoryGirl.define do
  factory :user do
    email     "user@example.com"
    password  "exampleexample"
  end
end

FactoryGirl.define do
  factory :about_me_content do
    id "0"
    header "header"
    description "my_description"
    button_title "my_button_title"
  end
end

