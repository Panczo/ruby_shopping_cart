# frozen_string_literal: true

module PromotionalRules
  class PromotionFactory
    include ::GlobalDictionary::Dictionary

    PROMOTION_RULES = {
        INDIVIDUAL => -> (_) { IndividualRules.new },
        TOTAL => -> (_) { TotalRules.new }
    }.freeze

    MISSING_METHOD = ->(type) { raise UnsupportedPromotionRulesError, "Unsupported Promotion Rules type: #{type}" }

    def self.for(promotion_type)
      REQUEST_RUNNERS.fetch(promotion_type.downcase, MISSING_METHOD).call(promotion_type)
    end
  end
end
