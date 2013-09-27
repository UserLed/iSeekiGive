namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    #make_users
    #make_table_empty("messages")
    make_messages
  end
end

def make_users
  20.times do |n|
    first_name = "First_#{n+1}"
    last_name = "Last_#{n+1}"
    country = "United States"
    email = "seek-#{n+1}@iconsbd.com"
    password = "123456"
    type = "Seeker"
    User.create!(first_name: first_name,
                 last_name: last_name,
                 country: country,
                 email: email,
                 type: type,
                 password: password,
                 password_confirmation: password)
  end

  20.times do |n|
    first_name = "First_#{n+20+1}"
    last_name = "Last_#{n+20+1}"
    country = "United States"
    email = "give-#{n+20+1}@iconsbd.com"
    password = "123456"
    type = "Giver"
    User.create!(first_name: first_name,
                 last_name: last_name,
                 country: country,
                 email: email,
                 type: type,
                 password: password,
                 password_confirmation: password)
  end

end

def make_messages
  require 'securerandom'
  giver = User.find 10
  seekers = User.where(:type => "Seeker").limit(20)
    seekers.each do |seeker|
      uid = SecureRandom.uuid
      subject = "Second Sub of Seekers-#{seeker.id}"
      content = Faker::Lorem.sentence(5)
      Message.create!(from: seeker.name,
                      to: giver.name,
                      sender_id: seeker.id,
                      recipient_id: giver.id,
                      subject: subject,
                      content: content, uid: uid)
    end

end

def make_table_empty(table_name)
  ActiveRecord::Base.connection.execute("TRUNCATE #{table_name}")
end

