module Contacts
  class IndexPresenter < ApplicationPresenter
    def initialize(view_context)
      super(view_context)
    end

    def page_title
      "Show contacts | Corona Safe Network"
    end
  end
end