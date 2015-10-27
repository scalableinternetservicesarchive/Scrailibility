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
    @action = "create"
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
    @action = "update"
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:name, :nick_name, :age, :height, :weight, :add1, 
       :add2, :city, :state, :post_code, :birthday, :image_url, :id)
    end
end
