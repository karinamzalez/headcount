## Headcount

Find the assignment here: https://github.com/turingschool/curriculum/blob/master/source/projects/headcount.markdown

Headcount is a database for storing and analyzing school district data from Colorado.

Headcount is made up of a number of repositories that store categories of information. We have a total of four repositories:

*Enrollment Repository:*
Stores enrollment objects, one per district, which contain information about kindergarten participation and high school graduation rates.

*Statewide Test Repository:*
Stores statewide test objects, one per district, which contain information about third and eighth grade proficiency in reading, writing, and math as well as reading, writing, and math scores for various race and ethnicity groups.

*Economic Profile Repository:*
Stores economic profile objects, one per district, which contain information on median household incomes, children in poverty, data about students who qualify for free and reduced price lunch, and title I information.

*District Repository:*
The district repository is the top level of the database. It stores district objects by name and can access information from all other repositories.

The culminating piece of the database is the headcount analyst. The analyst accesses districts from the district repository and their corresponding enrollment, testing, or economic profile data and calculates trends and relationships between various data.

​
#In order to run this program in development, perform the following commands:
​
1 .  Clone the repository
Find the project on GitHub:
https://github.com/karinamzalez/headcount
Copy the SSH key and clone the repository.
​
```
$ git clone
```
​
2 . cd into the directory
```
$ cd headcount
```
​
3 . Run the program
Create a new file with a new instance of a district repository object and load it with data. Then create a new headcount analyst object and give the district repository as the parameter. Run any methods from belonging to the headcount analyst. See headcount_analyst.rb  and headcount_analyst_test.rb for details and examples. 
```
$ ruby <your_headcount_analyst_file.rb>
```
​
4 . Run the tests
```
$ rake
```
