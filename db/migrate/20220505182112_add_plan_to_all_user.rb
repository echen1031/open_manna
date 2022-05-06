class AddPlanToAllUser < ActiveRecord::Migration[5.2]
  def change
    User.all.each do |u|
      Plan.find_or_create_by(user_id: u.id)
    end
  end
end
