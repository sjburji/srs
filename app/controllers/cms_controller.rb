class CmsController < ApplicationController
  def index
    if signed_in? && author_signed_in?
      @cms = Cm.find(:all)

      respond_to do |format|
        format.html
      end
    else
      redirect_to root_path
    end
  end

  def edit
    if signed_in? && author_signed_in?
      @cm = Cm.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def update
    if signed_in? && author_signed_in?
      @cm = Cm.find(params[:id])

      respond_to do |format|
        if @cm.update_attributes(params[:cm])
          format.html { redirect_to(@cm, :notice => 'CMS was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @cm.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to root_path
    end
  end

  def show
    if signed_in? && author_signed_in?
      @cm = Cm.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @cm }
      end
    else
      redirect_to root_path
    end
  end

  def foreword
    @foreword = Cm.find_by_section_and_active('FOREWORD', 'Y')

    render :partial => 'foreword'
  end

  def footer
    @footer = Cm.find_by_section_and_active('FOOTER', 'Y')

    render :partial => 'footer'
  end

  def about
    @about = Cm.find_by_section_and_active('ABOUT', 'Y')

    render :partial => 'about'
  end

  def privacy
    @privacy = Cm.find_by_section_and_active('PRIVACY POLICY', 'Y')

    render :partial => 'privacy'
  end

  def contact
    @contact = Cm.find_by_section_and_active('CONTACT', 'Y')

    render :partial => 'contact'
  end
end