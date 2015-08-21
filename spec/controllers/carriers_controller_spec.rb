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

    let(:invalid_params) do
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
              "zip"=>"84105",
              "country"=>"US"
            },
        "packages"=>[
            [20, [20, 10, 10]],
            [20, [20, 10, 10]],
            [20, [20, 10, 10]]
            ]
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

  describe "#index" do
    it "responds successful" do
      VCR.use_cassette('returns successful status code') do
        post :index, shipping_params, { format: :json }

        expect(response.response_code).to eq 200
      end
    end

    it "responds with 204 when unsuccesful" do
      VCR.use_cassette('returns unsuccessful status code') do
        post :index, invalid_params, { format: :json }

        expect(response).to be_an_instance_of(ActiveShipping::ResponseError)
      end
    end

    it "accepts json object" do
      VCR.use_cassette('returns json object') do
        post :index, shipping_params, { format: :json }

        expect(response.header['Content-Type']).to include 'application/json'
      end
    end
  end
end
