User.delete_all
User.create!(
  { id: 1, email: "eric87chen@gmail.com", password: "helloworld" }
)

ActiveRecord::Base.connection.reset_pk_sequence!("users")
