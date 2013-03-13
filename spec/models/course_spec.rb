require 'spec_helper'

describe Course do
    it "can be instantiated" do
        Course.new.should be_an_instance_of(Course)
    end

    it "can be saved successfully" do
        Course.create.should be_persisted
    end
end
