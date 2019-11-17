class SubjectsController < ApplicationController

load_and_authorize_resource

  def index
    @subjects = Subject.all.paginate :per_page => PER_PAGE, :page => params[:page]
    refresh_table
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      flash[:notice] = t('common.created',model_name: Subject.model_name)
      redirect_to subjects_path
    else
      render :new 
    end
  end

  def update
    if @subject.update_attributes(subject_params)
      flash[:notice] = t('common.updated',model_name: Subject.model_name)
      redirect_to subjects_path
    else
      render :edit 
    end
  end

  private
   
   def subject_params
      params.require(:subject).permit(:name, :code, :teacher_id)
    end

end
