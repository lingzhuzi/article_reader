require 'rails_helper'

RSpec.describe "articals/new", type: :view do
  before(:each) do
    assign(:artical, Artical.new(
      :title => "MyString",
      :url => "MyString",
      :content => "MyString",
      :reader_config => nil
    ))
  end

  it "renders new artical form" do
    render

    assert_select "form[action=?][method=?]", articals_path, "post" do

      assert_select "input#artical_title[name=?]", "artical[title]"

      assert_select "input#artical_url[name=?]", "artical[url]"

      assert_select "input#artical_content[name=?]", "artical[content]"

      assert_select "input#artical_reader_config_id[name=?]", "artical[reader_config_id]"
    end
  end
end
