class Api::V1::SessionsController < ApplicationController
  def create
    user_password = params[:password]
    user_email = params[:email]
    user = user_email.present? && User.find_by(email: user_email)

    if user && user.valid_password?(user_password)
      sign_in user, store: false
      # user.generate_authentication_token!
      # user.save
      render json: user, status: 200
    else
      render json: { error: "Invalid email or password" }, status: 401
    end
  end

  def destroy
    user = User.find_by(auth_token: request.headers['Authorization'])
    user.generate_authentication_token!
    user.save
    head 204
  end
end
