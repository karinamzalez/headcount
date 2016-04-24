class HeadcountAnalyst

  def initialize(dr)
    @dr = dr
  end

  def enrollment_data(district_name)
    district = @dr.find_by_name(district_name)
    district.enrollment.kindergarten_participation_by_year
  end

  def participation_percents_for_district(district_name)
    enrollment_data(district_name).values
  end

  def average_enrollment(district_name)
    percents = participation_percents_for_district(district_name)
    (percents.reduce(:+))/percents.count
  end

  def kindergarten_participation_rate_variation_trend(district1, district2)
    district1_percents = participation_percents_for_district(district1)
    district2_percents = participation_percents_for_district(district2.values[0])
    district1_years = enrollment_data(district1).keys

    variants = district1_percents.zip(district2_percents).map do |percents|
      percents.inject(:/).to_s[0..4].to_f
    end

    district1_years.zip(variants).to_h
  end

  def kindergarten_participation_rate_variation(district1, district2)
    raw_variation = average_enrollment(district1)/average_enrollment(district2.values[0])
    raw_variation.to_s[0..4].to_f
  end

end
