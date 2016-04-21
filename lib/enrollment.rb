class Enrollment
  attr_reader :name

  def initialize(data)
    @name = data[:name]
    @kindergarten_participation_by_year = data[:kindergarten_participation]
  end

  def truncate_percents(participation_data)
    participation_data.map do |date, percent|
      [date, percent.to_s[0..4].to_f]
    end.to_h
  end

  def kindergarten_participation_by_year
    truncate_percents(@kindergarten_participation_by_year)
  end

  def kindergarten_participation_in_year(year)
    kindergarten_participation_by_year[year]
  end
end
