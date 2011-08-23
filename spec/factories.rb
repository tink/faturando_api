FactoryGirl.define do
  sequence :plan_name do |n|
    "Plan #{n}"
  end

  sequence :project_name do |n|
    "Project #{n}"
  end

  factory :project, :class => Faturando::Project do |p|
    p.name        { FactoryGirl.generate(:project_name) }
    p.description { Faker::Lorem.sentence }
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
