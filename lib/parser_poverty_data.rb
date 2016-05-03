module ParserPovertyData

  def format_poverty_hash_per_line(file, name_of_hash)
    lines = get_raw_data(file)
    lines.map do |h|
      if h.values.include?("Percent") && does_data_exist?(h[:data])
        {
          name: h[:location],
          "#{name_of_hash}": {h[:timeframe].to_i => h[:data].to_f}
        }
      end
    end.compact
  end

end
