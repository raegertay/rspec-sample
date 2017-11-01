FactoryGirl.define do
  factory :penguin do
    head 'head'
    hand 'hand'
    foot 'foot'
  end

  trait :invalid do
    head nil
  end
end
