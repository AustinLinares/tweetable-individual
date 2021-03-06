class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]

  # GET /comments
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  def show; end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit; end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.tweet_id = params["tweet_id"]

    if @comment.save
      redirect_to tweet_path(params["tweet_id"]), notice: "Comment was successfully created."
    else
      redirect_to tweet_path(params["tweet_id"]), status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      redirect_to tweet_path(@comment.tweet.id), notice: "Comment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    redirect_to tweet_path(@comment.tweet.id), notice: "Comment was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:body)
  end
end
