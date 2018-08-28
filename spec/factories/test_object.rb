FactoryBot.define do
  factory :test_object, class: TestObject do
    skip_create
    sequence(:id)
    yes { 'foo' }
    no { 'bar' }
    maybe { 'baz' }
  end
end
