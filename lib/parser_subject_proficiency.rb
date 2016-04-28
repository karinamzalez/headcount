module ParserSubjectProficiency

  def races
    [
      :all_students, :asian, :black, :pacific_islander,
      :hispanic, :native_american, :two_or_more, :white
    ]
  end

  def format_subject_hash_per_line(file, subject)
    cleaned_data = delete_dataformat(file)
    cleaned_data.map do |h|
      if h[:race_ethnicity].include?("/")
        x = h[:race_ethnicity].downcase.split("/")[1].split(" ").join("_")
      else
        x = h[:race_ethnicity].downcase.split(" ").join("_")
      end
      {
        name: h[:location], "#{x}":
        {
          h[:timeframe].to_i => {:"#{subject}" => h[:data][0..4].to_f}
        }
      }
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

end
