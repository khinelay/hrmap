require "spec_helper"

describe PublicController do
  describe "routing" do

    it "routes to #dashboard" do
      get("/").should route_to("public#dashboard")
    end

  end
end
