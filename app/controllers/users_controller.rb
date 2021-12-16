# frozen_string_literal: true
require 'faraday'

class UsersController < ApplicationController
  def new; end

  def show
    @user = User.find(params[:id])
  end

  def create
      user = User.new(user_params)
    if user.save
      redirect_to "/users/#{user.id}"
    else
      flash[:alert] = "#{user.errors.full_messages.flatten.to_s.delete! '[]"'}"
      redirect_to '/register'
    end
  end

  def discover
    @user = User.find(params[:id])
  end

  def login_form
  end

  def login_user
    if params[:email].present? && User.where(email: params[:email]).any?
      user = User.where(email: params[:email]).first
      require "pry"; binding.pry
      if params [:password_digest]
      end
      redirect_to "/users/#{user.id}"
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
