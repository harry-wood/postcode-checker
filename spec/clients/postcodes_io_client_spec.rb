RSpec.describe PostcodesIoClient do
  describe "#postcode_data" do
    context "when given a valid serviced postcode" do
      before do
        stub_request(:get, "http://postcodes.io/postcodes/SE1%207QD")
          .to_return(body: File.read(
            "spec/dummy_data/postcodes_io_responses/servable_postcode.json"
          ))
      end

      let!(:returned_hash) do
        subject.postcode_data("SE1 7QD")
      end

      it "calls the postcodes.io API" do
        expect(
          a_request(:get, "http://postcodes.io/postcodes/SE1%207QD")
        ).to have_been_made.once
      end

      it "returns a hash with fields such as lsoa" do
        expect(
          returned_hash
        ).to match(
          a_hash_including(
            "postcode" => "SE1 7QD",
            "lsoa" => "Southwark 034A"
          )
        )
      end
    end
  end
end
