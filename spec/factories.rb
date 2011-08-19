FactoryGirl.define do
  sequence :plan_name do |n|
    "Plan #{n}"
  end

  factory :plan, :class => Faturando::Plan do |p|
    p.name          { FactoryGirl.generate(:plan_name) }
    p.value         { 19.99 }
    p.subscribible  { true }
  end

  factory :feature, :class => Faturando::Feature do |f|
    f.name        { Faker::Name.name }
    f.type        { 'Features::Numeric' }
    f.description { Faker::Lorem.sentence }
  end
end
