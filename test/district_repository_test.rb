require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/district_repository'

class DistrictRepositoryTest < Minitest::Test

  def setup
    @dr = DistrictRepository.new
  end

  def test_it_exists
    assert_equal DistrictRepository, @dr.class
  end

  def test_it_can_hold_district_objects
    assert_equal Array, @dr.districts.class
    assert_equal [], @dr.districts
  end

  def test_it_can_create_district_instances
    d = District.new({:name => "ACADEMY 20"})
    @dr.districts = [d]

    assert_equal [d], @dr.districts
  end

  def test_it_can_find_a_district_by_name
    d = District.new({:name => "ACADEMY 20"})
    @dr.districts = [d]

    assert_equal d, @dr.find_by_name("ACADEMY 20")
  end

  def test_it_can_find_all_matching_districts
    d = District.new({:name => "ACADEMY 20"})

    @dr.districts = [d]

  end

  def test_it_can_take_in_data_from_a_csv
    @dr.load_data({
      :enrollment => {
        :kindergarten => "./test/data/kindergarten.csv"
      }
      })
    assert_equal 4, @dr.districts.count
  end

  def test_it_makes_enrollnment_repo_w_enrollment_objects
    @dr.load_data({
      :enrollment => {
        :kindergarten => "./test/data/kindergarten.csv"
      }
      })
    assert_equal EnrollmentRepository, @dr.enrollment_repo.class
    assert_equal Enrollment, @dr.enrollment_repo.enrollments.first.class
  end

  def test_it_can_find_enrollment_data_for_a_given_year
    @dr.load_data({
      :enrollment => {
        :kindergarten => "./test/data/kindergarten.csv"
      }
      })
      district = @dr.find_by_name("ACADEMY 20")

      assert_equal 0.436, district.enrollment.kindergarten_participation_in_year("2010")
  end
end
