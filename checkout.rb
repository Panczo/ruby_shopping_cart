promotional_rules = {
  individual: [
    { product_code: '001', rule: '> 1', new_price: '8.5' }
  ],
  total: [
    { rule: '> 60', new_price: '10%' }
  ]
}

class Checkout
  def initialize(promotional_rules)
    @promotional_rules = promotional_rules
  end
end
