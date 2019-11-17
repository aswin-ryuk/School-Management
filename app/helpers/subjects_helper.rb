module SubjectsHelper
   def subjects_list_columns
    [
      {label: t('subject.name')},
      {label: t('subject.code')},
      {label: t('subject.teacher')},
    ]
  end
end
