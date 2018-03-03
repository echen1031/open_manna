ActiveAdmin.register Subscription do
  permit_params :id, :active, :name, :phone_number, :send_monday, :send_tuesday, :send_wednesday, :send_thursday, :send_friday, :send_saturday, :send_sunday, :send_hour, :time_zone

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
