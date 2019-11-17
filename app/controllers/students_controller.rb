class StudentsController < ApplicationController

load_and_authorize_resource

  def index
    @students = Student.all.paginate :per_page => PER_PAGE, :page => params[:page]
    refresh_table
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      flash[:notice] = t('common.created',model_name: Student.model_name)
      redirect_to students_path
    else
       render :new
    end
  end

  def update
    if @student.update(student_params)
      flash[:notice] = t('common.updated',model_name: Student.model_name)
      redirect_to students_path
    else
     render :edit 
    end
  end

  def calculate_rank 
    query = %Q{
      select students.name, sum(marks.subject_mark) as sub_marks,
      rank() OVER( order by sum(marks.subject_mark) desc) as rank from students
      left join marks on students.id = marks.student_id group by students.name order by sub_marks desc
      }
    @students = ActiveRecord::Base.connection.exec_query(query)
  end

  def link_marks
    if @student.marks.first.blank? 
      Subject.all.each { |c| @student.marks.build(subject_id: c.id, sub_name: c.name)} 
    else
      all_subject = []
      all_subject  = Subject.all.pluck(:id)
      @student.marks.each do |mark|
        all_subject.include?(mark.subject_id)  ? all_subject.delete(mark.subject_id) : ''
      end
      if all_subject.present?
        all_subject.each do |subject_id|
          new_subject  = Subject.where(id: subject_id).first
          @student.marks.build(subject_id: new_subject.id, sub_name: new_subject.name)
        end    
      end
    end
    render json: { content: render_to_string('students/link_marks', locals: {student: @student}, formats: [:html], layout: false )}
  end 


  def save_marks
   @student = Student.where(id: params[:student][:id]).first 
    if @student.update_attributes(student_marks_attributes) 
      flash[:notice] = "Marks sucessfully added."
      redirect_to students_path
    else
      render :link_marks , locals: {student: @student}
    end
  end
  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :roll_number, :dob, :gender, :contact_number )
    end

    def student_marks_attributes 
      params.require(:student).permit(:id, marks_attributes: [:id, :student_id,:subject_id,:marks,:subject_mark] ) 
    end

end


# def courses_popup 
# @student = Student.first 
#  if @student.marks.first.blank? 
#  courses = Course.all courses.each { |c| @student.marks.build(subject_id: c.id, sub: c.name)} 
#  end
#   # render json: { content: @courses, formats: [:html], layout: false } 
#   render json: { content: render_to_string('students/courses_list', locals: {student: @student, courses: courses}, formats: [:html], layout: false) }
#    end 

   # def save_mark 
   # #params.permit! 
   # @student = Student.where(id: params[:student][:id]).first @student.update_attributes(testa) 
   # redirect_to students_path
   #  end


