# frozen_string_literal: true

class UsersController < ApplicationController
  def new; end

  include BCrypt

  def show
    @user = User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    user.password_digest = BCrypt::Password.create(params[:password])

    if user.save
      redirect_to "/users/#{user.id}"
    else
      flash[:alert] = 'User could not be created'
      redirect_to '/register'
    end
  end

  def discover
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.permit(:name, :email)
  end
end
