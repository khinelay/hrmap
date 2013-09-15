module ActiveAdmin
  module Views

    # = Index as a Sortable List or Tree
    class IndexAsSortable < ActiveAdmin::Component
      def build(page_presenter, collection)
        @page_presenter = page_presenter
        @options = active_admin_config.dsl.sortable_options
        @collection = collection
        @collection.sort_by! do |a|
          a.send(@options[:sorting_attribute]) || 1
        end
        @resource_name = active_admin_config.resource_name.to_s.underscore.parameterize('_')

        # Call the block passed in. This will set the
        # title and body methods
        instance_eval &page_presenter.block if page_presenter.block

        add_class "index"
        build_list
      end
    end
  end
end
