class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    if signed_in?
      @comment = Comment.new
      @comment.post_id = params[:post_id].to_i
      @comment.user_id = current_user.id

      unless params[:parent_id].nil?
        @comment.parent_id = params[:parent_id].to_i
      end

      render :partial => 'form'
    else
      redirect_to(root_path, :alert => "Invalid user, Please sign in and try again")
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    if signed_in? && @comment.user_id.to_i == current_user.id
      respond_to do |format|
        format.html
      end
    else
      redirect_to(root_path, :alert => "Invalid user, Please sign in and try again")
    end
  end

  # POST /comments
  # POST /comments.xml
  def create
    if signed_in? && params[:comment][:user_id].to_i == current_user.id
      @comment = Comment.new(params[:comment])

      respond_to do |format|
        if @comment.save
          format.html { redirect_to(root_path) }
        else
          format.html { render :partial => 'form' }
        end
      end
    else
      redirect_to(root_path, :alert => "Invalid user, Please sign in and try again")
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])
    if signed_in? && @comment.user_id.to_i == current_user.id
      respond_to do |format|
        if @comment.update_attributes(params[:comment])
          format.html { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to(root_path, :alert => "Invalid user, Please sign in and try again")
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    if signed_in? && author_signed_in?
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to(comments_url) }
        format.xml  { head :ok }
      end
    else
      redirect_to(root_path, :alert => "Invalid user, Please sign in and try again")
    end
  end

  def comments_content
    render :partial => 'comments_content', :locals => {:post_id => params[:post_id].to_i}
  end

  def comments_count
    render :partial => 'comments_count', :locals => {:post_id => params[:post_id].to_i}
  end
end
