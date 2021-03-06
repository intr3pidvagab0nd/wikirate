class Answer
  # Methods to format answer for csv output
  module Csv
    include Card::Env::Location

    def self.included host_class
      host_class.extend ClassMethods
    end

    def csv_line
      CSV.generate_line [answer_id,
                         answer_link,
                         metric_name,
                         company_name,
                         year,
                         value,
                         source_url,
                         source_count,
                         comments]
    end

    def answer_link
      card_url answer_id.present? ? "~#{answer_id}" : answer_name.url_key
    end

    def answer_name
      "#{record_name}+#{year}".to_name
    end

    # class methods for {Answer}
    module ClassMethods
      def csv_title
        CSV.generate_line ["Answer ID", "Answer Link", "Metric", "Company",
                           "Year", "Value", "Source", "Source Count", "Comments"]
      end
    end
  end
end
