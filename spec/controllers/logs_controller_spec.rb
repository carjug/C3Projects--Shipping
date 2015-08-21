require 'rails_helper'

RSpec.describe LogsController, type: :controller do
  describe "#create" do
    let(:loggy) do
      {
        log: {
          order_id: 1,
          app_name: "bEtsy",
          carrier_service: "FedEx Two Day"
        }
      }
    end

    it "create a new line in log model" do
      post :create, loggy
      expect(Log.all.count).to eq(1)
    end

  end
end
