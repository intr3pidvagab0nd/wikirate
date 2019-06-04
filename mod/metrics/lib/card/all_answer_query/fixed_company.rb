class Card
  class AllAnswerQuery
    # Query researched and not-researched answers for a given company
    class FixedCompany < AllAnswerQuery
      def base_key
        :company_id
      end

      def subject_key
        :metric_id
      end

      def subject_type_id
        MetricID
      end

      def filter_wql
        return {} unless @filter
        MetricFilterQuery.new(@filter).to_wql
      end

      def sort_importance_wql
        { right: "*vote count" }
      end

      def sort_metric_name_wql
        :name
      end

      def new_name subject
        subject = Card.fetch_name(subject) if subject.is_a? Integer
        "#{subject}+#{@base_card.name}+#{new_name_year}"
      end
    end
  end
end