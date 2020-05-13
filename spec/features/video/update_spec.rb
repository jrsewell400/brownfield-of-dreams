require 'rails_helper'

describe "videos" do
  it "I can update videos" do
    admin = create(:admin)
    video = create(:video)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    #placeholder for updating videos test
  end
end
