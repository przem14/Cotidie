class DegreesController < ApplicationController
  before_action :set_degree, only: [:show, :edit, :update, :destroy]
  before_action :set_degree_service, only: [:create]
  before_action :authenticate_user!
  before_filter :valid_is_approved

  respond_to :html

  def index
    @degrees = Degree.all
    if current_user.role == 'admin'
      @subjects = Subject.all
      @classes  = SchoolClass.all
    elsif current_user.role == 'teacher'
      @subjects = current_user.subjects
      @classes  = current_user.subjects.map{ |subject| subject.school_class }.uniq
    elsif current_user.role == 'student'
      @subjects = current_user.student_class.subjects
      @classes  = [current_user.student_class]
    else
      @subjects = current_user.student.student_class.subjects
      @classes  = [current_user.student.student_class]
    end

    respond_with(@degrees)
  end

  def show
    if current_user.role == 'student' and @degree.student_id != current_user.id
      redirect_to degrees_path, alert: @language.missing_rights
    elsif current_user.role == 'tutor' and @degree.student_id != current_user.student.id
      redirect_to degrees_path, alert: @language.missing_rights
    elsif current_user.role == 'teacher' and @degree.subject.teacher.id != current_user.id
      redirect_to degrees_path, alert: @language.missing_rights
    else
      respond_with(@degree)
    end
  end

  def new
    @subject = Subject.find(params[:subject_id])
    if current_user.role == 'admin' or (current_user.role == 'teacher' and @subject.teacher.id == current_user.id)
      @degrees = Array.new(@subject.school_class.students.count) {DegreeForm.new}
      if @degrees.length > 0
        respond_with(@degree)
      else
        redirect_to edit_school_class_path(@subject.school_class), alert: @language.add_students
      end
    else
      redirect_to degrees_path, alert: @language.missing_rights
    end
  end

  def edit
    @subject = Subject.find(@degree.subject_id)
    if current_user.role == 'admin' or (current_user.role == 'teacher' and @subject.teacher.id == current_user.id)
      @degrees = [@degree]
    else
      redirect_to degrees_path, alert: @language.missing_rights
    end
  end

  def create
    if @degree_service.call(filled_degrees_forms)
      redirect_to degrees_path
    else
      redirect_to new_degree_path(:subject_id => params[:subject_id]),
                  :alert => @language.degrees_errors
    end
  end

  def update
    if current_user.role == 'admin' or (current_user.role == 'teacher' and @degree.subject.teacher.id == current_user.id)
      @degree.update(degree_params)
      respond_with(@degree)
    else
      redirect_to degrees_path, alert: @language.missing_rights
    end
  end

  def destroy
    if current_user.role == 'admin' or (current_user.role == 'teacher' and @degree.subject.teacher.id == current_user.id)
      @degree.destroy
      respond_with(@degree)
    else
      redirect_to degrees_path, alert: @language.missing_rights
    end
  end

  private
    def set_degree
      @degree = Degree.find(params[:id])
    end

    def degree_params
      params.require(:degree).permit(:value, :activity, :description)
    end

    def set_degree_service
      @degree_service = DegreeService.new
    end

    def valid_is_approved
      if current_user.is_approved != true
        redirect_to root_path, alert: @language.not_approved
      end
    end

    def filled_value_from_params
      params[:degrees].select{ |key, degree| degree[:value] != '' }
    end

    def filled_degrees_forms
      degrees = Array.new

      filled_value_from_params.each do |degree|
        degrees.push(DegreeForm.new(value:       degree[1][:value],
                                    description: degree[1][:description],
                                    activity:    params[:activity],
                                    student_id:  degree[1][:student_id],
                                    subject_id:  params[:subject_id]))
      end
      degrees
    end
end
