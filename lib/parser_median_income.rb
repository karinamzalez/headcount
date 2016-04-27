require 'csv'

module ParserMedianIncome

  def get_raw_data(file)
    CSV.open(file, headers: true, header_converters: :symbol).map(&:to_h)
  end

  def delete_dataformat(file)
    raw_csv_data = get_raw_data(file)
    raw_csv_data.map do |hash|
      hash.delete(:dataformat)
      hash
    end
  end

  def format_hash_per_line(file)
    cleaned_data = delete_dataformat(file)
    cleaned_data.map do |h|
      {
        name: h[:location], median_household_income:
        {
          h[:timeframe].to_a => h[:data]
        }
      }

  end

end
