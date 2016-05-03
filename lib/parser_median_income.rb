module ParserMedianIncome

  def format_median_income_hash_per_line(file, name_of_hash)
    cleaned_data = delete_dataformat(file)
    cleaned_data.map do |h|
      if does_data_exist?(h[:data])
        {
          name: h[:location], "#{name_of_hash}":
          {
            h[:timeframe].split("-").map { |year| year.to_i } => h[:data].to_i
          }
        }
      end
    end.compact
  end

end
