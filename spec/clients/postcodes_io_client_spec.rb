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

    context "when given a not found postcode" do
      before do
        stub_request(:get, "http://postcodes.io/postcodes/XX1%201XX")
          .to_return(status: 404, body: File.read(
            "spec/dummy_data/postcodes_io_responses/not_found.json"
          ))
      end

      it "raises a not found error" do
        expect { subject.postcode_data("XX1 1XX") }
          .to raise_error(PostcodesIoClient::NotFoundError)
      end
    end

    context "when postcodes.io returns a 500 error" do
      before do
        stub_request(:get, "http://postcodes.io/postcodes/SE1%207QD")
          .to_return(status: 500, body: "Postcodes.io is broken!")
      end

      it "raises an error" do
        expect { subject.postcode_data("SE1 7QD") }
          .to raise_error(
            PostcodesIoClient::Error,
            "Error:500 response calling url:http://postcodes.io/postcodes/SE1 7QD"
          )
      end
    end
  end
end
