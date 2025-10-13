ActiveAdmin.register Question do
  permit_params :title_jp, :title_en, :answer_jp, :answer_en, :category_id, answer_choices_attributes: [:id, :content_jp, :content_en, :is_correct, :_destroy]

  index do
    selectable_column
    id_column
    column :title_jp
    column :category
    column :created_at
    actions
  end

  filter :category
  filter :title_jp
  filter :created_at

  form do |f|
    f.inputs 'Question Details' do
      f.input :category
      f.input :title_jp
      f.input :title_en
      f.input :answer_jp
      f.input :answer_en
    end

    f.has_many :answer_choices, heading: 'Answer Choices', allow_destroy: true, new_record: 'Add Answer Choice' do |a|
      a.input :content_jp
      a.input :content_en
      a.input :is_correct, as: :boolean
    end

    f.actions
  end

  show do
    attributes_table do
      row :title_jp
      row :title_en
      row :answer_jp
      row :answer_en
      row :category
      row :created_at
      row :updated_at
    end

    panel "Answer Choices" do
      table_for question.answer_choices do
        column :content_jp
        column :content_en
        column :is_correct
      end
    end
    active_admin_comments
  end
end
