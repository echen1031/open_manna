ActiveAdmin.register User do
  permit_params User.column_names

  index do 
    column :id
    column :email
    column :created_at do |user|
      Time.use_zone("Eastern Time (US & Canada)") do
        user.created_at.strftime("%m/%d/%Y")
      end
    end
  end
end
