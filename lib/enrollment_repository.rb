require_relative '../lib/enrollment'
require "csv"
require_relative '../lib/parser_kindergarten'
require_relative '../lib/parser_high_school'


class EnrollmentRepository
  include ParserKindergarten
  include ParserHighSchool

  attr_reader :enrollments

  def initialize
    @enrollments = []
  end

  def find_by_name(name)
    enrollments.find { |enrollment| enrollment.name == name }
  end

  def load_data(data)
    formatted_hashes1 = format_file_to_hash_kindergarten(kindergarten_file(data))

    if data[:high_school_graduation].nil?
      formatted_hashes = formatted_hashes1
    else
      formatted_hashes2 =  format_file_to_hash_high_school(graduation_file(data))
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
    # require "pry"; binding.pry
  end

  def kindergarten_file(data)
    data[:enrollment][:kindergarten]
  end

  def graduation_file(data)
    data[:enrollment][:high_school_graduation]
  end

  def format_file_to_hash_kindergarten(file)
    grouped = group_by_name_kindergarten(file)
    merge_to_final_kinder_hashes(grouped)
  end

  def format_file_to_hash_high_school(file)
    grouped = group_by_name_high_school(file)
    merge_to_final_hs_hashes(grouped)
  end

  def merge_to_final_kinder_hashes(grouped_data)
    grouped_data.map do |location, entries|
      {name: location, kindergarten_participation: merged_kinder_entries(entries)}
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
