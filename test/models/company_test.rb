require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  # Create 1 instance without a name, assert it fails
  test "Create one company with errors" do
    a = Company.new()
    assert !a.valid?
    assert a.errors.full_messages.include?("Company name can't be blank")
  end

  # Create 1 instance with a name, assert it passes
  test "Create one company without errors" do
    a = Company.new(:company_name =>  'This is present')
    assert a.valid?
  end

  # Create an instance that passes, then create the same one again, assert that one fails
  test "Create two company with one having errors" do
    original = Company.create(:company_name => 'This is a dup')
    a = Company.create(:company_name =>  'This is a dup')
    assert !a.valid?
    assert a.errors.full_messages.include?("Company name has already been taken")
  end

  # Create a company, then create a datum and assign it to the company, assert grouped_monthly returns 1 group
  test "Create two company with one having errors" do
    original = Company.create(:company_name => 'This is a dup')
    a = Company.create(:company_name =>  'This is a dup')
    assert !a.valid?
    assert a.errors.full_messages.include?("Company name has already been taken")
  end

  # Create a company, then create 2 datum with different data data months, assert grouped_monthly returns 2 groups

end
