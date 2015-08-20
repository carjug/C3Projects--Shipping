fedex = ActiveShipping::FedEx.new(login:"", key:"", account:"", meter:"", password:"", tests:true)

o = ActiveShipping::Location.new(country: "US", state: "KS", city: "Great Bend", zip: "67530")

d = ActiveShipping::Location.new(country: "US", state: "CA", city: "Beverly Hills", zip: "90210")

package = ActiveShipping::Package.new(2, [10, 20, 12])

fedex.find_rates(o, d, [package])


HTTParty.post(API_URI,
  headers: {
    "Content-Type" => "application/json"
  },

  body: {
   origin: ORIGIN,
   destination: destination,
   packages: @packages
 })
