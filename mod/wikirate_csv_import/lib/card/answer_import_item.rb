class Card
  # Specifies the structure of a import item for an answer import.
  class AnswerImportItem < ImportItem
    @columns = { metric: { map: true },
                 wikirate_company: { map: true, auto_add: true },
                 year: { map: true },
                 value: {},
                 source: { map: true, separator: ";", auto_add: true },
                 comment: { optional: true } }

    CSV_KEYS = %i[answer_id answer_link metric wikirate_company year value
                  source source_count comment].freeze

    def import_hash
      return {} unless (metric_card = Card[metric])

      metric_card.create_answer_args translate_row_hash_to_create_answer_hash
    end

    def normalize_value val
      if val.is_a?(String) && Card[metric]&.try(:categorical?)
        # really only needed for multicategory...
        val.split(";").compact.map(&:strip)
      else
        val
      end
    end

    def map_source val
      result = Card::Set::Self::Source.search val
      # result.first.id if result.size == 1
      #
      # FIXME: below is temporary solution to speed along FTI duplicates.
      # above is preferable once we have matching.
      result.first&.id
    end

    def translate_row_hash_to_create_answer_hash
      r = input.clone
      translate_company_args r
      r[:year] = r[:year].cardname if r[:year].is_a?(Integer)
      r[:ok_to_exist] = true
      r = prep_subfields r
      r
    end

    def translate_company_args r
      r[:company] = r[:wikirate_company]
    end

    def export_csv_line status
      if status.to_sym == :success && (card = Card[cardid])
        csv_line_for_card card
      else
        CSV.generate_line(CSV_KEYS.map { |field| try field })
      end
    end

    def csv_line_for_card card
      card.answer.csv_line
    end

    class << self
      def auto_add_source val
        separate_vals(:source, val).map do |string|
          source_from_url(string) || string
        end.join separator(:source)
      end

      def source_from_url url
        src.find_or_add_source_card(url)&.name if src.url? url
      end

      def src
        Card::Set::Self::Source
      end

      def export_csv_header
        Answer.csv_title
      end

      def wikirate_company_suggestion_filter_mark
        "Company+browse_company_filter"
      end

      def metric_suggestion_filter_mark
        "Metric+browse_metric_filter"
      end

      def source_suggestion_filter_mark
        "Source+browse_source_filter"
      end

      def source_suggestion_filter_key
        :wikirate_link
      end
    end
  end
end
