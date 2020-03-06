class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @friend_list = @user.friends
    @tracked_stocks = @user.stocks
  end

  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friend_list = current_user.friends
  end

  def search_by_names(first_name, last_name)
    user = User.where("first_name = ? and last_name = ?","#{first_name}", "#{last_name}")
    return user unless !user
      return nil
  end

  def search_by_email(email)
    user = User.where("email = ?" , "#{email}")
    return user unless !user
      return nil
  end

  def render_search_results(user)
    if has_empty_objects?(user)
      flash.now[:alert] = "User not found or inexistent."
    end
    respond_to do |format|
      format.js { render partial: 'users/friend_result'}
    end
  end

  def search
    if params[:first_name].present? && params[:last_name].present?
      @user = search_by_names(params[:first_name], params[:last_name])
    elsif params[:email].present?
      @user = search_by_email(params[:email])
    end
    render_search_results(@user)
  end

  def not_friends_with?(user, user_id)
    !user.friendships.where(friend_id: user_id).exists?
  end


end
