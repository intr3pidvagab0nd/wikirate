include_set Abstract::Filter

format :html do
  def filter_header
    <<-HTML
      <div class="filter-header">
        <span class="glyphicon glyphicon-filter"></span>
          #{filter_title}
        <span class="filter-toggle">
          <span class="glyphicon glyphicon-triangle-right"></span>
        </span>
      </div>
    HTML
  end

  def filter_title
    "Filter & Sort"
  end

  view :core do
    binding.pry
    action = card.cardname.left_name.url_key
    filter_active = filter_active? ? "block" : "none"
    <<-HTML
    <div class="filter-container">
        #{filter_header}
        <div class="filter-details" style="display: #{filter_active};">
          <form action="/#{action}?view=#{content_view}" method="GET" data-remote="true" class="slotter">
            #{filter_form}
          </form>
        </div>
    </div>
    HTML
  end

  def filter_form
  <<-HTML
      <div class="margin-12 sub-content">
        #{main_filter_formgroups}
    #{_optional_render_sort_formgroup}
      </div>
      <div class="filter-buttons">
        #{filter_button_formgroup} # FIXME wrong buttons check for view button_formgroup in old code
      </div>
  HTML
  end
end
