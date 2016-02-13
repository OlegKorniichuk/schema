require 'spec_helper'

describe "full example" do
  let(:root) { File.join(File.dirname(__FILE__), '../../meta/kernel-4') }
  let(:xsd) { Dir.chdir(root) { Nokogiri::XML::Schema(File.read("metadata.xsd")) }}
  let(:doc) { Dir.chdir(root) { Nokogiri::XML(File.read("example/datacite-example-GeoLocation-v4.0.xml")) }}

  it 'validates' do
    expect(doc).to pass_validation(xsd)
  end

  it 'has geoLocation' do
    geo_locations = doc.search("geoLocation")
    expect(geo_locations.size).to eq(1)
    geo_location = geo_locations.first
    expect(geo_location.elements.size).to eq(2)
    geo_location_point = geo_location.first_element_child
    expect(geo_location_point.name).to eq("geoLocationPoint")
    expect(geo_location_point.text).to eq("69.000000 -52.000000")
    geo_location_place = geo_location.last_element_child
    expect(geo_location_place.name).to eq("geoLocationPlace")
    expect(geo_location_place.text).to eq("Disko Bay")
  end
end
