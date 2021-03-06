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
    district1_percents =
    participation_percents_for_district_kindergarten(district1)
    district2_percents =
    participation_percents_for_district_kindergarten(district2.values[0])
    district1_years = enrollment_data_kindergarten(district1).keys

    variants = district1_percents.zip(district2_percents).map do |percents|
      percents.inject(:/).to_s[0..4].to_f
    end
    district1_years.zip(variants).to_h
  end

  def kindergarten_participation_rate_variation(district1, district2)
    avg_enroll_kinder1 = average_enrollment_kindergarten(district1)
    avg_enroll_kinder2 = average_enrollment_kindergarten(district2.values[0])
    raw_variation = avg_enroll_kinder1/avg_enroll_kinder2
    raw_variation.to_s[0..4].to_f
  end

  def high_school_graduation_rate_variation(district1, district2)
    avg_enroll_hs = average_enrollment_high_school(district1)
    avg_enroll_hs_d2 = average_enrollment_high_school(district2.values[0])
    raw_variation = avg_enroll_hs/avg_enroll_hs_d2
    raw_variation.to_s[0..4].to_f
  end

  def kindergarten_participation_against_high_school_graduation(district)
    kindergarten_variation =
    kindergarten_participation_rate_variation(district, :against => "COLORADO")
    graduation_variation =
     high_school_graduation_rate_variation(district, :against => "COLORADO")
    raw_variation = kindergarten_variation/graduation_variation
    raw_variation.to_s[0..4].to_f
  end

  def kindergarten_participation_correlates_with_high_school_graduation(compare)
    case compare.keys
    when [:for]
      if compare[:for] == "STATEWIDE"
        correlation_across_all_districts
      else
        correlation_for_one_district(compare)
      end
    when [:across]
      correlation_across_some_districts(compare)
    end
  end

  def correlation_for_one_district(comparison)
    k_hs_variation =
    kindergarten_participation_against_high_school_graduation(comparison[:for])
    if  k_hs_variation >= 0.6 && k_hs_variation <= 1.5
      true
    else
      false
    end
  end

  def correlation_across_all_districts
    district_variants = @dr.districts.map do |district|
      kindergarten_participation_against_high_school_graduation(district.name)
    end
    correlates = district_variants.count do |variant|
      variant >= 0.6 && variant <= 1.5
    end
    if correlates/(district_variants.count).to_f > 0.7
      true
    else
      false
    end
  end

  def correlation_across_some_districts(comparison)
    district_variants = comparison[:across].map do |district|
      kindergarten_participation_against_high_school_graduation(district)
    end
    correlates = district_variants.count do |variant|
      variant >= 0.6 && variant <= 1.5
    end
    if correlates/(district_variants.count).to_f > 0.7
      true
    else
      false
    end
  end

  def top_statewide_test_year_over_year_growth(input)
     all_data = @dr.districts.map do |district|
      [district.name, find_percentage_growth_for_one_district(input, district)]
    end
    if input.keys.include?(:top)
      ignore_statewide_data(all_data).max_by(input[:top]) {|pair| pair[1]}
    else
      ignore_statewide_data(all_data).max
    end
  end

  def find_percentage_growth_for_one_district(input, district)
    data = district.statewide_test
    if !district.statewide_test.proficient_by_grade(get_grade(input)).nil?
      years = district.statewide_test.proficient_by_grade(get_grade(input)).keys
    end
    if !years.nil?
      first = data.proficient_for_subject_by_grade_in_year(
      get_subject(input), get_grade(input), years[0])
      last = data.proficient_for_subject_by_grade_in_year(
      get_subject(input), get_grade(input), years[-1])
      if !last.nil? && !first.nil?
        truncate_percents(last-first)/(years[-1] - years[0])
      end
    end
  end

  def top_or_bottom_three_poverty_stricken_districts(input)
    all_data = @dr.districts.map do |district|
      if district.economic_profile.data[:name] != "Colorado"
       [district.name,
       truncate_percents(district.economic_profile.avg_children_in_poverty_per_district)]
      end
    end.compact
    if input.keys.include?(:top)
      ignore_statewide_data(all_data).max_by(input[:top]) {|pair| pair[1]}
    else input.keys.include?(:bottom)
      ignore_statewide_data(all_data).min_by(input[:bottom]) {|pair| pair[1]}
    end
  end

  def corresponding_test_scores_for_districts(input)
    top_or_bottom_districts =
    top_or_bottom_three_poverty_stricken_districts(input)
    top_or_bottom_districts.map do |array|
      [array[0],
      @dr.find_by_name(array[0]).statewide_test.data[:all_students]]
    end
  end

  def almost_condensed(subject, input)
    c = corresponding_test_scores_for_districts(input)
    c.map do |array|
      scores = array[1].values.map do |hash|
        hash[subject]
      end
      (scores.inject(:+)/scores.count).to_s[0..4].to_f
    end
  end

  def condensed_test_scores(input)
    m =
    truncate_percents((almost_condensed(:math, input).inject(:+)/almost_condensed(:math, input).count))
    r =
    truncate_percents((almost_condensed(:reading, input).inject(:+)/almost_condensed(:reading, input).count))
    w =
    truncate_percents((almost_condensed(:writing, input).inject(:+)/almost_condensed(:writing, input).count))
    if input.include?(:top)
      {top_3_impoverished: {:math => m, :reading => r, :writing => w}}
    else
      {bottom_3_impoverished: {:math => m, :reading => r, :writing => w}}
    end
  end

  def comparison_of_test_scores_based_upon_poverty
    top = condensed_test_scores(top: 3)[:top_3_impoverished].values
    bottom = condensed_test_scores(bottom: 3)[:bottom_3_impoverished].values
    compares = top.zip(bottom).map do |array|
      array.inject(:/).to_s[0..4].to_f
    end
    {:math => compares[0], :reading => compares[1], :writing => compares[2]}
  end


  def ignore_statewide_data(all_data)
    all_data.reject {|array| array[0] == "COLORADO"}
  end

  def truncate_percents(percent)
    if percent.to_s[0] == "-"
      percent.to_s[0..5].to_f
    else
      percent.to_s[0..4].to_f
    end
  end

  def get_total_subject_percent_for_first_year(input, district)
    data = district.statewide_test
    years = district.statewide_test.proficient_by_grade(get_grade(input)).keys
    math = data.proficient_for_subject_by_grade_in_year(
      :math, get_grade(input), years[0])
    reading = data.proficient_for_subject_by_grade_in_year(
      :reading, get_grade(input), years[0])
    writing = data.proficient_for_subject_by_grade_in_year(
      :writing, get_grade(input), years[0])
    (math + reading + writing) / 3
  end

  def get_grade(input)
    if !input[:grade].nil?
      input[:grade]
    else
      raise InsufficientInformationError
    end
  end

  def get_subject(input)
    input[:subject]
  end

end

class InsufficientInformationError < Exception
end
