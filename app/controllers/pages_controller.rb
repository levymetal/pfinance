class PagesController < ApplicationController
  skip_authorization_check

  def home
    unless current_user.nil?
      redirect_to home_entries_path
    end

    @home_page = true
  end
end
