class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def dashboard
    @listings_as_owner = @user.listings
    @bookings = @user.bookings
  end

  private

  def set_user
    @user = current_user
  end

end
