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
        scope = scope_by_date
        filter_by_actions = search[:actions].present? ? filter_by_actions(scope) : scope
        filter_by_cat = search[:category].present? ? filter_by_category(filter_by_actions) : filter_by_actions
        filter_by_test = search[:test_status].present? ? filter_by_test_status(filter_by_cat) : filter_by_cat
        filter_by_current_status = search[:current_status].present? ? filter_by_current_status(filter_by_test) : filter_by_test
        filter_by_status = search[:status].present? ? filter_by_status(filter_by_current_status) : filter_by_current_status

        search[:others].present? ? filter_by_others(filter_by_status) : filter_by_status
      else
        scope_by_date
      end
    end

    def scope_by_date
      Consultation.where(created_at: date_window)
    end

    def date_window
      start_date.beginning_of_day..end_date.end_of_day
    end

    def start_date
      @start_date ||= view.params[:search].try(:[], :start_date) ? view.params[:search][:start_date].to_date : Date.today
    end

    def end_date
      @end_date ||= view.params[:search].try(:[], :end_date) ? view.params[:search][:end_date].to_date : Date.today
    end

    # def filter_by_actions(consultations)
    #   consultations.joins(followups: :action).where(actions: { id: view.params[:search][:actions] })
    # end

    def filter_by_actions(consultations)
      consultations.where(action_id: view.params[:search][:actions])
    end

    def filter_by_current_status(consultations)
      consultations.where(current_status: view.params[:search][:current_status])
    end

    def filter_by_status(consultations)
      consultations.where(action_id: view.params[:search][:status])
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