# frozen_string_literal: true

module PromotionalRules
  class PromotionRunner
    include ::GlobalDictionary::Dictionary

    def self.for(promotional_rules, type)
      promotion_type = promotional_rules.fetch(type, )
      ::PromotionalRules::PromotionFactory.for(promotion_type)
    end
  end
end
