class FlagsController < ApplicationController
  before_action :set_flag, only: [:show, :edit, :update, :destroy]

  # POST /flags
  # POST /flags.json
  def create
    @flag = Flag.new(flag_params)

    if current_user.flags.where(post_id: @flag.post_id).present?
      redirect_to "http://www.youtube.com/watch?v=eBpYgpF1bqQ"
    end

    respond_to do |format|
      if @flag.save
        format.html { redirect_to :back }
        format.json { render action: 'show', status: :created, location: @flag }
      else
        format.html { render action: 'new' }
        format.json { render json: @flag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flags/1
  # DELETE /flags/1.json
  def destroy
    @flag.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flag
      @flag = Flag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flag_params
      params.require(:flag).permit(:user_id, :post_id, :comment_id)
    end
end
