require "oystercard"

describe Oystercard do
  before :each do
    @card = Oystercard.new
  end
  it "has a balance of 0 when created" do
    expect(@card.balance).to eq(0)
  end

  it "Tops up the card by 10 from 0" do
    @card.top_up(10)
    expect(@card.balance).to eq 10
  end

  it "Tops up the card by 20 from 0" do
    @card.top_up(20)
    expect(@card.balance).to eq 20
  end

  it "raises an error if topping up goes over the limit" do
    message = "will take card over balance limit #{Oystercard::LIMIT}"
    expect { @card.top_up(Oystercard::LIMIT + 1) }.to raise_error(message)
  end

  it "deducts 4 from balance for a long fare" do
    @card.top_up(10)
    @card.deduct(4)
    expect(@card.balance).to eq 6
  end

  it "deducts 2 from the balance for a short fare" do
    @card.top_up(10)
    @card.deduct(2)
    expect(@card.balance).to eq 8
  end

  it "is not in the middle of a journey when created" do
    expect(@card.in_journey?).to eq(false)
  end

  it "is in a journey after touching in" do
    @card.touch_in
    expect(@card.in_journey?).to eq(true)
  end

  it "is not in a journey after touching out" do
    @card.touch_out
    expect(@card.in_journey?).to eq(false)
  end
end
