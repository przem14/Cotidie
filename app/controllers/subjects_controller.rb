class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :assign_subjects
  before_filter :valid_is_approved

  respond_to :html

  def index
    respond_with(@subjects)
  end

  def show
    if @subjects.include?(@subject)
      respond_with(@subject)
    else
      redirect_to subjects_path, alert: @language.missing_rights
    end
  end

  def new
    if current_user.role != 'admin' and current_user.role != 'teacher'
      redirect_to subjects_path, alert: @language.missing_rights
    else
      @subject = Subject.new
      if params.include?(:school_class_id)
        @classes  = SchoolClass.where(:id => params[:school_class_id])
      else
        @classes = SchoolClass.all
      end
      if current_user.role == 'admin'
        @teachers = User.where("role = ? AND is_approved = ?", 0, true)
      elsif current_user.role == 'teacher'
        @teachers = [current_user]
      end

      respond_with(@subject)
    end
  end

  def edit
    if current_user.role == 'student' or current_user.role == 'parent' or !@subjects.include?(@subject)
      redirect_to subjects_path, alert: @language.missing_rights
    else
    @classes = SchoolClass.all
      if current_user.role == 'admin'
        @teachers = User.where("role = ? AND is_approved = ?", 0, true)
      elsif current_user.role == 'teacher'
        @teachers = [current_user]
      end
    end
  end

  def create
    if current_user.role != 'admin' and current_user.role != 'teacher'
      redirect_to subjects_path, alert: @language.missing_rights
    else
      @subject = Subject.new(subject_params)
      @classes = SchoolClass.all
      if current_user.role == 'admin'
        @teachers = User.where("role = ? AND is_approved = ?", 0, true)
      elsif current_user.role == 'teacher'
        @teachers = [current_user]
      end

      @subject.save
      respond_with(@subject)
    end
  end

  def update
    if current_user.role == 'student' or current_user.role == 'parent' or !@subjects.include?(@subject)
      redirect_to subjects_path, alert: @language.missing_rights
    else
      @classes = SchoolClass.all
      if current_user.role == 'admin'
        @teachers = User.where("role = ? AND is_approved = ?", 0, true)
      elsif current_user.role == 'teacher'
        @teachers = [current_user]
      end

      @subject.update(subject_params)
      respond_with(@subject)
    end
  end

  def destroy
    if current_user.role == 'student' or current_user.role == 'parent' or !@subjects.include?(@subject)
      redirect_to subjects_path, alert: @language.missing_admin_rights
    else
      @classes = SchoolClass.all
      if current_user.role == 'admin'
        @teachers = User.where("role = ? AND is_approved = ?", 0, true)
      elsif current_user.role == 'teacher'
        @teachers = [current_user]
      end

      @subject.destroy
      respond_with(@subject)
    end
  end

  private
    def set_subject
      @subject = Subject.find(params[:id])
    end

    def subject_params
      params.require(:subject).permit(:name, :teacher_id, :school_class_id)
    end

    def valid_is_approved
      if current_user.is_approved != true
        redirect_to root_path, alert: @language.not_approved
      end
    end

    def assign_subjects
      if current_user.role == 'admin'
        @subjects = Subject.all
      elsif current_user.role == 'teacher'
        @subjects = current_user.subjects
      elsif current_user.role == 'tutor'
        @subjects = current_user.student.student_class.subjects
      else
        @subjects = current_user.student_class.subjects
      end
    end
end
