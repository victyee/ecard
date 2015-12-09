class TweetsController < ApplicationController
  # before_action :authenticate_user!, only: [:upvote, :downvote]
  before_action :set_tweet, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :is_admin?, only: [:index, :delete]

  respond_to :html

  def index
    @tweets = Tweet.all
    if user_signed_in?
      @tweet = current_user.tweets.find_by(params[:name])
    end
    respond_with(@tweets)
  end

  def show
    
  end

  def new
    redirect_to root_path, notice: 'No such url'
  end

  def edit
    @tweet = current_user.tweets.find_by(params[:id])
  end

  def create
    @card = Card.friendly.find(params[:card_id])
    @tweet = @card.tweets.create(tweet_params)
    @tweet.user_id = current_user.id
    @tweet.save
    respond_with(@card)
  end

  def update
    @card = @tweet.card.id
    if @tweet.update(tweet_params)
      redirect_to card_path(@card)
    end
  end

  def delete
    @card = Card.friendly.find(params[:card_id])
    @tweet = Tweet.find(params[:tweet_id])
  end

  def destroy
    card_number = @tweet.card.id
    @card = Card.friendly.find(card_number)
    @tweets = @card.tweets.all
    tweet_user_id = @tweet.user_id
    @tweet.destroy
    # redirect_to @card
    # if current_user.admin == false
    #   respond_with(@card)
    # end
    if current_user.admin == false and tweet_user_id == current_user.id
      respond_with(@card)
    end
  end

  def upvote
    @card = Card.friendly.find(params[:card_id])
    @tweet.upvote_from current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render json: { count: @tweet.get_upvotes.size } }
    end
  end

  def downvote
    @card = Card.friendly.find(params[:card_id])
    @tweet.downvote_from current_user
    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @tweet.get_downvotes.size } }
    end
  end

  private
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:user_id, :body)
    end

    def correct_user
      card_id = @tweet.card.id
      @card = Card.friendly.find(card_id)

      if user_signed_in?
        if current_user.try(:admin?) or current_user.id == @card.user_id.to_f
          @tweet = Tweet.find(params[:id])
        else
          @tweet = current_user.tweets.find_by(id: params[:id])
          redirect_to card_path(@card), notice: 'Can\'t touch this. Not yours.' if @tweet.nil?
        end
      else
        redirect_to root_path, notice: 'Please log in first'
      end
    end

    def is_admin?
      @card = Card.friendly.find(params[:card_id])
      redirect_to root_path, notice: 'You\'re not authorised to do so' unless current_user.admin or current_user.id == @card.user_id.to_f
    end
end