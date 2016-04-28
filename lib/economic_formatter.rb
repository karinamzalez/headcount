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

  def merge_poverty_file(data)
    group_by_district_name(file, name_of_hash).merge
  end

  def merge_title_i_file(data)

  end

  def gather_all_data(data)
    formatted_hashes_per_district(income_file(data), "median_household_income")
    group_by_district_name(file, name_of_hash).merge
  end


end
