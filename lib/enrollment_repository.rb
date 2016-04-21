require 'simplecov'
SimpleCov.start

require "csv"
require 'pry'
require './lib/parser'


class EnrollmentRepository
  attr_reader :enrollments

  def initialize
    @enrollments = []
  end

  def find_by_name(name)
    enrollments.find { |enrollment| enrollment.name == name }
  end

  def load_data(data)
    kindergarten_file = data[:enrollment][:kindergarten]
    formatted_hashes = format_data_to_hash(kindergarten_file)
    formatted_hashes.each do |hash|
      @enrollments << Enrollment.new(hash)
    end
  end

  # #works with distric repo
  #   def get_raw_data(file)
  #     CSV.open(file, headers: true, header_converters: :symbol).map(&:to_h)
  #   end
  #
  #   #works with district repo
  #   def delete_extra(file)
  #     raw_csv_data = get_raw_data(file)
  #     new_data = raw_csv_data.map do |hash|
  #       hash.delete(:dataformat)
  #       hash
  #     end
  #   end

    def format_data_to_hash(file)
      deleted = delete_extra(file)
      formatted = format_hash_per_line(deleted)
      grouped = group_by_name(formatted)
      merge_to_final_hashes(grouped)
    end

    def merge_to_final_hashes(grouped_data)
      grouped_data .map do |location, entries|
        {name: location, kindergarten_participation: merged_entries(entries)}
      end
    end

  #   #works with district repo too
  #   def format_hash_per_line(cleaned_data)
  #     cleaned_data.map do |h|
  #       {name: h[:location], kindergarten: {h[:timeframe] => h[:data]}}
  #     end
  #   end
  #
  #   #works with district repo too
  # def group_by_name(formatted_data)
  #   formatted_data.group_by do |hash|
  #     hash[:name]
  #   end
  # end

  def merged_entries(entries)
    entries.map do |e|
      e[:kindergarten]
    end.reduce(:merge)
  end

end
