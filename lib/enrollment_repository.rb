require "csv"
require 'pry'


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
    #initialize a new enrollment obj w/ the return value of method above
  end

    def get_raw_data(file)
      CSV.open(file, headers: true, header_converters: :symbol).map(&:to_h)
    end

    def delete_extra(file)
      raw_csv_data = get_raw_data(file)
      new_data = raw_csv_data.map do |hash|
        hash.delete(:dataformat)
        hash
      end
    end

    #format_data_to_hash
    def format_data_to_hash(file)
      deleted = delete_extra(file)
      initial_hash = deleted.map do |h|
        {name: h[:location], kindergarten: {h[:timeframe] => h[:data]}}
      end
      grouped = initial_hash.group_by do |hash|
        hash[:name]
      end
      merged = grouped.map do |location, entries|
        {name: location, kindergarten_participation: merged_entries(entries)}
      end
    end

  def merged_entries(entries)
    entries.map do |e|
      e[:kindergarten]
    end.reduce(:merge)
  end

end
