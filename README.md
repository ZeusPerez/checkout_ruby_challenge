[Link to the exercise](https://github.com/cabify/rubyChallenge)

# Cabify Ruby Chanllenge

In this document, I explain the solution to the exercise and the motivation of my choices.

## ItemCatalog

I've created this module like a 'stub' for the catalog and hardcoded the items information in a JSON. I think that this information should be in a persistent layer and this module wouldn't be necessary for an application.

## ShoppingCart

This class is responsible for the shopping list. It's where the Checkout and the Rule obtain information about the elements present in the shopping list when we calculate the total.

## Checkout

In this case, I use composition with Rule and ShoppingCart.

As there is no restriction in the formulation of the exercise regarding the input of Checkout, I chose a list of Rule objects but we can include here any object that responds to the `discount` method using a shopping list.

## Rule

In this case, I chose the use of lambdas to create the rules because I think is a dynamic and flexible option at least with simple rules as the formulation. If you want to create a new rule you just have to use the lambda that matches the rule. Also, the concretions will be isolated in those lambdas, being able to modify them just by creating a new Rule. If we want to persist the rules we can save the lambas serialized or make a factory using the condition and the discount (for example provided by the DB or a file) to apply and create the lambdas through metaprogramming.


This option has the disadvantage that if the rules are very complex the lambda will be more complex and it can lose readability.

Another alternative that I assessed for this was using a subclass for each rule. For example:

```ruby
class Rule
  def discount
    if rule_condition(shopping_list)
      calculate_discount(shopping_list)
    else
      0
    end
  end
end

class CfoRule < Rule

  protected

  def rule_condition(shopping_list)
    shopping_list["TSHIRT"].to_i >= 3
  end

  def calculate_discount(shopping_list)
    shopping_list["TSHIRT"]
  end
end
```


The main problem with this option is that escalates very bad if the number of rules grows. We would have a new subclass for each new rule.


The advantages of this option would be that it is more readable and easy to organize if the rules gain complexity. Also, we can apply the Visitor pattern using the rules as visitors. For the creation of new rules, we can create a `RuleFactory` that creates new subclasses using metaprogramming so the creation of rules could be simplified. Anyway, with the given requirements and the size of the problem, this would be over-engineering.

## Tests

I used the Rspec framework for testing. Also, I want to comment that I used the "#" in some `describe`s in order to indicate that the block is testing a specific method (I'm not sure if this notation is used only by me and my coding environment or if it is more extended).
