class EconomicProfile
  attr_reader :name,
              :data,
              :years,
              :incomes

  def initialize(data)
    @data = data
    @name = data[:name].upcase
    @years = data[:median_household_income].keys
    @incomes = data[:median_household_income].values
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
      key1 = array
      range = (array[0]..array[1])
      if range.include?(year)
        @data[:median_household_income][key1]
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

end


class UnknownDataError < Exception
end
