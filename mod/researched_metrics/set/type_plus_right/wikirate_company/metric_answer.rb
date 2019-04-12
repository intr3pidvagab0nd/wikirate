# Answer search for a given Company
include_set Abstract::AnswerSearch

def query_class
  FixedCompanyAnswerQuery
end

def filter_card_fieldcode
  :company_metric_filter
end

def default_sort_option
  :importance
end

format :html do
  before(:filter_result) { voo.hide! :chart }

  def table_args
    [:metric,
     self, # call search_with_params on self to get items
     [:metric_thumbnail_with_vote, :value_cell],
     header: [name_sort_links, "Value"],
     details_view: :metric_details_sidebar]
  end

  def name_sort_links
    "#{importance_sort_link}#{designer_sort_link}#{title_sort_link}"
  end

  def title_sort_link
    table_sort_link "Metrics", :title_name, "pull-left margin-left-20"
  end

  def designer_sort_link
    table_sort_link "", :designer_name, "pull-left margin-left-20"
  end

  def importance_sort_link
    table_sort_link "", :importance, "pull-left  margin-left-15"
  end
end