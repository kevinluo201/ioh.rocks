require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

Live.blueprint do
  name { Faker::Name.name }
  gmail { Faker::Internet.unique.email }
  school { LiveSchool.offset(rand(50)).first.name }
  department { LiveDepartment.offset(rand(50)).first.name }
  live_times { LiveEvent.active_event.live_times.order('RAND()').take(rand(3) + 1) }
  fb_url { Faker::Name.name }
  phone { Faker::PhoneNumber.cell_phone }
  location { Faker::GameOfThrones.city }
  was_on_ioh { true }
end

LiveEvent.blueprint do
  start_date { Date.today}
  end_date { Date.today + 2.days }
  signup_end { Date.today }
  channels { 5 }
  active { false }
end
