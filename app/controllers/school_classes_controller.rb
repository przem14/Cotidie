class SchoolClassesController < ApplicationController
  before_action :set_school_class, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :assign_school_classes
  before_filter :valid_is_approved

  respond_to :html

  def index
    respond_with(@school_classes)
  end

  def show
    if @school_classes.include?(@school_class)
      respond_with(@school_class)
    else
      redirect_to school_classes_path, notice: @language.missing_rights
    end
  end

  def new
    if current_user.role != 'admin'
      redirect_to school_classes_path, notice: @language.missing_admin_rights
    else
      @school_class = SchoolClass.new
      @teachers = User.where("role = ? AND is_approved = ?", 0, true)
      @students = User.where("role = ? AND is_approved = ?", 1, true)

      respond_with(@school_class)
    end
  end

  def edit
    if current_user.role == 'student' or current_user.role == 'parent' or !@school_classes.include?(@school_class)
      redirect_to school_classes_path, notice: @language.missing_rights
    else
      @students = User.where("role = ? AND is_approved = ?", 1, true)
      if current_user.role == 'admin'
        @teachers = User.where("role = ? AND is_approved = ?", 0, true)
      elsif current_user.role == 'teacher'
        @teachers = [current_user]
      end
    end
  end

  def create
    if current_user.role != 'admin'
      redirect_to school_classes_path, notice: @language.missing_admin_rights
    else
      @teachers = User.where("role = ? AND is_approved = ?", 0, true)
      @students = User.where("role = ? AND is_approved = ?", 1, true)
      @school_class = SchoolClass.new(school_class_params)

      @school_class.save
      for student_id in params[:school_class][:students][1..-1]
        User.update(student_id, :student_class_id => @school_class.id)
      end
      respond_with(@school_class)
    end
  end

  def update
    if current_user.role == 'student' or current_user.role == 'parent' or !@school_classes.include?(@school_class)
      redirect_to school_classes_path, notice: @language.missing_rights
    else
      @students = User.where("role = ? AND is_approved = ?", 1, true)
      if current_user.role == 'admin'
        @teachers = User.where("role = ? AND is_approved = ?", 0, true)
      elsif current_user.role == 'teacher'
        @teachers = [current_user]
      end

      @school_class.update(school_class_params)
      for student_id in params[:school_class][:students][1..-1]
        User.update(student_id, :student_class_id => params[:id])
      end
      respond_with(@school_class)
    end
  end

  def destroy
    if current_user.role != 'admin'
      redirect_to school_classes_path, notice: @language.missing_admin_rights
    else
      @school_class.destroy
      respond_with(@school_class)
    end
  end

  def delete_from_class
    if current_user.role == 'student' or current_user.role == 'parent' or !@school_classes.include?(@school_class)
      redirect_to school_classes_path, notice: @language.missing_rights
    else
      User.update(params[:student_id], :student_class_id => nil)
      redirect_to school_class_path(params[:class]), notice: @language.deleted_from_class
    end
  end

  private
    def set_school_class
      @school_class = SchoolClass.find(params[:id])
    end

    def school_class_params
      params.require(:school_class).permit(:name, :teacher_id)
    end

    def valid_is_approved
      if current_user.is_approved != true
        redirect_to root_path, notice: @language.not_approved
      end
    end

    def assign_school_classes
      if current_user.role == 'admin'
        @school_classes = SchoolClass.all
      elsif current_user.role == 'teacher'
        @school_classes  = current_user.subjects.map{ |subject| subject.school_class }.uniq
      elsif current_user.role == 'student'
        @school_classes  = [current_user.student_class]
      else
        @school_classes  = [current_user.student.student_class]
      end
    end
end
