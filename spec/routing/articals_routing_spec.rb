require "rails_helper"

RSpec.describe ArticalsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/articals").to route_to("articals#index")
    end

    it "routes to #new" do
      expect(:get => "/articals/new").to route_to("articals#new")
    end

    it "routes to #show" do
      expect(:get => "/articals/1").to route_to("articals#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/articals/1/edit").to route_to("articals#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/articals").to route_to("articals#create")
    end

    it "routes to #update" do
      expect(:put => "/articals/1").to route_to("articals#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/articals/1").to route_to("articals#destroy", :id => "1")
    end

  end
end
