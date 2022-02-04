class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[show destroy edit update]

  # GET /tweets
  def index
    @tweets = Tweet.all
    @tweet = Tweet.new
  end

  # GET /tweets/1
  def show
    @new_comment = Comment.new
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit; end

  # POST /tweets
  def create
    @tweet = Tweet.new
    @tweet.body = params["body"]
    @tweet.user = current_user
    if @tweet.save
      redirect_to tweets_path, notice: "Tweet created"
    else
      render tweets_path, notice: "Tweet could not be created", status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tweets/1
  def update
    if @tweet.update(tweet_params)
      redirect_to root_path, notice: "Tweet successfully updated"
    else
      render :edit, notice: "Tweet could not be updated", status: :unprocessable_entity
    end
  end

  # DELETE /tweets/1
  def destroy
    @tweet.destroy
    redirect_to tweets_url, notice: "Tweet was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
