# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Dummy User
User.create(:username=>"Joe",:password=>"password",:email=>"Joe@berkeley.edu")

# Some Courses
@CS169 = Course.create(:name=>"Software Engineering",:course_info=>"Make web apps",:department=>"CS",:course_number=>"169")
Course.create(:name=> "Algorithms",:course_info=> "Learn important algorithms of CS",:department=> "CS",:course_number=> "170")
Course.create(:name=> "Databases",:course_info=> "MySQL,Postgresql",:department=> "CS",:course_number=> "186")

@Math1A = Course.create(:name=> "Calculus",:course_info=> "This sequence is intended for majors in engineering and the physical sciences. An introduction to differential and integral calculus of functions of one variable, with applications and an introduction to transcendental functions.",:department=> "Math",:course_number=> "1A")

@Math1B = Course.create(:name=> "Calculus",:course_info=> " Continuation of 1A. Techniques of integration; applications of integration. Infinite sequences and series. First-order ordinary differential equations. Second-order ordinary differential equations; oscillation and damping; series solutions of ordinary differential equations.", :department=> "Math",:course_number=> "1B")


# Some Semesters
@Spring = Semester.create(:term=> "Spring", :year=>2013)
@Fall = Semester.create(:term=> "Fall", :year=>2012)

# Some Semester-Classes
CourseSemester.create(:course_id=>@CS169.id,:semester_id=>@Spring.id,:professor=>"Necula")
CourseSemester.create(:course_id=>@CS169.id,:semester_id=>@Fall.id,:professor=>"Fox")

CourseSemester.create(:course_id=>@Math1A.id,:semester_id=>@Spring.id,:professor=>"Necula")
CourseSemester.create(:course_id=>@Math1A.id,:semester_id=>@Fall.id,:professor=>"Fox")

CourseSemester.create(:course_id=>@Math1B.id,:semester_id=>@Spring.id,:professor=>"Necula")
CourseSemester.create(:course_id=>@Math1B.id,:semester_id=>@Fall.id,:professor=>"Fox")

