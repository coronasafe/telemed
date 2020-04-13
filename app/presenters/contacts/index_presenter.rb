module Contacts
  class IndexPresenter < ApplicationPresenter
    def initialize(view_context)
      super(view_context)
    end

    def page_title
      "Show contacts | Corona Safe Network"
    end

    def consultations
      @consultations ||= filter.present? ? filter.includes(:contact, :action).distinct.order(:created_at).reverse : []
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
      assigned_to_me == 'Assigned to Me' ? Consultation.where(created_at: date_window, doctor_id: current_user.id) : Consultation.where(created_at: date_window)
    end

    def date_window
      start_date.beginning_of_day..end_date.end_of_day
    end

    def default_start_date
      Time.zone.yesterday.to_date
    end

    def start_date
      @start_date ||= view.params[:search].try(:[], :start_date) ? view.params[:search][:start_date].to_date : default_start_date
    end

    def end_date
      @end_date ||= view.params[:search].try(:[], :end_date) ? view.params[:search][:end_date].to_date : Time.zone.now.to_date
    end

    # def filter_by_actions(consultations)
    #   consultations.joins(followups: :action).where(actions: { id: view.params[:search][:actions] })
    # end
    #
    def assigned_to_me
      assigned = current_user.role == 'doctor' ? 'Assigned to Me' : 'Show All'

      search.present? ? search[:assigned].present? ? search[:assigned] : assigned : assigned
    end

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
        when 'Quarantined'
          consultations.where(quarantined: true)
        when 'New'
          consultations.joins(:contact).where(contacts: { created_at: date_window })
        else
          consultations
      end
    end

    def search
      @search ||= view.params[:search]

    end

    def search_actions
      search.present? ? search[:actions].present? ? search[:actions] : nil : nil
    end

    def search_category
      search.present? ? search[:category].present? ? search[:category] : nil : nil
    end

    def search_test
      search.present? ? search[:test_status].present? ? search[:test_status] : nil : nil
    end

    def search_current_status
      search.present? ? search[:current_status].present? ? search[:current_status] : nil : nil
    end

    def search_others
      search.present? ? search[:others].present? ? search[:others] : nil : nil
    end

    def filter_by_test_status(consultations)
      consultations.where(test_status: view.params[:search][:test_status])
    end
  end
end