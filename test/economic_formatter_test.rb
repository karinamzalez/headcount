gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/economic_formatter'
require_relative '../lib/statewide_testing_formatter'
require_relative '../lib/parser_subject_proficiency'
require_relative '../lib/parser_grade'
require_relative '../lib/simplify_parsers_module'
require_relative '../lib/parser_enrollment'
require_relative '../lib/parser_poverty_data'
require_relative '../lib/parser_median_income'
require_relative '../lib/parser_free_reduced'

class EconomicFormatterTest < Minitest::Test
  include StatewideTestingFormatter
  include ParserSubjectProficiency
  include ParserGrade
  include SimplifyParsers
  include ParserEnrollment
  include EconomicFormatter
  include ParserPovertyData
  include ParserMedianIncome
  include ParserFreeReduced

  def setup
    @data =
    {
      :economic_profile =>
      {
        :median_household_income => "./test/data/median_household_income.csv",
        :children_in_poverty => "./test/data/poverty.csv",
        :free_or_reduced_price_lunch => "./test/data/lunch.csv",
        :title_i => "./test/data/title_i.csv"
      }
    }
  end

  def test_it_can_find_the_median_income_file
    assert_equal "./test/data/median_household_income.csv", income_file(@data)
  end

  def test_it_can_find_the_poverty_file
    assert_equal "./test/data/poverty.csv", poverty_file(@data)
  end

  def test_it_can_find_the_lunch_file
    assert_equal "./test/data/lunch.csv", lunch_file(@data)
  end

  def test_it_can_find_the_title_i_file
    assert_equal "./test/data/title_i.csv", title_i_file(@data)
  end

  def test_it_can_merge_the_poverty_data_by_dsitrcit
    data =
    [
      {:name=>"ACADEMY 20",
       :children_in_poverty=>{2007=>0.039, 2008=>0.044}},
      {:name=>"ADAMS COUNTY 14",
       :children_in_poverty=>{2007=>0.247, 2008=>0.225}},
      {:name=>"ADAMS-ARAPAHOE 28J",
       :children_in_poverty=>{2007=>0.238, 2008=>0.185}}
    ]
      assert_equal data, merge_poverty_hashes(@data)
  end

  def test_it_can_merge_the_median_income_data_by_distrcit
    data =
    [
      {:name=>"Colorado",
       :median_household_income=>{[2005, 2009]=>56222, [2006, 2010]=>56456}},
      {:name=>"ACADEMY 20",
       :median_household_income=>{[2005, 2009]=>85060, [2006, 2010]=>85450}},
      {:name=>"ADAMS COUNTY 14",
       :median_household_income=>{[2005, 2009]=>41382, [2006, 2010]=>40740}},
      {:name=>"ADAMS-ARAPAHOE 28J",
       :median_household_income=>{[2005, 2009]=>43893, [2006, 2010]=>44007}},
      {:name=>"AGATE 300",
       :median_household_income=>{[2005, 2009]=>64167, [2006, 2010]=>64145}}
    ]
    assert_equal data, merge_income_hashes(@data)
  end

  def test_it_can_merge_the_lunch_data_by_district
    data =
    [
      {:name=>"Colorado",
       :free_or_reduced_price_lunch=>
        {2012=>{:number=>297167, :percent=>0.344},
         2014=>{:percent=>0.34346, :number=>305342}}},
      {:name=>"ACADEMY 20",
       :free_or_reduced_price_lunch=>
        {2014=>{:number=>2156, :percent=>0.08772},
        2012=>{:percent=>0.09027, :number=>2164}}},
      {:name=>"ADAMS COUNTY 14",
       :free_or_reduced_price_lunch=>
       {2012=>{:number=>5486, :percent=>0.73147},
       2014=>{:percent=>0.65322, :number=>4954}}}
    ]
    assert_equal data, merge_lunch_hashes(@data)
  end

  def test_it_can_merge_title_i_data_by_district
    data =
    [
      {:name=>"Colorado", :title_i=>{2013=>0.231, 2014=>0.235}},
      {:name=>"ACADEMY 20", :title_i=>{2013=>0.012, 2014=>0.027}},
      {:name=>"ADAMS COUNTY 14", :title_i=>{2013=>0.66, 2014=>0.661}}
    ]
    assert_equal data , merge_title_i_hashes(@data)
  end

  def test_it_can_group_all_data_by_district_name
    data =
    {
      "Colorado"=>
       [
         {:name=>"Colorado",
          :median_household_income=>{[2005, 2009]=>56222, [2006, 2010]=>56456}},
         {:name=>"Colorado",
          :free_or_reduced_price_lunch=>{2012=>{:number=>297167, :percent=>0.344},
                                         2014=>{:percent=>0.34346, :number=>305342}}},
         {:name=>"Colorado",
          :title_i=>{2013=>0.231, 2014=>0.235}}
       ],
     "ACADEMY 20"=>
       [
         {:name=>"ACADEMY 20",
          :median_household_income=>{[2005, 2009]=>85060, [2006, 2010]=>85450}}, {:name=>"ACADEMY 20",
            :free_or_reduced_price_lunch=>{2014=>{:number=>2156,
              :percent=>0.08772}, 2012=>{:percent=>0.09027,
                :number=>2164}}}, {:name=>"ACADEMY 20",
                  :children_in_poverty=>{2007=>0.039, 2008=>0.044}}, {:name=>"ACADEMY 20",
                    :title_i=>{2013=>0.012, 2014=>0.027}}
       ],
     "ADAMS COUNTY 14"=>
       [
         {:name=>"ADAMS COUNTY 14",
          :median_household_income=>{[2005, 2009]=>41382, [2006, 2010]=>40740}}, {:name=>"ADAMS COUNTY 14",
          :free_or_reduced_price_lunch=>{2012=>{:number=>5486,
          :percent=>0.73147}, 2014=>{:percent=>0.65322,
          :number=>4954}}}, {:name=>"ADAMS COUNTY 14",
          :children_in_poverty=>{2007=>0.247, 2008=>0.225}}, {:name=>"ADAMS COUNTY 14",
          :title_i=>{2013=>0.66, 2014=>0.661}}
       ],
     "ADAMS-ARAPAHOE 28J"=>
       [
         {:name=>"ADAMS-ARAPAHOE 28J",
          :median_household_income=>{[2005, 2009]=>43893, [2006, 2010]=>44007}}, {:name=>"ADAMS-ARAPAHOE 28J",
          :children_in_poverty=>{2007=>0.238, 2008=>0.185}}
       ],
     "AGATE 300"=>
       [
         {:name=>"AGATE 300",
          :median_household_income=>{[2005, 2009]=>64167, [2006, 2010]=>64145}}
       ]
    }
    assert_equal data, group_all_economic_data(@data)
  end

  def test_it_can_format_to_final_economic_hashes
    data =
    [
      {:name=>"Colorado",
       :median_household_income=>{[2005, 2009]=>56222, [2006, 2010]=>56456},
       :free_or_reduced_price_lunch=>
        {2012=>{:number=>297167, :percent=>0.344},
         2014=>{:percent=>0.34346, :number=>305342}},
       :title_i=>{2013=>0.231, 2014=>0.235}},
      {:name=>"ACADEMY 20",
       :median_household_income=>{[2005, 2009]=>85060, [2006, 2010]=>85450},
       :free_or_reduced_price_lunch=>
        {2014=>{:number=>2156, :percent=>0.08772},
        2012=>{:percent=>0.09027, :number=>2164}},
       :children_in_poverty=>{2007=>0.039, 2008=>0.044},
       :title_i=>{2013=>0.012, 2014=>0.027}},
      {:name=>"ADAMS COUNTY 14",
       :median_household_income=>{[2005, 2009]=>41382, [2006, 2010]=>40740},
       :free_or_reduced_price_lunch=>
        {2012=>{:number=>5486, :percent=>0.73147},
        2014=>{:percent=>0.65322, :number=>4954}},
       :children_in_poverty=>{2007=>0.247, 2008=>0.225},
       :title_i=>{2013=>0.66, 2014=>0.661}},
      {:name=>"ADAMS-ARAPAHOE 28J",
       :median_household_income=>{[2005, 2009]=>43893, [2006, 2010]=>44007},
       :children_in_poverty=>{2007=>0.238, 2008=>0.185}},
      {:name=>"AGATE 300",
       :median_household_income=>{[2005, 2009]=>64167, [2006, 2010]=>64145}}
    ]
    assert_equal data, merge_all_economic_data(@data)
  end
end
