require 'rails_helper'

RSpec.describe "posts/show.html.erb", type: :view do
  it "renders 'show' template" do
    render :template => "posts/show"
    expect(rendered).to match /Here show post by ID/
  end
end 
