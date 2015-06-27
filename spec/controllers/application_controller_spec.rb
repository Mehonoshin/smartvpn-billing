require 'spec_helper'

describe ApplicationController do

  controller do
    def index
      raise CanCan::AccessDenied, "Unauthorized"
    end
  end

  describe "not signed in as user" do
    it "raises error" do
      get :index
      expect(response).to redirect_to billing_root_path
    end
  end

end
