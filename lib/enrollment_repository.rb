require 'simplecov'
SimpleCov.start

require './lib/enrollment'
require "csv"
require './lib/parser'


class EnrollmentRepository
  include Parser
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

  def format_data_to_hash(file)
    grouped = group_by_name(file)
    merge_to_final_hashes(grouped)
  end

  def merge_to_final_hashes(grouped_data)
    grouped_data.map do |location, entries|
      {name: location, kindergarten_participation: merged_entries(entries)}
    end
  end

  def merged_entries(entries)
    entries.map do |e|
      e[:kindergarten_participation]
    end.reduce(:merge)
  end

end
