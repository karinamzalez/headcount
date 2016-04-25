module ParserSubjectProficiency

  def get_the_raw_data(file)
    CSV.open(file, headers: true, header_converters: :symbol).map(&:to_h)
  end

  def delete_dataformat_only(file)
    raw_csv_data = get_the_raw_data(file)
    raw_csv_data.map do |hash|
      hash.delete(:dataformat)
      hash
    end
  end

  def format_subject_hash_per_line(file, subject)
    cleaned_data = delete_dataformat_only(file)
    cleaned_data.map do |h|
      {
        name: h[:location], "#{(h[:race_ethnicity]).downcase}":
        {
          h[:timeframe] => {"#{subject}" => h[:data]}
        }
      }
    end
  end

  def group_by_district_name(file, subject)
    formatted_data = format_subject_hash_per_line(file, subject)
    formatted_data.group_by do |hash|
      hash[:name]
    end
  end

end
