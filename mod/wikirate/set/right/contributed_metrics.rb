format :html do
  include ContributedAnalysis::HtmlFormat

  def default_header_args args
    super(args)
    args[:count] = Card.search :type_id=>MetricID, :or=>
                        {:created_by=>card.left.name,
                         :edited_by=>card.left.name,
                         :linked_to_by=>{:left=>card.left.name, :right=>["in", "*upvotes", "*downvotes"]}
                        },
                        :return=>:count
    args[:icon] = '<i class="fa fa-bar-chart-o"></i>'

  end

end