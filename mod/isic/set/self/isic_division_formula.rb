include_set Abstract::HardCodedFormula

def calculator_class
  Formula::Isic
end

format :html do
  view :core do
    ["The first two digits of:", render_variable_metrics]
  end
end
