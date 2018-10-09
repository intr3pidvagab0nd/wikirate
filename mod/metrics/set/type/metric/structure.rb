include_set Abstract::TwoColumnLayout
# include_set Abstract::Listing
include_set Abstract::BsBadge

format :html do
  def left_column_class
    "#{super} metric-info m-0 p-0"
  end

  def right_column_class
    "#{super} wiki"
  end

  view :rich_header do
    vote = field_subformat(:vote_count)._render_content
    bs_layout do
      row 1, 11, class: "metric-header-container border-bottom container p-0 m-0 mt-3" do
        column vote, class: "col-1 pt-1"
        column _render_title_and_question, class: "col-10"
      end
    end
  end

  view :data, cache: :never do
    field_nest :all_metric_values
  end

  view :title_and_question do
    wrap_with :div do
      [_render_metric_title, _render_metric_question]
    end
  end

  view :title_and_question_compact do
    link = link_to_card card, card.metric_title, class: "inherit-anchor"
    wrap_with :div, class: "bg-white" do
      [wrap_with(:div, link, class: "metric-color font-weight-bold"),
       render_metric_question]
    end
  end

  view :metric_title do
    link = link_to_card card, card.metric_title, class: "inherit-anchor"
    wrap_with :h3, link, class: "metric-color"
  end

  view :metric_question do
    wrap_with :div, class: "question blockquote" do
      nest card.question_card, view: :content
    end
  end

  view :designer_info do
    nest card.metric_designer_card, view: :designer_info
  end

  view :designer_info_without_label do
    nest card.metric_designer_card, view: :designer_info_without_label
  end

  view :question_row do
    <<-HTML
      <div class="row metric-details-question">
        <div class="row-icon">
          #{fa_icon 'question', class: 'fa-lg'}
        </div>
        <div class="row-data col-11">
          #{nest card.question_card, view: :core}
        </div>
      </div>
    HTML
  end

  def company_count
    field_nest :wikirate_company, view: :count
  end

  def metric_count
    field_nest :all_metric_values, view: :count
  end
end
