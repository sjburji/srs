class CmsController < ApplicationController
  def index
    @cms = Cm.find(:all)

    respond_to do |format|
      format.html
    end
  end

  def edit
    @cm = Cm.find(params[:id])
  end

  def update
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
  end

  def show
    @cm = Cm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cm }
    end
  end

  def foreword
    @foreword = Cm.find_by_section_and_active('FOREWORD', 'Y')

    render :partial => 'foreword'
  end
  
end