# frozen_string_literal: true

module AppStoreConnectApi
  class ApiError < StandardError
    attr_reader :errors

    def initialize(errors)
      @errors = errors
      super('App Store Connect API request failed')
    end

    def code
      errors.first[:code]
    end

    def status
      errors.first[:status].to_i
    end

    def details
      errors.map { |e| [e[:title], e[:detail]] }.flatten.uniq
    end

    def associated_errors
      associated_errors = errors.map { |error| error.dig :meta, :associated_errors }.compact
      return [] if associated_errors.blank?

      associated_errors.map { |error_hash| error_hash.map { |_, errors| errors.pluck :detail } }.flatten
    end
  end
end
