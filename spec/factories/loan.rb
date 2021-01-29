FactoryBot.define do
  factory :loan do
    amount { 10_000.00 }
    terms { 12 }
    interest_rate { 10.00 }
    day { Date.today }
    interest_only { true }
  end
end
