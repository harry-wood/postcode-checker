RSpec.describe PostcodeAllowedList do
  describe "#allowed?" do
    before do
      allow(PostcodeAllowedList).to receive(:postcodes).and_return(
        %w[SH241AA SH241AB]
      )
    end

    context "when given a postcode from the list" do
      it "returns true" do
        expect(PostcodeAllowedList.allowed?("SH241AA")).to be true
      end
    end

    context "when given a postcode from the list but whitespace chars" do
      it "ignores whitespace and returns true" do
        expect(PostcodeAllowedList.allowed?("\tSH24 1AA\n")).to be true
      end
    end

    context "when given a postcode not on the list" do
      it "returns false" do
        expect(PostcodeAllowedList.allowed?("XYZ")).to be false
      end
    end
  end
end
