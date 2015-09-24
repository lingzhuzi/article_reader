require 'rails_helper'

RSpec.describe "articals/show", type: :view do
  before(:each) do
    @artical = assign(:artical, Artical.create!(
      :title => "Title",
      :url => "Url",
      :content => "Content",
      :reader_config => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/Content/)
    expect(rendered).to match(//)
  end
end
