format :html do
  # ~~~~~~~~~~~~~ DETAILS ON PROJECT PAGE

  # left column content
  def project_details
    wrap_with :div do
      [
        field_nest(:organizer, view: :titled,
                               title: "Organizer",
                               items: { view: :thumbnail_plain }),
        standard_nest(:wikirate_topic),
        field_nest(:description, view: :titled, title: "Description"),
        field_nest(:conversation, view: :titled, title: "Conversation")
      ]
    end
  end

  # ~~~~~~~~~~~ DETAILS IN PROJECT LISTING

  # TODO: create version of bar to use on homepage and get rid of listing_compact
  view :listing_compact do
    bar_layout do
      text_with_image image: card.field(:image),
                      size: :small,
                      text: listing_details_compact,
                      title: render_link,
                      media_left_extras: media_left_progress,
                      media_opts: { class: "bar left-stripe drop-shadow bg-white" }
    end
  end

  bar_cols 8, 4

  view :bar_left do
    text_with_image image: card.field(:image),
                    size: voo.size,
                    title: render_title_link,
                    text: bar_left_details
  end

  view :bar_middle do
    topics_details
  end

  view :bar_right do
    count_stats
  end

  view :bar_bottom do
    output [topics_details,
            field_nest(:description, view: :titled, title: "Description")]
  end

  def bar_layout
    bs_layout do
      row 12, class: "project-summary" do
        col yield
      end
    end
  end

  def bar_left_details
    output [organizational_details, render_stats_details]
  end

  def listing_details_compact
    wrap_with :div, class: "project-details-info" do
      [organizational_details, topics_details]
    end
  end

  def organizational_details
    wrap_with :div, class: "organizational-details" do
      [field_nest(:organizer, view: :credit)]
    end
  end

  def status_detail
    wrap_with :div do
      field_nest :wikirate_status, items: { view: :name }
    end
  end

  view :stats_details, cache: :never do
    wrap_with :div, class: "stat-details default-progress-box" do
      [wrap_with(:div, research_progress_bar, class: "float-left w-75 p-1"),
       wrap_with(:span, "#{card.percent_researched}%", class: "badge badge-secondary")]
    end
  end

  def media_left_progress
    wrap_with :div, class: "media-left-extras" do
      [wrap_with(:span, "#{card.percent_researched}%", class: "text-muted badge"),
       research_progress_bar]
    end
  end

  def count_stats
    count_badges :wikirate_company, :metric
  end

  def topics_details
    wrap_with :div, class: "topic-details" do
      wrap_with :div, class: "horizontal-list" do
        field_nest :wikirate_topic, items: { view: :link, type: "Topic" }
      end
    end
  end
end
