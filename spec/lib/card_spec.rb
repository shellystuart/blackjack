require "spec_helper"

RSpec.describe Card do

  let(:face_card) { Card.new("J", "♦") }
  let(:ace) { Card.new("A", "♦") }
  let(:number_card) { Card.new(8, "♦") }


  describe "#type" do
    it 'returns face card if face card' do
      expect(face_card.type).to eq("face card")
    end

    it 'returns ace if ace card' do
      expect(ace.type).to eq("ace")
    end

    it 'returns number card if number card' do
      expect(number_card.type).to eq("number card")
    end
  end


end
