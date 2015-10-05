class Api::V1::SessionsController < ApplicationController
  def create
    user_password = params[:password]
    user_email = params[:email]
    user = user_email.present? && User.find_by(email: user_email.downcase)

    if user && user.valid_password?(user_password)
      sign_in user, store: false
      user.generate_authentication_token!
      user.save
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

  def register
    begin
      raise 'Invalid email' if params[:email].length == 0
      raise 'Invalid password' if params[:password].length == 0 || params[:confirmation_password].length == 0
      raise 'Password too short' if params[:password].length < 6
      raise 'Passwords don\'t match' if params[:password] != params[:confirmation_password]
      
      user = User.create!(email: params[:email], password: params[:password])
      sign_in user, store: false
      user.generate_authentication_token!
      user.save

      status = 201
      res = user
    rescue Exception => e
      res = { status: 'error', error: e.message }
      status = 400
    end

    render json: res, status: status
  end

end
