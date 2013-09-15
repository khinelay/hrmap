ActiveAdmin.register AdminUser do
  config.sort_order = "email_asc"

  index do
    selectable_column
    column :email, sortable: :email do |admin_user|
      link_to admin_user.email, [:admin, admin_user]
    end
    column :sign_in_count
    column :last_sign_in_at
    column :last_sign_in_ip
    default_actions
  end

  show do |admin_user|
    attributes_table do
      row :email
      row :sign_in_count
      row :current_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_at
      row :last_sign_in_ip
    end
    active_admin_comments
  end

  filter :email

  form do |f|
    f.inputs I18n.t('admin_user.admin_details') do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  controller do
    def destroy
      admin_user = AdminUser.find(params[:id])
      admin_user.destroy
      if admin_user.errors.any?
        flash[:error] = admin_user.errors.messages[:base].join(". ")
      else
        flash[:notice] = I18n.t('flash.admin_users.destroy.notice')
      end
      redirect_to action: :index
    end

    def permitted_params
      params.permit admin_user: [:email, :password, :password_confirmation]
    end
  end
end
