class Rule
  def initialize(lambda_rule)
    @lambda_rule = lambda_rule
  end

  def discount(shopping_list)
    @lambda_rule.call(shopping_list) || 0
  end
end
