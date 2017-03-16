require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:unit_price) }
  it { should validate_presence_of(:merchant_id) }
  it { should belong_to(:merchant) }
  it { should have_many(:invoice_items) }
  it { should have_many(:invoices) }

  it ".random returns an item" do
    Fabricate.times(3, :item)
    expect(Item.random.class).to eq(Item)
  end

  it ".most_revenue(quantity) returns items ordered by quantity" do
    item_one, item_two, item_three = Fabricate.times(3, :item)
    invoice_one, invoice_two, invoice_three = Fabricate.times(3, :invoice)
    Fabricate(:invoice_item, item: item_one, invoice: invoice_one, quantity: 3, unit_price: item_one.unit_price)
    Fabricate(:invoice_item, item: item_two, invoice: invoice_two, quantity: 2, unit_price: item_two.unit_price)
    Fabricate(:invoice_item, item: item_three, invoice: invoice_three, quantity: 1, unit_price: item_three.unit_price)
    Fabricate(:transaction, invoice: invoice_one)
    Fabricate(:transaction, invoice: invoice_two)
    Fabricate(:transaction, invoice: invoice_three)

    items = Item.most_revenue(2)
    expect(items.first.id).to eq(item_one.id)
    expect(items.last.id).to eq(item_two.id)
  end
end
