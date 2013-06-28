require File.dirname(__FILE__) + "/spec_helper"

describe Api do

  it "should be in any roles assigned to it" do
    user = Api.new
    user.assign_role("assigned role")
    user.should be_in_role("assigned role")
  end

  it "should_not be in any roles not assigned to it" do
    user = Api.new
    user.should_not be_in_role("unassigned role")
  end


end