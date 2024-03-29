require 'pp'
class PostsController < ApplicationController
  skip_authorize_resource :only => [:index, :show] 
  before_filter :authenticate_user!, :except => [:index, :show]


  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.front_page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.includes(:user, :attachments).friendly.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @user = current_user
    @post = Post.new
    @post.user(@user)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.friendly.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @user = current_user
    @attachment_name = params[:post].delete "attachment_name"
    @new_category = params[:post].delete "new_category"
    @post = @user.posts.new(params[:post])
    if !@new_category.blank?
      @post.category = Category.new(name: @new_category)
    end
    if !@attachment_name.blank?
      @attachment_name << '%'
      @post.attachments << Attachment.where("attachments.name like ?", @attachment_name)
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.friendly.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.friendly.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
