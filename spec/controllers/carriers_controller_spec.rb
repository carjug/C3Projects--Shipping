require 'rails_helper'
require 'httparty'

RSpec.describe CarriersController, type: :controller do

  describe "FedEx API" do
    let(:uri) {
      "http://localhost:3001/api/v1/carriers/"
    }

    # let(:fedex) { ActiveShipping::FedEx.new(
    #   login:    ENV["FEDEX_LOGIN"],
    #   password: ENV["FEDEX_PASSWORD"],
    #   meter:    ENV["FEDEX_METER"],
    #   key:      ENV["FEDEX_KEY"],
    #   account:  ENV["FEDEX_ACCT_NUM"],
    #   test: true
    # ) }

    # let(:origin) {
    #   city: "Great Bend",
    #   state: "KS",
    #   zip: "67530",
    #   country: "US"
    # }

    # let(:destination) {
    #   city: "Beverly Hills",
    #   state: "CA",
    #   zip: "90210",
    #   country: "US"
    # }

    # let(:packages) {
    #   [
    #     [100, [25, 40, 30]]
    #     [100, [25, 40, 30]
    #   ]
    # }

    let(:shipping_params) {
      {"origin"=>{
              "city"=>"Great Bend",
              "state"=>"KS",
              "zip"=>"67530",
              "country"=>"US"
              },
            "destination"=>{
              "city"=>"SEATTLE",
              "state"=>"WA",
              "zip"=>"98112"
            },
             "packages"=>[
              [20, [20, 10, 10]],
              [20, [20, 10, 10]],
              [20, [20, 10, 10]]
            ]
          }
        }

      describe "#index" do
        it "accepts json object" do
          # post :index, shipping_params
            response = HTTParty.post(
                uri,
                headers: {
                  "Content-Type" => "application/json"
                },
                body: shipping_params.to_json
              )

          expect(response.header['Content-Type']).to include 'application/json'
        end
      end

      describe "#shipping" do
        it "is successful" do
          get :fedex_shipping, origin: origin, destination: destination, package: package

          expect(response.response_code).to eq 200
        end
      end
    end

    context "sending object to bEtsy" do
      # it "creates the shipping object" do
        # get :fedex_shipping, origin: origin, destination: destination, package: package


      # end

      # describe "#index" do
      #   it "returns an array of attributes for the FedEx response" do
      #     get :index,

      #     expect(@rate.class).to be_an_instance_of Array
      #   end
      # end
    # end
  end
end
