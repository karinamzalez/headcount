gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enrollment_repository'
require './lib/enrollment'

class EnrollmentRepositoryTest < Minitest::Test

  def setup
    @er = EnrollmentRepository.new
  end

  def test_new_enrollment_repo_has_no_enrollments
    assert_equal [], @er.enrollments
  end

  def test_it_can_find_a_repository_by_name
    e = Enrollment.new({:name => "ACADEMY 20"})
    @er.enrollments << e
    assert_equal "ACADEMY 20", @er.find_by_name("ACADEMY 20").name
  end

  def test_it_returns_nil_if_no_enrollment_object_exists
    assert_equal nil, @er.find_by_name("hello")
  end

  # def test_it_can_group_up_a_pile_of_enrollment_data
  #   raw_data = [{:location=>"d1", :timeframe=>"2010", :dataformat=>"Percent", :data=>"1"},
  #               {:location=>"d1", :timeframe=>"2011", :dataformat=>"Percent", :data=>"1"},
  #               {:location=>"d2", :timeframe=>"2012", :dataformat=>"Percent", :data=>"1"},
  #               {:location=>"d2", :timeframe=>"2013", :dataformat=>"Percent", :data=>"0.9983"}
  #             ]
  #   formatted = [{:name => "d1", :kindergarten_participation => {2010 => "1", 2011 => "1"}},
  #                {:name "d2", kindergarten_participation: {2012 => "1", 2013 => "0.9983"}}]
  #                require "pry"; binding.pry
  #   assert_equal formatted, @er.some_fancy_method(raw_data)
  # end
  #


  def test_it_can_load_data_from_a_csv
    @er.load_data({
      :enrollment => {
        :kindergarten => "./test/data/kindergarten.csv"
      }
    })
    assert_equal 4, @er.enrollments.count
  end

end
