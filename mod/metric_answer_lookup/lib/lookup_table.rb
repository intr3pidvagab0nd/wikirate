module LookupTable
  def card
    @card ||= Card.fetch send(card_column)
  end

  module ClassMethods
    def create card
      ma = MetricAnswer.new
      ma.metric_answer_id = card.id
      ma.refresh
    end

    def create_or_update card
      ma =
        MetricAnswer.find_by_metric_answer_id(card.id) ||
        MetricAnswer.new
      ma.metric_answer_id = card.id
      ma.refresh
    rescue
      binding.pry
      puts "asdfas"
    end
  end

  def refresh
    keys = attributes.keys
    keys.delete("id")
    keys.each do |method_name|
      new_value = send "fetch_#{method_name}"
      send "#{method_name}=", new_value
    end
    save
  end
end
