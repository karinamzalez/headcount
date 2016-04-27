module GradeTestOutputs

  def grade_raw_data_output
    [
      {
        :location=>"ADAMS COUNTY 14", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.56"
      },
      {
        :location=>"ADAMS COUNTY 14", :score=>"Math", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.54"
      },
      {
        :location=>"ADAMS COUNTY 14", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.523"
      },
      {
        :location=>"ADAMS COUNTY 14", :score=>"Reading", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.562"
      },
      {
        :location=>"ADAMS COUNTY 14", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.426"
      },
      {
        :location=>"ADAMS COUNTY 14", :score=>"Writing", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.479"
      },
      {
        :location=>"ADAMS-ARAPAHOE 28J", :score=>"Math", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.473"
      },
      {
        :location=>"ADAMS-ARAPAHOE 28J", :score=>"Math", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.456"
      },
      {
        :location=>"ADAMS-ARAPAHOE 28J", :score=>"Reading", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.466"
      },
      {
        :location=>"ADAMS-ARAPAHOE 28J", :score=>"Reading", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.483"
      },
      {
        :location=>"ADAMS-ARAPAHOE 28J", :score=>"Writing", :timeframe=>"2008", :dataformat=>"Percent", :data=>"0.339"
      },
      {
        :location=>"ADAMS-ARAPAHOE 28J", :score=>"Writing", :timeframe=>"2009", :dataformat=>"Percent", :data=>"0.359"
      }
    ]
  end

  def grade_delete_ouput
    [
      {
        :location=>"ADAMS COUNTY 14", :score=>"Math", :timeframe=>"2008", :data=>"0.56"
      },
      {
        :location=>"ADAMS COUNTY 14", :score=>"Math", :timeframe=>"2009", :data=>"0.54"
      },
      {
        :location=>"ADAMS COUNTY 14", :score=>"Reading", :timeframe=>"2008", :data=>"0.523"
      },
      {
        :location=>"ADAMS COUNTY 14", :score=>"Reading", :timeframe=>"2009", :data=>"0.562"
      },
      {
        :location=>"ADAMS COUNTY 14", :score=>"Writing", :timeframe=>"2008", :data=>"0.426"
      },
      {
        :location=>"ADAMS COUNTY 14", :score=>"Writing", :timeframe=>"2009", :data=>"0.479"
      },
      {
        :location=>"ADAMS-ARAPAHOE 28J", :score=>"Math", :timeframe=>"2008", :data=>"0.473"
      },
      {
        :location=>"ADAMS-ARAPAHOE 28J", :score=>"Math", :timeframe=>"2009", :data=>"0.456"
      },
      {
        :location=>"ADAMS-ARAPAHOE 28J", :score=>"Reading", :timeframe=>"2008", :data=>"0.466"
      },
      {
        :location=>"ADAMS-ARAPAHOE 28J", :score=>"Reading", :timeframe=>"2009", :data=>"0.483"
      },
      {
        :location=>"ADAMS-ARAPAHOE 28J", :score=>"Writing", :timeframe=>"2008", :data=>"0.339"
      },
      {
        :location=>"ADAMS-ARAPAHOE 28J", :score=>"Writing", :timeframe=>"2009", :data=>"0.359"
      }
    ]
  end

  def grade_format_each_line_output
    [
      {
        :name=>"ADAMS COUNTY 14",
        :third_grade_proficiency=>{2008=>{:math=>0.56}}
      },
      {
        :name=>"ADAMS COUNTY 14",
        :third_grade_proficiency=>{2009=>{:math=>0.54}}
      },
      {
        :name=>"ADAMS COUNTY 14",
        :third_grade_proficiency=>{2008=>{:reading=>0.523}}
      },
      {
        :name=>"ADAMS COUNTY 14",
        :third_grade_proficiency=>{2009=>{:reading=>0.562}}
      },
      {
        :name=>"ADAMS COUNTY 14",
        :third_grade_proficiency=>{2008=>{:writing=>0.426}}
      },
      {
        :name=>"ADAMS COUNTY 14",
        :third_grade_proficiency=>{2009=>{:writing=>0.479}}
      },
      {
        :name=>"ADAMS-ARAPAHOE 28J",
        :third_grade_proficiency=>{2008=>{:math=>0.473}}
      },
      {
        :name=>"ADAMS-ARAPAHOE 28J",
        :third_grade_proficiency=>{2009=>{:math=>0.456}}
      },
      {
        :name=>"ADAMS-ARAPAHOE 28J",
        :third_grade_proficiency=>{2008=>{:reading=>0.466}}
      },
      {
        :name=>"ADAMS-ARAPAHOE 28J",
        :third_grade_proficiency=>{2009=>{:reading=>0.483}}
      },
      {
        :name=>"ADAMS-ARAPAHOE 28J",
        :third_grade_proficiency=>{2008=>{:writing=>0.339}}
      },
      {
        :name=>"ADAMS-ARAPAHOE 28J",
        :third_grade_proficiency=>{2009=>{:writing=>0.359}}
      }
    ]
  end

  def grade_group_lines_by_district
    {
      "ADAMS COUNTY 14"=>
      [
        {
          :name=>"ADAMS COUNTY 14",
          :third_grade_proficiency=>{2008=>{:math=>0.56}}
        },
        {
          :name=>"ADAMS COUNTY 14",
           :third_grade_proficiency=>{2009=>{:math=>0.54}}
        },
        {
          :name=>"ADAMS COUNTY 14",
          :third_grade_proficiency=>{2008=>{:reading=>0.523}}
        },
        {
          :name=>"ADAMS COUNTY 14",
          :third_grade_proficiency=>{2009=>{:reading=>0.562}}
        },
        {
          :name=>"ADAMS COUNTY 14",
          :third_grade_proficiency=>{2008=>{:writing=>0.426}}
        },
        {
          :name=>"ADAMS COUNTY 14",
          :third_grade_proficiency=>{2009=>{:writing=>0.479}}}
      ],
      "ADAMS-ARAPAHOE 28J"=>
      [
        {
          :name=>"ADAMS-ARAPAHOE 28J",
          :third_grade_proficiency=>{2008=>{:math=>0.473}}
        },
        {
          :name=>"ADAMS-ARAPAHOE 28J",
          :third_grade_proficiency=>{2009=>{:math=>0.456}}
        },
        {
          :name=>"ADAMS-ARAPAHOE 28J",
          :third_grade_proficiency=>{2008=>{:reading=>0.466}}
        },
        {
          :name=>"ADAMS-ARAPAHOE 28J",
          :third_grade_proficiency=>{2009=>{:reading=>0.483}}
        },
        {
          :name=>"ADAMS-ARAPAHOE 28J",
          :third_grade_proficiency=>{2008=>{:writing=>0.339}}
        },
        {
          :name=>"ADAMS-ARAPAHOE 28J",
          :third_grade_proficiency=>{2009=>{:writing=>0.359}}}
      ]
    }
  end
end
