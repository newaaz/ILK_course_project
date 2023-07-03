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
          #flash[:warning] = 'You are not authorized to perform this action.'
          flash[:warning] = 'Вы не авторизованы для этого действия'
          #redirect_to(request.referer || root_path)
          #redirect_back fallback_location: root_path
          redirect_to root_path
        end
        format.turbo_stream { render turbo_stream: turbo_stream.update('flash_messages',
                                                                        partial: 'shared/flash_message',
                                                                        locals: {
                                                                          message_type: 'warning',
                                                                          message: 'Вы не авторизованы для этого действия'
                                                                        })}
      end
    end
  end
end
