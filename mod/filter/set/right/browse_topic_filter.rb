include_set Abstract::BrowseFilterForm
include_set Abstract::BookmarkFiltering

class TopicFilterQuery < Card::FilterQuery
  include WikirateFilterQuery

  def metric_wql metric
    add_to_wql :referred_to_by, left: { name: metric }, right: "topic"
  end

  def project_wql project
    add_to_wql :referred_to_by, left: { name: project }, right: "topic"
  end

  def wikirate_company_wql company
    add_to_wql :found_by, "#{company}+topic"
  end
end

def filter_keys
  %i[name bookmark]
end

def default_filter_hash
  { name: "" }
end

def target_type_id
  WikirateTopicID
end

def filter_class
  TopicFilterQuery
end

def default_sort_option
  "metric"
end

format :html do
  def sort_options
    { "Most Metrics": :metric, "Most #{rate_subjects}": :company }.merge super
  end
end
