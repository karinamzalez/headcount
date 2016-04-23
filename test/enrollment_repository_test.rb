require 'simplecov'
SimpleCov.start

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

  def test_it_can_load_data_from_a_csv
    @er.load_data({
      :enrollment => {
        :kindergarten => "./test/data/kindergarten.csv",
        :high_school_graduation => "./test/data/parser_high_school_data.csv"
      }
    })
    assert_equal 4, @er.enrollments.count
    # require "pry"; binding.pry
  end

  def test_it_can_load_different_data

  end

end
