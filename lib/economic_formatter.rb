module EconomicFormatter

  def income_file(data)
    data[:economic_profile][:median_household_income]
  end

  def poverty_file(data)
    data[:economic_profile][:children_in_poverty]
  end

  def lunch_file(data)
    data[:economic_profile][:free_or_reduced_price_lunch]
  end

  def title_i_file(data)
    data[:economic_profile][:title_i]
  end

  def merge_income_hashes(data)
    formatted_hashes_per_district(income_file(data), "median_household_income")
  end

  def merge_lunch_hashes(data)
    formatted_hashes_per_district(lunch_file(data), "free_or_reduced_price_lunch")
  end

  def merge_poverty_hashes(data)
    formatted_hashes_per_district(poverty_file(data), "children_in_poverty")
  end

  def merge_title_i_hashes(data)
    formatted_hashes_per_district(title_i_file(data), "title_i")
  end

  def group_all_data(data)
    income = merge_income_hashes(data)
    lunch = merge_lunch_hashes(data)
    poverty = merge_poverty_hashes(data)
    title_i = merge_title_i_hashes(data)
    all_files = [income, lunch, poverty, title_i].flatten
    all_files.group_by do |hash|
      hash[:name]
    end
  end

  def merge_all_data(data)
    group_all_data(data).values.map do |hash|
      hash.reduce(:merge)
    end 
  end

end
