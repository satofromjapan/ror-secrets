FactoryGirl.define do
  factory :user do
    name "John Doe"
    email "johndoe@gmail.com"
    password "password"
    password_confirmation "password"
  end
end
