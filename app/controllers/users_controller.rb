class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_filter :valid_is_admin, except: [:set_student, :update_student]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
  end

  def set_student
    @users = User.where(:role => 1)
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  def update_student
    User.find(params[:user][:student]).update(:tutor_id => current_user.id)
    current_user.update(:is_approved => false)
    redirect_to root_path, notice: @language.student_set
  end

  # PATCH/PUT /users/1'You cannot delete yourself.'
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: @language.user_updated }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user.id == current_user.id
      respond_to do |format|
        format.html { redirect_to users_url, alert: @language.self_destroy }
        format.json { render :show, status: :ok, location: @user }
      end
    else
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: @language.user_deleted }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :surname, :personal_id, :role, :is_approved)
    end

    def valid_is_admin
      if current_user.role != 'admin'
        redirect_to root_path, alert: @language.missing_admin_rights
      end
    end
end
