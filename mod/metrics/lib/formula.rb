# module for organizing Calculator and Input classes
module Formula
  def self.calculator_class content
    [Translation, Ruby].find { |klass| klass.valid_formula? content } || Wolfram
  end
end