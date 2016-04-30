require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/parser_grade'
require_relative '../lib/parser_enrollment'
require_relative '../lib/parser_subject_proficiency'
require_relative '../lib/parser_median_income'
require_relative '../lib/simplify_parsers_module'
require_relative '../test/data/parser_outputs_module'
require_relative '../lib/parser_poverty_data'
require 'csv'

class SimplifyParsersTest < Minitest::Test
  include SimplifyParsers
  include ParserGrade
  include ParserEnrollment
  include ParserSubjectProficiency
  include ParserMedianIncome
  include ParserOutputs
  include ParserPovertyData

  def test_it_can_get_raw_data_from_csv
    assert_equal grade_raw_data_output,
    get_raw_data('./test/data/3rd_grade.csv')
  end

  def test_it_can_delete_unneeded_data
    assert_equal grade_delete_ouput,
    delete_dataformat('./test/data/3rd_grade.csv')
  end

    def test_it_can_clean_the_data
      assert_equal "N/A", clean_data("N/A")
      assert_equal 0.123, clean_data("0.123")
      assert_equal 1234, clean_data("1234")
    end

    def test_it_can_group_by_district_name_for_each_instance
      assert_equal grade_group_lines_by_district, group_by_district_name('./test/data/3rd_grade.csv', "third_grade_proficiency")
      assert_equal math_subject_group_by_district,  group_by_district_name('./test/data/test_prof_math.csv', "math")
      assert_equal kinder_enrollment_group_by_district, group_by_district_name('./test/data/parser_kinder_data.csv', "kindergarten_participation")
    end

    #do we need to check for each file?

    def test_it_formats_hashes_per_district_for_each_instance
      math_output =
        [
          {
            :name=>"ADAMS COUNTY 14",
            :all_students=>{2011=>{:math=>0.32}, 2012=>{:math=>0.287}},
            :asian=>{2011=>{:math=>0.0}},
            :black=>{2011=>{:math=>0.196}}
          },
          {
            :name=>"ADAMS-ARAPAHOE 28J",
            :all_students=>{2011=>{:math=>0.38}, 2012=>{:math=>0.377}},
            :asian=>{2011=>{:math=>0.481}},
            :black=>{2011=>{:math=>0.291}}
          }
        ]
      assert_equal math_output, formatted_hashes_per_district('./test/data/test_prof_math_short.csv', "math")
      grade_output =
        [
          {
            :name=>"ADAMS COUNTY 14",
            :third_grade_proficiency=>
            {
              2008=>{:math=>0.56, :reading=>0.523, :writing=>0.426},
              2009=>{:math=>0.54, :reading=>0.562, :writing=>0.479}}
            },
          {
            :name=>"ADAMS-ARAPAHOE 28J",
            :third_grade_proficiency=>
            {
              2008=>{:math=>0.473, :reading=>0.466, :writing=>0.339},
              2009=>{:math=>0.456, :reading=>0.483, :writing=>0.359}}
            }
        ]
      assert_equal grade_output,
      formatted_hashes_per_district('./test/data/3rd_grade.csv', "third_grade_proficiency")
      median_output =
        [
          {
            :name=>"Colorado",
            :median_household_income=>
            {[2005, 2009]=>56222, [2006, 2010]=>56456}},
          {
            :name=>"ACADEMY 20",
            :median_household_income=>
            {[2005, 2009]=>85060, [2006, 2010]=>85450}},
          {
            :name=>"ADAMS COUNTY 14",
            :median_household_income=>
            {[2005, 2009]=>41382, [2006, 2010]=>40740}},
          {
            :name=>"ADAMS-ARAPAHOE 28J",
            :median_household_income=>
            {[2005, 2009]=>43893, [2006, 2010]=>44007}},
          {
            :name=>"AGATE 300",
            :median_household_income=>
            {[2005, 2009]=>64167, [2006, 2010]=>64145}}]
      assert_equal median_output,
      formatted_hashes_per_district(
      './test/data/median_household_income.csv', "median_household_income")
    end

    def test_it_can_group_poverty_data
      data =
      {
       "ACADEMY 20"=>
       [
         {:name=>"ACADEMY 20",
          :children_in_poverty=>{2007=>0.039}},
         {:name=>"ACADEMY 20",
          :children_in_poverty=>{2008=>0.044}}],
       "ADAMS COUNTY 14"=>
       [
         {:name=>"ADAMS COUNTY 14",
          :children_in_poverty=>{2007=>0.247}},
         {:name=>"ADAMS COUNTY 14",
          :children_in_poverty=>{2008=>0.225}}],
       "ADAMS-ARAPAHOE 28J"=>
       [
         {:name=>"ADAMS-ARAPAHOE 28J",
          :children_in_poverty=>{2007=>0.238}},
         {:name=>"ADAMS-ARAPAHOE 28J",
          :children_in_poverty=>{2008=>0.185}}]}
      assert_equal data,
      group_by_district_name('./test/data/poverty.csv', "children_in_poverty")
    end

    def test_it_can_group_median_household_income_data
      data =
      {
        "Colorado"=>
        [
          {:name=>"Colorado",
             :median_household_income=>{[2005, 2009]=>56222}},
           {:name=>"Colorado",
              :median_household_income=>{[2006, 2010]=>56456}}],
       "ACADEMY 20"=>
       [
         {:name=>"ACADEMY 20",
            :median_household_income=>{[2005, 2009]=>85060}},
          {:name=>"ACADEMY 20",
             :median_household_income=>{[2006, 2010]=>85450}}],
        "ADAMS COUNTY 14"=>
        [
          {:name=>"ADAMS COUNTY 14",
             :median_household_income=>{[2005, 2009]=>41382}},
           {:name=>"ADAMS COUNTY 14",
              :median_household_income=>{[2006, 2010]=>40740}}],
        "ADAMS-ARAPAHOE 28J"=>
         [
           {:name=>"ADAMS-ARAPAHOE 28J",
              :median_household_income=>{[2005, 2009]=>43893}},
            {:name=>"ADAMS-ARAPAHOE 28J",
               :median_household_income=>{[2006, 2010]=>44007}}],
        "AGATE 300"=>
          [
            {:name=>"AGATE 300",
               :median_household_income=>{[2005, 2009]=>64167}},
             {:name=>"AGATE 300",
                :median_household_income=>{[2006, 2010]=>64145}}]}
      assert_equal data,
      group_by_district_name(
      './test/data/median_household_income.csv', "median_household_income")
    end

end
