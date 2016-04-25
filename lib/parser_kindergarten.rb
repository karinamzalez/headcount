module ParserKindergarten

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

  def format_hash_per_line_kindergarten(file)
    cleaned_data = delete_dataformat(file)
    cleaned_data.map do |h|
      {name: h[:location], kindergarten_participation: {h[:timeframe] => h[:data]}}
    end
  end

  def group_by_name_kindergarten(file)
    formatted_data = format_hash_per_line_kindergarten(file)
    formatted_data.group_by do |hash|
      hash[:name]
    end
  end

end