u = User.create email: 'test@test.sk', password: '123456', password_confirmation: '123456'

20.times do |i|
  u.runs.create date: (Date.today - i.days), distance: rand(5.5...20.3), duration: rand(2000...5000)
end
