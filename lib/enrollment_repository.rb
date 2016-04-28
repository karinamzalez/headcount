require_relative '../lib/enrollment'
require "csv"
require_relative '../lib/parser_enrollment'
require_relative '../lib/simplify_parsers_module'


class EnrollmentRepository
  include ParserEnrollment
  include SimplifyParsers

  attr_reader :enrollments

  def initialize
    @enrollments = []
  end

  def find_by_name(name)
    enrollments.find { |enrollment| enrollment.name == name.upcase }
  end

  def load_data(data)
    formatted_hashes1 =
    format_file_to_hash_kindergarten(kindergarten_file(data))
    if data[:enrollment][:high_school_graduation].nil?
      formatted_hashes = formatted_hashes1
    else
      formatted_hashes2 =
      format_file_to_hash_high_school(graduation_file(data))
      x = formatted_hashes1.concat(formatted_hashes2)
      almost_final_hash = x.group_by do |hash|
        hash[:name]
        end
        formatted_hashes = almost_final_hash.values.map do |array|
          array[0].merge(array[1])
        end
    end
    formatted_hashes.each do |hash|
      @enrollments << Enrollment.new(hash)
    end
  end

  def kindergarten_file(data)
    data[:enrollment][:kindergarten]
  end

  def graduation_file(data)
    data[:enrollment][:high_school_graduation]
  end

  def format_file_to_hash_kindergarten(kindergarten_file)
    grouped = group_by_district_name(
    kindergarten_file, "kindergarten_participation")
    merge_to_final_kinder_hashes(grouped)
  end

  def format_file_to_hash_high_school(graduation_file)
    grouped = group_by_district_name(graduation_file, "high_school_graduation")
    merge_to_final_hs_hashes(grouped)
  end

  def merge_to_final_kinder_hashes(grouped_data)
    grouped_data.map do |location, entries|
      {
        name: location,
        kindergarten_participation: merged_kinder_entries(entries)
      }
    end
  end

  def merge_to_final_hs_hashes(grouped_data)
    grouped_data.map do |location, entries|
      {name: location, high_school_graduation: merged_hs_entries(entries)}
    end
  end

  def merged_hs_entries(entries)
    entries.map do |e|
      e[:high_school_graduation]
    end.reduce(:merge)
  end

  def merged_kinder_entries(entries)
    entries.map do |e|
      e[:kindergarten_participation]
    end.reduce(:merge)
  end

end
