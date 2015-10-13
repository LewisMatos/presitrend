class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show]

  # GET /tweets
  # GET /tweets.json
  def index
    Thread.new{Tweet.stream}
  end
  
  def gettweet
    tweet = Tweet.last
    candidate = Candidate.find(tweet.candidate_id)
    @can = {id: tweet.id,username: tweet.username, tweet: tweet.tweet,location: tweet.location,candidate: tweet.candidate,party: candidate.party,candslug: candidate.slug}
  end

 def getpopcandidate
  state_pop = {}
  Popcounter.column_names.each_with_index do |state, index|
    if index > 0 && index < 51
      placeholder = Popcounter.pluck(state.to_sym)
      cand_id = placeholder.index(placeholder.max) + 1
      candidate = Candidate.find(cand_id)
      state_pop[:"#{state}"] ||= { :candidate => "#{candidate.name}", :cand_id => "#{cand_id}", :cand_pop => "#{placeholder.max}"}
    end
  end
   render json: state_pop.to_json
 end


  # GET /tweets/1
  # GET /tweets/1.json
 #  def show
 # # @tweets = Tweet.last  
 #  end 

 #  # GET /tweets/new
 #  def new
 #  #  @tweet = Tweet.new
 #  end

 #  # GET /tweets/1/edit
 #  def edit
 #  end

 #  # POST /tweets
 #  # POST /tweets.json
 #  def create
 #    @tweet = Tweet.new(tweet_params)

 #    respond_to do |format|
 #      if @tweet.save
 #        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
 #        format.json { render :show, status: :created, location: @tweet }
 #      else
 #        format.html { render :new }
 #        format.json { render json: @tweet.errors, status: :unprocessable_entity }
 #      end
 #    end
 #  end

 # #PATCH/PUT /tweets/1
 #  #PATCH/PUT /tweets/1.json
 #  def update
 #    respond_to do |format|
 #      if @tweet.update(tweet_params)
 #        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
 #        format.json { render :show, status: :ok, location: @tweet }
 #      else
 #        format.html { render :edit }
 #        format.json { render json: @tweet.errors, status: :unprocessable_entity }
 #      end
 #    end
 #  end

 #  # DELETE /tweets/1
 #  # DELETE /tweets/1.json
 #  def destroy
 #    @tweet.destroy
 #    respond_to do |format|
 #      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
 #      format.json { head :no_content }
 #    end
 #  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:username, :tweet)
    end
end
