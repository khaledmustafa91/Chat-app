# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ExceptionsHandler

  def paginate(collection:, options: {}, render_options: {})
    render(json: collection, **render_options) if params[:show_all].present?

    collection = collection.paginate(page: params[:page], per_page: params[:per_page])
    render(
      {
        json: collection,
        meta: {
          total_entries: collection.total_entries,
          total_pages: collection.total_pages,
          next_page: collection.next_page,
          previous_page: collection.previous_page,
          current_page: (params[:page] || 1).to_i,
          per_page: (params[:per_page] || 10).to_i
        }.merge(options)
      }.merge(render_options)
    )
  end

  def paginate_elasticsearch(collection:)
    class_name = collection.klass.name.underscore.pluralize
    render(
      {
        json: collection,
        root: class_name,
        meta: {
          current_page: (params[:page] || 1).to_i,
          per_page: (params[:per_page] || 10).to_i
        }
      }
    )
  end
end
