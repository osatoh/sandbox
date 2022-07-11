currencies = { japan: 'yen', us: 'dollar' }
puts currencies.delete(:japan)

puts '-----'

p :English.object_id
p :English.object_id

puts '-----'

p 'English'.object_id
p 'English'.object_id

puts '-----'

p 'apple'.methods
p :apple.methods