require "./models"

@user_array = CSV.read("user-file.csv")
@user_array.shift()

@post_array = CSV.read("post-file.csv")
@post_array.shift()

for elements in @user_array
  User.create(username: "#{elements[3]}", password: "#{elements[4]}",dom_state: "#{elements[7]}")
  Profile.create(first_name: "#{elements[1]}", last_name: "#{elements[2]}", birthday: "#{elements[5]}", email: "#{elements[6]}", user_id: "#{elements[0]}")
end

for elements in @post_array
  Post.create(title: "#{elements[1]}", subject: "#{elements[2]}", content: "#{elements[3]}", user_id: "#{elements[4]}", profile_id: "#{elements[5]}")
end