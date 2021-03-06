include Set::Abstract::Calculation

# <OVERRIDES>
def rating?
  true
end

def ten_scale?
  true
end

def formula_editor
  :rating_editor
end

def formula_core
  :rating_core
end

def calculator_class
  ::Formula::WikiRating
end
# </OVERRIDES>

event :create_formula, :initialize, on: :create do
  ensure_subfield :formula, content: "{}"
end

format do
  def value_legend
    "0-10"
  end
end

format :html do
  # TODO: hamlize
  def weight_row weight=0, label=nil
    label ||= _render_thumbnail_no_link
    weight = weight_content weight
    output([wrap_with(:td, label, class: "metric-label"),
            wrap_with(:td, weight, class: "metric-weight")]).html_safe
  end

  def weight_content weight
    icon_class = "pull-right _remove-weight btn btn-outline-secondary btn-sm"
    wrap_with :div do
      [text_field_tag("pair_value", weight) + "%",
       content_tag(:span, fa_icon(:close).html_safe, class: icon_class)]
    end
  end
end
