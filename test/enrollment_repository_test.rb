gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enrollment_repository'

class EnrollmentRepositoryTest < Minitest::Test

  def setup
    @er = EnrollmentRepository.new
  end

  def test_it_can_find_a_repository_by_name
    @er.find_by_name("ACADEMY 20")

    assert_equal
  end

  def test_it_returns_nil_if_no_enrollment_object_exists
    assert_equal nil, @er.find_by_name("hello")
  end

  def test_it_can_load_data_from_a_csv
    
  end

end
