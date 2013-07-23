class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :unvote]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    if current_user.id != @post.user_id
      redirect_to "http://www.youtube.com/watch?v=6FOUqQt3Kg0"
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.net_val = 0
    @post.save
    # respond_to do |format|
    # #   #if @post.save
    #     format.html { render 'create' }
    #     format.js
      #   format.html { render action: 'new' }
      #   format.json { render json: @post.errors, status: :unprocessable_entity }
      # end
    # end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to root_path }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id || !current_user.student
      @delete_objects = []
      @delete_objects += Vote.where(post_id: @post.id)
      @delete_objects += Flag.where(post_id: @post.id)
      @delete_objects += Comment.where(post_id: @post.id)
      @delete_objects.each do |obj|
        obj.destroy
      end
      @post.destroy
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { head :no_content }
      end
    else
      render text: "Silly hacker!"
    end
  end

  def upvote
    @vote = @post.votes.build(user: current_user)

    if current_user.votes.where(post_id: @post.id).present?
      redirect_to "http://www.youtube.com/watch?v=eBpYgpF1bqQ"
    end

    respond_to do |format|
      if @vote.save
        format.html { redirect_to :back }
        format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  def unvote
    @vote = Vote.where(post_id: params[:id])
    @vote.destroy_all
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :user_id, :name)
    end
end
