class SessionsController < Devise::SessionsController
  # Make development curl testing easier:
  skip_before_action :verify_authenticity_token, if: -> { Rails.env.development? && request.format.json? }
  respond_to :html, :json
end
