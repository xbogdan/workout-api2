module Authenticable extend ActiveSupport::Concern
  # Devise methods overwrites
  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  def authenticate_with_token!
    render json: { status: 'error', errors: "Not authenticated" }, status: :unauthorized unless current_user.present?
  end

  def user_signed_in?
    current_user.present?
  end
end
