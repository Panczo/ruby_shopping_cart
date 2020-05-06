require 'spec_helper'
require_relative '../checkout.rb'

RSpec.describe Checkout do

  describe '#total' do
    let(:rules) do
      [
        {
          individual: {
            predicate: -> (items) { items.select {|i| i[:name] == 'Red Scarf' }.size >= 2 },
            apply: -> (items)     { items.select {|i| i[:name] == 'Red Scarf' }.each { |i| i[:price] = 8.5 } }
          }
        },
        {
          total: {
            predicate: -> (items) { items.map { |i| i[:price] }.sum > 60 }
          }
        }
      ]
    end

    let(:items) do
      [
        {
          id: '001',
          name: 'Red Scarf',
          price: 9.25
        },
        {
          id: '002',
          name: 'Silver cufflinks',
          price: 45.00
        },
        {
          id: '003',
          name: 'Silk Dress',
          price: 19.95
        }
      ]
    end

    let(:checkout) { Checkout.new(rules) }

    it 'returns price with promotion over 60' do
      checkout.scan(items[0])
      checkout.scan(items[1])
      checkout.scan(items[2])

      expect(checkout.total).to eq 66.78
    end

    it 'returns price with promotion for the same products' do
      checkout.scan(items[0])
      checkout.scan(items[2])
      checkout.scan(items[0])

      expect(checkout.total).to eq 36.95
    end

    it 'returns price with promotion for the same products and over 60' do
      checkout.scan(items[0])
      checkout.scan(items[1])
      checkout.scan(items[0])
      checkout.scan(items[2])

      expect(checkout.total).to eq 73.76
    end
  end
end
