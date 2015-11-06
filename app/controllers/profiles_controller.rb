class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profile = Profile.find(params[:id])
  end

  # GET /profiles/new
  def new
    if user_signed_in? && !current_user.profile.nil?
      redirect_to root_path
      return
    end
    @action = "create"
    @profile = Profile.new
    @timeslots = Hash.new
    @timeslots.default = nil
    for i in current_user.timeslots
        @timeslots[i.id] = true
    end
  end

  # GET /profiles/1/edit
  def edit
    if !user_signed_in? && current_user.profile.nil?
      redirect_to root_path
      return
    end
    @action = "update"
    @timeslots = Hash.new
    @timeslots.default = nil
    for i in current_user.timeslots
        @timeslots[i.id] = true
    end
  end

  # POST /profiles
  # POST /profiles.json
  def create
    user = current_user
    ## associated reference doesn't work user.profile return nil
    # if @user.nil?
    #   redirect_to("http://google.com")
    #   return
    # else
    #   redirect_to("http://yahoo.com")
    #   return
    # end
    # @profile = user.profile.build(profile_params)
    @profile = Profile.new(profile_params)
    @profile.user_id = user.id

    respond_to do |format|
      if @profile.save
        format.html { redirect_to controller: 'discoveries', action: 'show'}
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      user_timeslots = params[:time]
      if (user_timeslots == nil)
          user_timeslots = Hash.new
      end
      user_timeslots.default = nil

      for timeslot in Timeslot.all
        if (current_user.timeslots.exists?(timeslot.id) and !user_timeslots[timeslot.id.to_s])
          current_user.timeslots.delete(timeslot.id)
        elsif (user_timeslots[timeslot.id.to_s] and !current_user.timeslots.exists?(timeslot.id))
          current_user.timeslots << timeslot
        end
      end

      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /profiles/
  def settings
    if user_signed_in? && !current_user.profile.nil?
        redirect_to root_path
        return
    end
    @profile = current_user.profile
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:name, :nick_name, :age, :height, :weight, :add1,
       :add2, :city, :state, :post_code, :birthday, :photo)
    end
end
