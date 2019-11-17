module StudentsHelper
	def students_list_columns
	    [
      {label: t('student.name')},
      {label: t('student.roll_number')},
      {label: t('student.dob')},
      {label: t('student.gender')},
      {label: t('student.contact')},
      {label: t('student.link_marks')},
    ]
  end

  def get_subject_name(mark)
    if mark.object.try(:sub_name).present?
      mark.object.try(:sub_name)
    else
      mark.object.subject.name
    end
  end

  def get_access(mark)
    teacher = Subject.where(id: mark.object.subject.id, teacher_id: current_user.id).first
    teacher.present? ? false : true
  end

end
