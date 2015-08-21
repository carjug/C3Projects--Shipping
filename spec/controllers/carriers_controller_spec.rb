require 'rails_helper'
require 'support/vcr_setup'

RSpec.describe CarriersController, type: :controller do
  let(:shipping_params) do
    {
      "origin"=>{
              "city"=>"Great Bend",
              "state"=>"KS",
              "zip"=>"67530",
              "country"=>"US"
              },
      "destination"=>{
            "city"=>"SEATTLE",
            "state"=>"WA",
            "zip"=>"98112",
            "country"=>"US"
          },
      "packages"=>[
          [20, [20, 10, 10]],
          [20, [20, 10, 10]],
          [20, [20, 10, 10]]
          ]
        }
    end

  let(:origin_params) do
    {
      origin: {
        city:   "Beverly Hills",
        state:   "CA",
        zip:     "90210",
        country: "US"
      }
    }
  end

    describe "set_fedex" do
      it "has valid ENV credentials" do
        VCR.use_cassette('set fedex') do
          expect(controller.send(:set_fedex).valid_credentials?).to eq true
        end
      end
    end

     describe "set_ups" do
      it "has valid ENV credentials" do
        VCR.use_cassette('set ups') do
          expect(controller.send(:set_ups).valid_credentials?).to eq true
        end
      end
    end

#not working
  describe "#index" do
    it "accepts json object" do
      VCR.use_cassette('returns json object') do
        post :index, shipping_params, { format: :json }

        expect(response.header['Content-Type']).to include 'application/json'
      end
    end
  end
end
