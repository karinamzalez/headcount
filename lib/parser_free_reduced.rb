module ParserFreeReduced

  def format_free_reduced_hash_per_line(file, name_of_hash)
    lines = get_raw_data(file)
      lines.map do |h|
      if h.values.include?("Eligible for Free Lunch")
          {
            name: h[:location], "#{name_of_hash}":
            {
              h[:timeframe].to_i =>
              { :"#{dataformat(h)}" => clean_data(h[:data])}
            }
          }
      end
    end.compact
  end

  def dataformat(h)
    if h[:dataformat].include?("Number")
      "total"
    else
      "percentage"
    end
  end

end
