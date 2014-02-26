namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "bazhan",
                 email: "bazhan12@mail.ru",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    999.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end