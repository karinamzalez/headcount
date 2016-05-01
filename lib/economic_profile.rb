class EconomicProfile
  attr_reader :data,
              :years,
              :incomes,
              :lunch_years

  def initialize(data)
    @data = data
    @years = data[:median_household_income].keys
    @incomes = data[:median_household_income].values
    @lunch_years = data[:free_or_reduced_price_lunch]
  end

  def name
    if data[:name] != nil
      data[:name].upcase
    end
  end

  def median_household_income_in_year(year)
    if get_all_years(year)
      incomes = get_income_associated_with_year(year)
      (incomes.reduce(:+))/incomes.count
    else
      raise UnknownDataError
    end
  end

  def get_income_associated_with_year(year)
    years.map do |array|
      range = (array[0]..array[1])
      if range.include?(year)
        @data[:median_household_income][array]
      end
    end.compact
  end

  def get_all_years(year)
    all_ranges = years.map {|array| (array[0]..array[1])}
    all_ranges.any? { |range| range.include?(year)}
  end

  def median_household_income_average
    incomes.reduce(:+)/incomes.count
  end

  def children_in_poverty_in_year(year)
    if @data[:children_in_poverty].keys.include?(year)
      @data[:children_in_poverty][year]
    else
      raise UnknownDataError
    end
  end

  def free_or_reduced_price_lunch_percentage_in_year(year)
    if lunch_years.keys.include?(year)
      @data[:free_or_reduced_price_lunch][year][:percentage]
    else
      raise UnknownDataError
    end
  end

  def free_or_reduced_price_lunch_number_in_year(year)
    if lunch_years.keys.include?(year)
      @data[:free_or_reduced_price_lunch][year][:total]
    else
      raise UnknownDataError
    end
  end

  def title_i_in_year(year)
    if @data[:title_i].keys.include?(year)
      @data[:title_i][year]
    else
      raise UnknownDataError
    end
  end

end

class UnknownDataError < Exception
end
