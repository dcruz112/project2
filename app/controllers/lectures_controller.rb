class LecturesController < ApplicationController
  before_action :set_lecture, only: [:show, :edit, :update, :destroy, :confusion, :end, :join]

  # GET /lectures
  # GET /lectures.json
  def index
    @lectures = Lecture.all
  end

  # GET /lectures/1
  # GET /lectures/1.json
  def show
    @post = Post.new
  end

  # POST /lectures
  # POST /lectures.json
  def create
    if !current_user.student
      @lecture = current_user.lectures.build(current: true)
      @lecture.name = "Lecture #{current_user.lectures.length + 1}"
      @lecture.users = [current_user]

      respond_to do |format|
        if @lecture.save
          format.html { redirect_to lecture_path(@lecture) }
          format.json { render action: 'show', status: :created, location: @lecture }
        else
          format.html { render action: 'new' }
          format.json { render json: @lecture.errors, status: :unprocessable_entity }
        end
      end
    else
      render text: "You can't do that."
    end
  end

  # PATCH/PUT /lectures/1
  # PATCH/PUT /lectures/1.json
  def update

    respond_to do |format|
      if @lecture.update(lecture_params)
        format.html { redirect_to lectures_url }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lectures/1
  # DELETE /lectures/1.json
  def destroy
    @delete_objects = []
    @delete_objects += Post.where(lecture: @lecture)
    @delete_objects += Confusion.where(lecture: @lecture)
    @delete_objects.each do |obj|
      obj.destroy
    end
    @lecture.destroy
    respond_to do |format|
      format.html { redirect_to lectures_url }
      format.json { head :no_content }
    end
  end

  def confusion
    bound = 5
    latest_confusion = Confusion.where(user: current_user, lecture: @lecture).last
    if @lecture.current
      if latest_confusion.nil? || (Time.now - latest_confusion.created_at) >= (bound * 60)
        @confusion = Confusion.new
        @confusion.user = current_user
        @confusion.lecture = @lecture

        respond_to do |format|
          if @confusion.save
            format.html { redirect_to :back}
            format.js
            format.json { render action: 'show', status: :created, location: @confusion }
          else
            format.html { render action: 'new' }
            format.json { render json: @confusion.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to :back
      end
    else
      redirect_to :back
    end
  end

  def end
    respond_to do |format|
      if @lecture.update(current: false, end_time: Time.now)
        format.html { redirect_to lectures_url }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  def join

    @lecture.users << current_user
    respond_to do |format|
      if @lecture.save
        format.html { redirect_to lecture_url(@lecture) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture
      @lecture = Lecture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lecture_params
      params.require(:lecture).permit(:current, :end_time, :name, user_ids: [])
    end
end
