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

    # let(:fedex_invalid) {ActiveShipping::FedEx.new(
    #   login: ENV["FEDEX_LOGIN"],
    #   password: "s",
    #   meter: ENV["FEDEX_METER"],
    #   key: ENV["FEDEX_KEY"],
    #   account: ENV["FEDEX_ACCT_NUM"],
    #   test: true
    # )}

    context "response from active_shipping::FedEx" do
      it "is successful" do
        fedex
        expect(response.response_code).to eq(200)
      end

      # it "fails when invalid credentials (400)" do
      #   fedex_invalid
      #   expect(response.response_code).to eq(400)
      # end
    end

    context "sending object to bEtsy" do

    end
  end

end
