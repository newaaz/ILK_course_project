module NotFounded
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
    private

    def not_found(exception)
      logger.error exception
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end
end
