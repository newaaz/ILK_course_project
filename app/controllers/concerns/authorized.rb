# frozen_string_literal: true

module Authorized
  extend ActiveSupport::Concern

  included do
    include Pundit::Authorization

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private

    def user_not_authorized
      respond_to do |format|
        format.html do
          flash[:warning] = 'You are not authorized to perform this action.'
          # redirect_to(request.referer || root_path)
          redirect_back fallback_location: root_path
        end
        format.turbo_stream { render turbo_stream: turbo_stream.append('flash_messages', partial: 'shared/not_authorized') }
      end
    end
  end
end
