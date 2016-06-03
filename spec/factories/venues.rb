FactoryGirl.define do
  factory :venue do
    name "Dillion's"
    phone "+1-617-421-1818"
    category "Bar"
    address "955 Boylston St"
    city "Boston"
    postal_code "02115"
    state_code "MA"
    rating 3
    photo "http://www.dillonsboston.com/files/Dillons_Exterior_33-578x328.jpg"
    latitude 42.3479653914953
    longitude (-71.0858754834292)
    url "http://www.yelp.com/biz/dillons-boston?utm_campaign=yelp_api&utm_medium=api_v2_search&utm_source=-Cb1yajNnIcLuAbIyK0PjQ"
    yelp_id "dillons-boston"
  end
end
