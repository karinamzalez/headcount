require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/enrollment_repository'
require_relative '../lib/enrollment'

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

  def test_it_is_case_insensitive
    e = Enrollment.new({:name => "ACADEMY 20"})
    @er.enrollments << e
    assert_equal "ACADEMY 20", @er.find_by_name("Academy 20").name
  end

  def test_it_returns_nil_if_no_enrollment_object_exists
    assert_equal nil, @er.find_by_name("hello")
  end

  def test_it_can_load_kinder_data_from_a_csv
    @er.load_data(
    {
      :enrollment =>
      {
        :kindergarten => "./test/data/kindergarten.csv",
      }
    })
    assert_equal 4, @er.enrollments.count
  end

  def test_it_can_load_graduation_and_kinder_data_from_a_csv
    @er.load_data(
    {
      :enrollment =>
      {
        :kindergarten => "./test/data/kindergarten.csv",
        :high_school_graduation => "./test/data/parser_high_school_data.csv"
      }
    })
    assert_equal 4, @er.enrollments.count
    assert_equal 0.724, @er.enrollments[0].graduation_rate_in_year(2010)
  end

  def test_it_can_find_by_name_with_loaded_data
    @er.load_data(
    {
      :enrollment =>
      {
        :kindergarten => "./test/data/kindergarten.csv",
        :high_school_graduation => "./test/data/parser_high_school_data.csv"
      }
    })
    assert_equal Enrollment, @er.find_by_name("ACADEMY 20").class
  end

end
