module Kaminari
  module PaginatableRelationToPaginatableArray
    def to_paginatable_array
      relation = self
      PaginatableArray.new(self, total_count: relation.total_count).tap do |array|
        array.singleton_class.class_eval do
          define_method :current_page do
            relation.current_page
          end
          define_method :total_pages do
            relation.total_pages
          end
          define_method :limit_value do
            relation.limit_value
          end
          define_method :offset_value do
            relation.offset_value
          end
          define_method :last_page? do
            relation.last_page?
          end
        end
      end
    end
  end
end