require 'rails_helper'

RSpec.describe CarriersController, type: :controller do

  describe "FedEx API" do
    let(:fedex) { ActiveShipping::FedEx.new(
      login: ENV["FEDEX_LOGIN"],
      password: ENV["FEDEX_PASSWORD"],
      meter: ENV["FEDEX_METER"],
      key: ENV["FEDEX_KEY"],
      account: ENV["FEDEX_ACCT_NUM"],
      test: true
    ) }

    let(:origin) { ActiveShipping::Location.new(
      city: "Great Bend",
      state: "KS",
      zip: "67530",
      country: "US"
    ) }

    let(:destination) { ActiveShipping::Location.new(
      city: "Beverly Hills",
      state: "CA",
      zip: "90210",
      country: "US"
    ) }

    let(:package) { ActiveShipping::Package.new(
      100, [25, 40, 30]
    ) }

    context "response from active_shipping::FedEx" do
      it "is successful" do
        fedex
        expect(response.response_code).to eq(200)
      end

      # it "fails when invalid credentials (400)" do
      #   fedex_invalid
      #   expect(response.response_code).to eq(400)
      # end

      describe "#index" do
        it "returns json" do
          get :index

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
    end
  end
end
