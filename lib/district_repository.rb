require 'csv'
require_relative '../lib/district'
require_relative '../lib/enrollment_repository'
require_relative '../lib/parser_kindergarten'

class DistrictRepository
  include ParserKindergarten

  attr_accessor :districts
  attr_reader :enrollment_repo

  def initialize
    @enrollment_repo = EnrollmentRepository.new
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
    grouped_district_data = group_by_name_kindergarten(kindergarten_file(data))
    # require "pry"; binding.pry

    make_districts_by_name(grouped_district_data)
    enrollment_repo.load_data(data)
    access_enrollments
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
end
