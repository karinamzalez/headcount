class HeadcountAnalyst

  def initialize(dr)
    @dr = dr
  end

  def enrollment_data_kindergarten(district_name)
    district = @dr.find_by_name(district_name)
    district.enrollment.kindergarten_participation_by_year
  end

  def enrollment_data_high_school(district_name)
    district = @dr.find_by_name(district_name)
    district.enrollment.graduation_rate_by_year
  end

  def participation_percents_for_district_kindergarten(district_name)
    enrollment_data_kindergarten(district_name).values
  end

  def participation_percents_for_district_high_school(district_name)
    enrollment_data_high_school(district_name).values
  end

  def average_enrollment_kindergarten(district_name)
    percents = participation_percents_for_district_kindergarten(district_name)
    (percents.reduce(:+))/percents.count
  end

  def average_enrollment_high_school(district_name)
    percents = participation_percents_for_district_high_school(district_name)
    (percents.reduce(:+))/percents.count
  end

  def kindergarten_participation_rate_variation_trend(district1, district2)
    district1_percents = participation_percents_for_district_kindergarten(district1)
    district2_percents = participation_percents_for_district_kindergarten(district2.values[0])
    district1_years = enrollment_data_kindergarten(district1).keys

    variants = district1_percents.zip(district2_percents).map do |percents|
      percents.inject(:/).to_s[0..4].to_f
    end

    district1_years.zip(variants).to_h
  end

  def kindergarten_participation_rate_variation(district1, district2)
    raw_variation = average_enrollment_kindergarten(district1)/average_enrollment_kindergarten(district2.values[0])
    raw_variation.to_s[0..4].to_f
  end

  def high_school_graduation_rate_variation(district1, district2)
    raw_variation = average_enrollment_high_school(district1)/average_enrollment_high_school(district2.values[0])
    raw_variation.to_s[0..4].to_f
  end

  def kindergarten_participation_against_high_school_graduation(district)
    kindergarten_variation = kindergarten_participation_rate_variation(district, :against => "COLORADO")
    graduation_variation = high_school_graduation_rate_variation(district, :against => "COLORADO")
    # require "pry"; binding.pry
    raw_variation = kindergarten_variation/graduation_variation
    raw_variation.to_s[0..4].to_f
  end

end
