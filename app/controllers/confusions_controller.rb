class ConfusionsController < ApplicationController

  # POST /confusions
  # POST /confusions.json
  def create
    bound = 5
    latest_lecture = Lecture.last
    latest_confusion = Confusion.where(user_id: current_user.id).last
    if latest_lecture.current
      if latest_confusion.nil? || (Time.now - latest_confusion.created_at) >= (bound * 60)
        @confusion = Confusion.new
        @confusion.user = current_user
        @confusion.lecture = Lecture.last

        @confusion.save
        PrivatePub.publish_to("/confusions/new", "alert('fly fools!')")
        # respond_to do |format|
        #   if @confusion.save
        #     format.html { redirect_to :back}
        #     format.json { render action: 'show', status: :created, location: @confusion }
        #   else
        #     format.html { render action: 'new' }
        #     format.json { render json: @confusion.errors, status: :unprocessable_entity }
        #   end
        # end
      else
        redirect_to :back
      end
    else
      redirect_to :back
    end
  end

end
