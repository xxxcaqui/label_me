#coding:utf-8
require "spec_helper"

describe LabelMe::Order do
  before do
    @order = LabelMe::SalesAll::Object.parse("spec/csv/sales_all.csv").first
  end

  describe "attributes" do
    describe "#number" do
      it "should return order number" do
        expect(@order.number).to eq(12342345)
      end
    end

    describe "#order_date" do
      it "should return order date" do
        expect(@order.order_date).to eq(Date.new(2013,1,18))
      end
    end

    describe "#paid?" do
      it "should return payment status" do
        expect(@order.paid?).to eq(true)
      end
    end

    describe "#shipping_charge" do
      it "should return shipping charge" do
        expect(@order.shipping_charge).to eq(600)
      end
    end

    describe "#message_card_charge" do
      it "should return message card chaarge" do
        expect(@order.message_card_charge).to eq(0)
      end
    end

    describe "#customer" do
      it "should return instance of LabelMe::Order::Customer" do
        expect(@order.customer).to be_an_instance_of(LabelMe::Order::Customer)
      end
    end

    describe "#recipients" do
      it "should return instances of LabelMe::Order::Recipient" do
        recipients = @order.recipients
        expect(recipients).to be_an_instance_of(Array)
        expect(recipients.size).to eq(1)
        expect(recipients.all?{|recipient| recipient.is_a? LabelMe::Order::Recipient }).to be_true
      end
    end
  end

  describe "#to_hash" do
    it "should return Hash" do
      hash = @order.to_hash
      expect(hash[:number]).to eq(12342345)
      expect(hash[:order_date]).to eq(Date.new(2013,1,18))
      expect(hash[:paid]).to eq(true)
      expect(hash[:shipping_charge]).to eq(600)
      expect(hash[:message_card_charge]).to eq(0)
      expect(hash[:customer_attributes]).to eq(@order.customer.to_hash)
      expect(hash[:recipients_attributes]).to eq([@order.recipients.first.to_hash])
    end
  end

  describe "#===" do
    before do
      @order1 = LabelMe::SalesAll::Object.parse("spec/csv/sales_all.csv").first
      @order2 = LabelMe::SalesAll::Object.parse("spec/csv/sales_all.csv").first
    end

    context "same attributes" do
      it "should return true" do
        expect(@order1 === @order2).to eq(true)
      end
    end

    context "different attributes" do
      it "should return false" do
        @order2.number = 1
        expect(@order1 === @order2).to eq(false)
      end
    end
  end
end
