include ActionDispatch::TestProcess
    FactoryGirl.define do
      factory :admin, :class => User do
        email "your@mail.com"
        password "helloworld"
        password_confirmation "helloworld"
      end
    end

