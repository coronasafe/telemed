module Contacts
  class SearchPresenter < ApplicationPresenter
    def initialize(view_context)
      super(view_context)
    end

    def page_title
      "Search | Corona Safe Network"
    end

    def search
      @search ||= view.params[:search]
    end

    def text_search
      @text_search ||= view.params[:text_search]
    end

    def text_search_text
      text_search.try(:[], :name) ? text_search[:name] : ''
    end

    def text_search_entries(name)
      Contact.where("name LIKE ?", "%#{name.downcase}%")
    end

    def text_search_results
      @text_search_results ||= text_search.try(:[], :name) ? text_search_entries(text_search[:name]) : Contact.none
    end
  end
end