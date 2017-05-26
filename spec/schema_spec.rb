require_relative "./spec_helper"

describe SplitBuilder::Schema do
  let(:schema) do
    SplitBuilder::Schema.define do

      goal :one_time_purchase
      goal :subscription_purchase
      goal :sign_up
      goal :sign_in
      goal :enter_profile_information

      metric :any_purchase do
        goal :one_time_purchase
        goal :subscription_purchase
      end

      metric :sign_in do
        goal :sign_up
        goal :sign_in
      end

      metric :enter_profile_information

      experiment :sign_up_call_to_action do
        metric :sign_in
        alternative "Get Started Today!", :percent => 75
        alternative "Sign Up", :percent => 25
      end

      experiment :purchase_button_color do
        metric :any_purchase
        alternative "green", :percent => 5
        alternative "blue", :percent => 3
        alternative "red", :percent => 1
      end

      experiment :profile_version do
        metric :enter_profile_information
        alternative "none"
        alternative "simple"
        alternative "advanced"
      end

    end
  end

  let(:expected) do
    {
      "sign_up_call_to_action" => {
        :metric => :sign_in,
        :goals => ["sign_up", "sign_in"],
        :alternatives => [
          { :name => "Get Started Today!", :percent => 75 },
          { :name => "Sign Up", :percent => 25 }
        ],
        :resettable => false
      },
      "purchase_button_color" => {
        :metric => :any_purchase,
        :goals => ["one_time_purchase", "subscription_purchase"],
        :alternatives => [
          { :name => "green", :percent => 5 },
          { :name => "blue", :percent => 3 },
          { :name => "red", :percent => 1 }
        ],
        :resettable => false
      },
      "profile_version" => {
        :metric => :enter_profile_information,
        :goals => ["enter_profile_information"],
        :alternatives => [
          { :name => "none", :percent => 50 },
          { :name => "simple", :percent => 50 },
          { :name => "advanced", :percent => 50 }
        ],
        :resettable => false
      }
    }
  end

  it "translates into a Hash that the Split gem understands" do
    split_experiments = SplitBuilder.dump_experiments(schema)
    assert_equal(expected, split_experiments)
  end
end
