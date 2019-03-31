module Inquisition
  module Core
    module Presenters
      module Elements
        module Html
          module Static
            module Percircle
              class IncompatibilityStructurePercirclePresenter < Core::Presenters::StaticPresenter
                AUDITORS = %i[
                  missing_foreign_keys
                  missing_presence_validation
                  missing_unique_indexes
                ].freeze

                private

                def build_presenter
                  @build_presenter ||= element_presenter.new(total: total, number: number).element
                end

                def number
                  AUDITORS.map(&method(:error_count)).select { |error_count| error_count.is_a?(Integer) }.sum
                end

                def total
                  Data::Database::DatabaseTotalErrorsPresenter.instance.call
                end

                def error_count(auditor)
                  AuditorsData.instance.auditor_errors(auditor, :error_count)
                end

                def element_presenter
                  @element_presenter ||= Elements::Html::Dynamic::PercirclePresenter
                end
              end
            end
          end
        end
      end
    end
  end
end
