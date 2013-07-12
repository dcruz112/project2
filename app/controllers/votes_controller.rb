class VotesController < ApplicationController
  before_action :set_vote, only: [:destroy]

  # POST /votes
  # POST /votes.json
  def create
    @vote = Vote.new(vote_params)
    @vote.post = Post.find(@vote.post_id)
    @vote.post.net_val += 1
    @vote.post.save
    respond_to do |format|
      if @vote.save
        format.html { redirect_to :back }
        # format.js
        format.json { render action: 'show', status: :created, location: @vote }
      else
        format.html { render action: 'new' }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote.post.net_val -= 1
    @vote.post.save
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to votes_url }
      # format.js
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(:user_id, :post_id, :up)
    end
end
