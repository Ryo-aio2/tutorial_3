class PasswordResetsController < ApplicationController
  before_action :get_user,   except: %i[new create]
  before_action :valid_user, except: %i[new create]

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = 'Email sent with password reset instructions'
      redirect_to root_url
    else
      flash.now[:danger] = 'Email address not found'
      render 'new'
    end
  end

  def edit; end

  private

  #getやset
  # rubocop:disable Naming/AccessorMethodName
  def get_user
    @user = User.find_by(email: params[:email])
  end
  # rubocop:enable Naming/AccessorMethodName

  # 正しいユーザーかどうか確認する
  def valid_user
    unless @user&.activated? &&
           @user&.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end
end
