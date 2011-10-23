class PagesController < ApplicationController
  def home
    @title = 'HOME'

    @tabs = Tab.find(:all)
  end

  def contact
    @title = 'CONTACT'
  end

  def about
    @title = 'ABOUT'
  end

  def dashboard
    if signed_in? && author_signed_in?
      @title = 'DASHBOARD'
    else
      redirect_to new_session_path
    end
  end

end
