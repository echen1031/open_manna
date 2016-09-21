ActiveAdmin.register Subscription do
  index do
    column :id
    column "Belongs To", :user
    column :name
    column :phone_number
    column :active
    column :send_monday
    column :send_tuesday
    column :send_wednesday
    column :send_thursday
    column :send_friday
    column :send_saturday
    column :send_sunday
    column :send_hour
    column :time_zone
  end
end
