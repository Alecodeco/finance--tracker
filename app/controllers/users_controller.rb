class UsersController < ApplicationController

  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friend_list = current_user.friends
  end

  def search
    if params[:first_name].present? && params[:last_name].present?
      @user = User.find_by(first_name: params[:first_name], last_name: params[:last_name])
      if @user && @user != current_user
        respond_to do |format|
          format.js { render partial: 'users/friend_result'}
        end
      elsif @user && @user == current_user
        respond_to do |format|
          @user = nil
          flash.now[:alert] = "That's yourself !"
          format.js { render partial: 'users/friend_result'}
        end
      elsif !@user
        respond_to do |format|
          flash.now[:alert] = "User not found or inexistent"
          format.js { render partial: 'users/friend_result'}
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter both Name and Last name to search, or search by Email."
        format.js { render partial: 'users/friend_result'}
      end
    end
  end


end
