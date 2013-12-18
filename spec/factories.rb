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

FactoryGirl.define do
  factory :nav_item do
    id "0"
    link_1_name "About Me"
    link_2_name "Showreel"
    link_3_name "Works"
    link_4_name "Current Projects"
    link_5_name "Contact"
  end
end

