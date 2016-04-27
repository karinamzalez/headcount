# require_relative '../lib/statewide_test'
# require "csv"
# require_relative '../lib/parser_grade'
# require_relative '../lib/parser_subject_proficiency'
#
#
# class StatewideTestRepository
#   include ParserSubjectProficiency
#   include ParserGrade
#
#   attr_reader :statewide_tests
#
#   def initialize
#     @statewide_tests = []
#   end
#
#   def find_by_name(name)
#     statewide_tests.find { |state_tests| state_tests.name == name.upcase }
#   end
#
#   def load_data(data)
#     3rd_grade_formatted_hash = format
#     math_formatted_hash = format_math_file_to_hash(math_file(data))
# require "pry"; binding.pry
#     #don't need an if statement b/c we'll load all the files at once
#     #want to get all the grade data and race data into one hash
#           #after we get individual data from parser
#     formatted_hashes.each do |hash|
#       @statewide_tests << StatewideTest.new(hash)
#     end
#   end
#
#   def math_file(data)
#     data[:statewide_testing][:math]
#   end
#
#   def format_3rd_grade_file_to_hash
#
#   end
#
#   def format_math_file_to_hash(math_file)
#     group_by_ethnicity(math_file, "math")
#   end
#
#
#
#
#
# end
