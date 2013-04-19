require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the CoursesHelper. For example:
#
# describe CoursesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ScrapeBrkeleyCoursesHelper do
  
  describe "#generate_all" do
     it "call createAll in Course" do
       helper.generate_all.should eq()
     end
  end

end