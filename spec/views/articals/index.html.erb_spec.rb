require 'rails_helper'

RSpec.describe "articals/index", type: :view do
  before(:each) do
    assign(:articals, [
      Artical.create!(
        :title => "Title",
        :url => "Url",
        :content => "Content",
        :reader_config => nil
      ),
      Artical.create!(
        :title => "Title",
        :url => "Url",
        :content => "Content",
        :reader_config => nil
      )
    ])
  end

  it "renders a list of articals" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
