ActiveAdmin.register Department do
  menu :priority => 2

  sortable tree: true,
           max_levels: 0,
           protect_root: true

  index as: :sortable do
    label :name do |department|
      ret = []
      if department.id == params[:parent_id].to_i
        if department.parent.present?
          ret << "#{link_to I18n.t('active_admin.back_to') + " " + department.parent.name, admin_departments_path(parent_id: department.parent.id)} | #{department.name}"
        else
          ret << "#{link_to I18n.t('active_admin.back_to') + " " + I18n.t('active_admin.root_level'), admin_departments_path} | #{department.name}"
        end
      else
        ret << link_to_if(department.children.any?, department.name, admin_departments_path(parent_id: department.id))
      end
      ret << department_employees_count(department.total_employees)
      ret << "#{I18n.t('department.leaded_by')} #{link_to department.user_name, [:admin, department.user]}" if department.user
      ret.join(", ").html_safe
    end
    default_actions
  end

  show do |department|
    attributes_table do
      row :name
      row I18n.t('department.parent_department') do |d|
        department_ancestry_links d if d.ancestors
      end
      row I18n.t('department.children_departments') do |d|
        if d.children.any?
          ul do
            d.children.each do |d|
              li do
                link_to(d.name, [:admin, d], class: "department") + ", #{department_employees_count(d.total_employees)}".html_safe
              end
            end
          end
        else
          "<span class=\"empty\">#{I18n.t('active_admin.empty')}</span>".html_safe
        end
      end
      row I18n.t('department.leaded_by') do |d|
        link_to d.user_name, [:admin, department.user], class: "leaded-by" if d.user
      end
      row I18n.t('department.employees') do |d|
        if d.users.any?
          ul do
            d.users.each do |u|
              li do
                link_to u.name, [:admin, u], class: "employee"
              end
            end
          end
        else
          "<span class=\"empty\">#{I18n.t('active_admin.empty')}</span>".html_safe
        end
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs I18n.t('department.department_details') do
      f.input :name
      f.input :parent_id, label: I18n.t('department.parent_department'), as: :select, collection: ancestry_options(Department.without_self(resource.id).arrange(order: :position)) {|i| "#{a = i.ancestors.collect{|a| a.name}; a.join(" / ") + " / " if a.any?} #{i.name}" }
      f.input :user_id, label: I18n.t('department.leaded_by'), as: :select, collection: User.cached_collection_for_select
    end
    f.actions
  end

  config.filters = false

  controller do
    def scoped_collection
      if request[:action] == "index"
        params[:parent_id].present? ? Department.where(id: params[:parent_id]) : Department.roots
      else
        super
      end
    end

    def permitted_params
      params.permit department: [:name, :parent_id, :user_id]
    end
  end
end
