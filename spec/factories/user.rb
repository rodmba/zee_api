# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email "person@example.com"
    password "password"
    password_confirmation "password"
  end
end
