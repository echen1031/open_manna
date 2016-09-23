ActiveAdmin.register User do
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
