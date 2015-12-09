class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:new, :create, :edit, :update, :destroy, :mycards]
  # before_action :is_admin?, only: [:new, :create]

  # GET /cards
  # GET /cards.json
  def admincards
    if user_signed_in? && current_user.admin == true
      @cards = Card.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 24)
    else
      redirect_to root_path
    end
  end

  def alluserscards
    if user_signed_in? && current_user.admin == true
      @cards = Card.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 24)
    else
      redirect_to root_path
    end
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    @card = Card.friendly.find(params[:id])
    @tweets = @card.tweets.all.order(created_at: :desc).paginate(:page => params[:page], :per_page => 24)
    @card_tweet_count = @card.tweets.count

    # setting user
    card_user_id = @card.user_id
    @user = User.find(card_user_id)

    if user_signed_in?
      @user_id = current_user.id
      @user_tweets = @tweets.where(:user_id => @user_id)
      @user_tweet_count = @user_tweets.count
    end
  end
  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
    @card = Card.friendly.find(params[:id])
    redirect_to root_path, notice: 'Not authorised to update this card' if @card.user_id.to_f != current_user.id unless current_user.admin
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(card_params)
    @card.user_id = current_user.id
    if current_user.admin
      @card.admin_card = true
    end
    respond_to do |format|
      if @card.save
        format.html { redirect_to @card, notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def mycards
    user_id = current_user.id
    @cards = Card.where(:user_id => user_id).order(created_at: :desc).paginate(:page => params[:page], :per_page => 24)
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    @card = Card.friendly.find(params[:id])

    if @card.update(card_params)
      redirect_to @card
    else
      render 'edit'
    end
  end


  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit(:name, :description, :image, :hashtag, :date)
    end

    def correct_user
      if user_signed_in?
        user_id = current_user.id
        @cards = Card.where(:user_id => user_id).order(created_at: :desc)
        redirect_to root_path, notice: 'Not authorised to update this pin' if @cards.nil? unless current_user.admin
      else
        redirect_to root_path
      end
    end

    # def is_admin?
    #   redirect_to root_path, notice: 'You\'re not authorised to do so' unless current_user.admin
    # end
  end
