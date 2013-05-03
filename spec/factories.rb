include ActionDispatch::TestProcess
    FactoryGirl.define do
      factory :user, :class => User do
        email "your@mail.com"
        username "toby"
        password "helloworld"
        password_confirmation "helloworld"
      end
    end