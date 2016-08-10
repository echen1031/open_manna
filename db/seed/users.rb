User.delete_all
User.create!(
  { id: 1, email: "user@example.com", password: "helloworld" }
)

ActiveRecord::Base.connection.reset_pk_sequence!("users")
