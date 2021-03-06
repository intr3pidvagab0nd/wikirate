# default is material

ICON_MAP = {
  wikirate_company: :business,
  wikirate_topic: :widgets,
  company_group: ["th-large", { library: :font_awesome }], # city not available in 4.7
  project: [:flask, { library: :font_awesome }],
  subproject: [:flask, { library: :font_awesome }],
  metric: ["bar-chart", { library: :font_awesome }],
  record: ["bar-chart", { library: :font_awesome }],
  metric_answer: :question_answer,
  researcher: [:user, { library: :font_awesome }],
  user: [:user, { library: :font_awesome }],
  post: :insert_comment,
  bookmark: [:bookmark, { library: :font_awesome }],
  bookmarks: [:bookmark, { library: :font_awesome }],
  details: :info,
  source: :public,
  score: :adjust,
  answer_import: :input,
  metric_import: :input,
  calculation: [:calculator, { library: :font_awesome }],
  year: [:calendar, { library: :font_awesome }],
  research_group: [:users, { library: :font_awesome }],
  contributions: [:plug, { library: :font_awesome }],
  activity: :directions_run,
  program: :extension,
  community_assessed: [:unlock, { library: :font_awesome }],
  designer_assessed: [:lock, { library: :font_awesome }]
}.freeze

format :html do
  def icon_map key
    val = ICON_MAP[key]
    val.is_a?(Array) ? val.map(&:clone) : val
  end

  def mapped_icon_tag key
    return unless key.present? && (icon_args = icon_map(key))
    icon_tag(*Array.wrap(icon_args))
  end
end
