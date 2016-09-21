ActiveAdmin.register SMSClientLogger do
  index do
    column :id
    column :status_code
    column :status_text
    column :to
    column :created_at do |log|
      Time.use_zone("Eastern Time (US & Canada)") do
        log.created_at.strftime("%m/%d/%Y at %l:%M %p (est)")
      end
    end
  end
end
