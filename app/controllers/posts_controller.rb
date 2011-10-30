class PostsController < ApplicationController
  # GET /posts
  # GET /posts.xml
  def index
    if signed_in? && author_signed_in?
      @posts = Post.find(:all, :order => 'CREATED_AT DESC')

      respond_to do |format|
        format.html
      end
    else
      redirect_to root_path
    end   
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show    
    @post = Post.find(params[:id])
    
    respond_to do |format|
      format.html
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    if signed_in? && author_signed_in?
      @post = Post.new
      @post.user_id = current_user.id

      respond_to do |format|
        format.html
      end
    else
      redirect_to root_path
    end
  end

  # GET /posts/1/edit
  def edit
    if signed_in? && author_signed_in?
      @post = Post.find(params[:id])
      @post.content = File.read(@post.content).html_safe
    else
      redirect_to root_path
    end
  end

  # POST /posts
  # POST /posts.xml
  def create
    if signed_in? && author_signed_in?
      @post = Post.new(params[:post])

      respond_to do |format|
        if @post.save
          format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        else
          format.html { render :action => "new" }
        end
      end
    else
      redirect_to root_path
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    if signed_in? && author_signed_in?
      @post = Post.find(params[:id])

      respond_to do |format|
        if @post.update_attributes(params[:post])
          format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        else
          format.html { render :action => "edit" }
        end
      end
    else
      redirect_to root_path
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    if signed_in? && author_signed_in?
      @post = Post.find(params[:id])
      @post.destroy

      respond_to do |format|
        format.html { redirect_to(posts_url) }
      end
    else
      redirect_to root_path
    end
  end

  def recent_posts
    # top ten recent posts
    @recent_posts = Post.order('CREATED_AT DESC').first(10)

    render :partial => 'recent_posts'
  end

  def archive_posts
    # top ten archive posts
    @archive_posts = Post.order('CREATED_AT DESC')

    render :partial => 'archive_posts'
  end

  def show_home_page_posts
    @posts = Post.find(:all, :order => 'CREATED_AT DESC')
    
    unless params[:tab_id].nil?
      if Tab.find_by_name('ALL').id != params[:tab_id].to_i
        @posts = Post.find_all_by_tab_id(params[:tab_id].to_i,
          :order => 'CREATED_AT DESC')
      end
    end

    @comment = Comment.new
    
    render :partial => 'show_home_page_posts'
  end

  def view
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def view_archive
    archive_id = params[:archive_id].to_s
    start_date = '01 ' + archive_id
    expiry_date = '31 ' + archive_id

    @posts = Post.find(:all, :conditions => ['CREATED_AT >= ? AND CREATED_AT <= ?',
        start_date.to_date, expiry_date.to_date])
    
    respond_to do |format|
      format.html
    end
  end
end
