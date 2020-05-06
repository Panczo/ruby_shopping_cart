require 'pry'

class Checkout
  def initialize(checkout_rules)
    @checkout_rules = checkout_rules
    @items = []
  end

  def scan(item)
    @items << item
  end

  def total
      individual_rules = @checkout_rules.select { |rule| rule.has_key?(:individual) && rule[:individual][:predicate].call(@items) }
      individual_rules.each { |rule| rule[:individual][:apply].call(@items) }

      total_rules = @checkout_rules.select { |rule| rule.has_key?(:total) && rule[:total][:predicate].call(@items) }
      total = @items.sum {|i| i[:price] }
      total_rules.empty? ? total : (total * 0.9).round(2)
  end
end

rules = [
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

items = [
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

# co = Checkout.new(rules)
# co.scan(items[0])
# co.scan(items[1])
# co.scan(items[0])
# co.scan(items[2])
# puts co.total
