require 'rails_helper'

RSpec.describe CarriersController, type: :controller do
  let(:carrier) { Carrier.create(id: 1, name: "fedex") }

  describe "#show" do
    it "response is successful" do
      get :show, id: carrier.id

      expect(response.response_code).to eq 200
    end
  end
end
