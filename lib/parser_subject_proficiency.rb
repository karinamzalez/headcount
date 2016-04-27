module ParserSubjectProficiency

  def races
    [
      :all_students, :asian, :black, :pacific_islander,
      :hispanic, :native_american, :two_or_more, :white
    ]
  end

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
      if h[:race_ethnicity].include?("/")
        x = h[:race_ethnicity].downcase.split("/")[1].split(" ").join("_")
      else
        x = h[:race_ethnicity].downcase.split(" ").join("_")
      end
      {
        name: h[:location], "#{x}":
        {
          h[:timeframe] => {:"#{subject}" => h[:data]}
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

  def deep_merge(h1, h2)
    h1.merge(h2) do |key, value1, value2|
      if value1.class == Hash && value2.class == Hash
        value1.merge(value2)
      else
        value1
      end
    end
  end

  def iteratively_apply_deep_merge(array)
    array.reduce({}) do |hash, row|
      deep_merge(hash, row)
    end
  end

  def formatted_hashes_per_district(file,subject)
    grouped_data = group_by_district_name(file, subject)
    grouped_data.map do |ditrict_name, rows|
      iteratively_apply_deep_merge(rows)
    end
  end

end
