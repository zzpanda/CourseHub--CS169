# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Dummy User
@al = User.create(:username=>"Al",:password=>"password",:email=>"Joe@berkeley.edu")
@bob = User.create(:username=>"Bob",:password=>"password",:email=>"bob@berkeley.edu")

# Some Courses
@CS169 = Course.create(:name=>"Software Engineering",:department=>"CS",:course_number=>"169")
Course.create(:name=> "Algorithms",:department=> "CS",:course_number=> "170")
Course.create(:name=> "Databases",:department=> "CS",:course_number=> "186")

@Math1A = Course.create(:name=> "Calculus",:department=> "Math",:course_number=> "1A")
@Math1B = Course.create(:name=> "Calculus",:department=> "Math",:course_number=> "1B")

# Some Semesters
@Spring = Semester.create(:term=> "Spring", :year=>2013)
@Fall = Semester.create(:term=> "Fall", :year=>2012)

# Some Semester-Classes
@cs169_spring = Coursem.create(:course_id=>@CS169.id,:semester_id=>@Spring.id,:professor=>"Necula", :coursem_info=>"Make web applications using Rails, Django or NodeJS")

Coursem.create(:course_id=>@CS169.id,:semester_id=>@Fall.id,:coursem_info=>"Making web applications using Rails or Django",:professor=>"Fox")

Coursem.create(:course_id=>@Math1A.id,:semester_id=>@Spring.id,:professor=>"Steel", :coursem_info=> "This sequence is intended for majors in engineering and the physical sciences. An introduction to differential and integral calculus of functions of one variable, with applications and an introduction to transcendental functions.")
Coursem.create(:course_id=>@Math1B.id,:semester_id=>@Fall.id,:professor=>"Vojta", :coursem_info=>"Continuation of 1A. Techniques of integration; applications of integration. Infinite sequences and series. First-order ordinary differential equations. Second-order ordinary differential equations; oscillation and damping; series solutions of ordinary differential equations.")

# Create Some Resources
Homework.create(:name=>"Homework 1",:type=>"Homework",:link=>"http://google.com",:user_id=>@al.id, :coursem_id=>@cs169_spring.id)
Homework.create(:name=>"Homework 2",:type=>"Homework",:link=>"http://google.com",:user_id=>@al.id, :coursem_id=>@cs169_spring.id)
Exam.create(:name=>"Spring 2009 Exam",:type=>"Exam",:link=>"http://google.com",:user_id=>@bob.id, :coursem_id=>@cs169_spring.id)

#Create Some Events
yesterday = Date.current - 1.day
today = Date.current
t1 = Time.now
t2 = Time.now.midnight
sdt1 = Event.datetimefromobjects(today,t1)
edt1 = Event.datetimefromobjects(today,t2)
sdt2 = Event.datetimefromobjects(today,t1 - 24.hours)
edt2 = Event.datetimefromobjects(today,t2 - 24.hours)

Event.create(:name=>"HW for Coursem 1",:start_date=>today,:end_date=>today, :start_time=>t1.strftime("%I:%M:%S %z"), :end_time=>t2.strftime("%I:%M:%S %z"), :start_at=>sdt1, :end_at=>edt1, :coursem_id => 1)
Event.create(:name=>"HW for Coursem 3",:start_date=>yesterday,:end_date=>yesterday, :start_time=>t1.strftime("%I:%M:%S %z"), :end_time=>t2.strftime("%I:%M:%S %z"), :start_at=>sdt2, :end_at=>edt2, :coursem_id => 3)