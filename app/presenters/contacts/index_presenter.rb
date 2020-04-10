module Contacts
  class IndexPresenter < ApplicationPresenter
    def initialize(view_context)
      super(view_context)
    end

    def page_title
      "Show contacts | Corona Safe Network"
    end

    def consultations
      @consultations ||= filter.present? ? filter.distinct.order(:created_at).reverse : []
    end

    def filter
      search = view.params[:search]
      if search.present?
        filter_by_actions = search[:actions].present? ? filter_by_actions : Consultation.all
        filter_by_cat = search[:category].present? ? filter_by_category(filter_by_actions) : filter_by_actions
        filter_by_test = search[:test_status].present? ? filter_by_test_status(filter_by_cat) : filter_by_cat
        search[:others].present? ? filter_by_others(filter_by_test) : filter_by_test
      else
        Consultation.all
      end
    end

    def filter_by_actions
      Consultation.joins(followups: :action).where(actions: { id: view.params[:search][:actions] })
    end

    def filter_by_category(consultations)
      consultations.where(category: view.params[:search][:category])
    end

    def filter_by_others(consultations)
      case view.params[:search][:others]
        when 'ANC'
          consultations.where(antenatal: true)
        when 'Shifted To Hospital'
          consultations.where.not(shift_to: nil)
        when 'Prescription Given'
          consultations.where(prescription_given: true)
        when 'Endemic_Area'
          consultations.where(endemic: true)
        else
          consultations
      end
    end

    def filter_by_test_status(consultations)
      consultations.where(test_status: view.params[:search][:test_status])
    end
  end
end