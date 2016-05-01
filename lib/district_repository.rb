require 'csv'
require_relative '../lib/district'
require_relative '../lib/enrollment_repository'
require_relative '../lib/parser_enrollment'
require_relative '../lib/statewide_test_repository'
require_relative '../lib/simplify_parsers_module'

class DistrictRepository
  include ParserEnrollment
  include SimplifyParsers

  attr_accessor :districts
  attr_reader :enrollment_repo,
              :statewide_test_repo

  def initialize
    @enrollment_repo = EnrollmentRepository.new
    @statewide_test_repo = StatewideTestRepository.new
    @districts = []
  end

  def find_by_name(name)
    districts.find { |d| d.name == name }
  end

  def find_all_matching(name)
    name = name.upcase
    districts.find_all { |d| d.name.include?(name)}
  end

  def load_data(data)
    grouped_district_data = group_by_district_name(
    kindergarten_file(data), "kindergarten_participation")
    make_districts_by_name(grouped_district_data)
    data.map do |hash|
      if hash.include?(:statewide_testing)
        statewide_test_repo.load_data(data)
        access_statewide_tests
      else hash.include?(:enrollment)
        enrollment_repo.load_data(data)
       access_enrollments
      end
    end
  end

  def kindergarten_file(data)
    data[:enrollment][:kindergarten]
  end

  def make_districts_by_name(grouped_district_data)
    grouped_district_data.keys.each do |name|
      d = District.new({name: name})
      @districts << d
    end
  end

  def access_enrollments
    districts.map do |district|
      district.enrollment = enrollment_repo.find_by_name(district.name)
    end
  end

  def access_statewide_tests
    districts.map do |district|
      district.statewide_test = statewide_test_repo.find_by_name(district.name)
    end
  end

end
