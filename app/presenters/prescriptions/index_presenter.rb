module Prescriptions
  class IndexPresenter < ApplicationPresenter
    def initialize(view_context)
      super(view_context)
    end

    def page_title
      'Prescriptions | Corona Safe Network'
    end

    def prescriptions
      @prescriptions ||= filter.present? ? filter.includes(:contact).distinct.order('consultations.created_at DESC') : Prescription.none
    end

    def filter
      search = view.params[:search]
      if search.present?
        scope = scope_by_date
        filter_by_delivery_status = search[:delivery_status].present? ? filter_by_delivery(scope) : scope
        filter_by_source = search[:source].present? ? filter_by_source(filter_by_delivery_status) : filter_by_delivery_status
        search[:scheme].present? ? filter_by_scheme(filter_by_source) : filter_by_source
      else
        scope_by_date
      end
    end

    def date_window
      start_date.beginning_of_day..end_date.end_of_day
    end

    def scope_by_date
      Prescription.where(created_at: date_window, district_id: current_user.panchayat.district.id)
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

    def filter_by_delivery(prescription)
      prescription.where(delivery_status: view.params[:search][:delivery_status])
    end

    def filter_by_source(prescription)
      prescription.where(source: view.params[:search][:source])
    end

    def filter_by_scheme(prescription)
      prescription.where(scheme: view.params[:search][:scheme])
    end
  end
end