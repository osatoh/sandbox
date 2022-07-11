protein_drink = { protein: 24.0, fat: 1.5, carbohydrate: 4.0 }
# 一日の摂取目安
daily_goal          = { protein: 147.0, fat: 22.0, carbohydrate: 295.0 }
meal_count          = 4 # 食事回数
protein_drink_count = 2 # プロテイン回数
# 食材のPFC
protein_drink = { protein: 24.0, fat: 1.5, carbohydrate: 4.0 }
chest         = { protein: 30.8, fat: 2.0, carbohydrate: 0.1 }
rice          = { protein: 2.8, fat: 0.4, carbohydrate: 34.3 } # 3割もちむぎ
# 一日の摂取目安からプロテイン分引く
daily_goal.merge!(protein_drink) { |key, daily_val, drink_val| daily_val - drink_val * protein_drink_count }
# 100g単位から10g単位に変換
chest_10g = { protein: chest[:protein] / 10, fat: chest[:fat] / 10, carbohydrate: chest[:carbohydrate] / 10 }
rice_10g  = { protein: rice[:protein] / 10, fat: rice[:fat] / 10, carbohydrate: rice[:carbohydrate] / 10 }
# 一食の摂取目安
goal  = { protein: daily_goal[:protein] / meal_count, fat: daily_goal[:fat] / meal_count, carbohydrate: daily_goal[:carbohydrate] / meal_count }
total = 100000
ans   = {}
puts "goal: p: #{goal[:protein]}, f: #{goal[:fat]}, c: #{goal[:carbohydrate]}"
(1..30).to_a.each do |i|
  a_p = chest_10g[:protein] * i
  a_f = chest_10g[:fat] * i
  a_c = chest_10g[:carbohydrate] * i
  (1..30).to_a.each do |j|
    b_p = rice_10g[:protein] * j
    b_f = rice_10g[:fat] * j
    b_c = rice_10g[:carbohydrate] * j
    p   = a_p + b_p
    f   = a_f + b_f
    c   = a_c + b_c
    tmp = goal[:protein] - p + goal[:carbohydrate] - c
    if (p > goal[:protein] || f > goal[:fat] || c > goal[:carbohydrate]) || tmp >= total
      next
    else
      total              = tmp
      ans[:chest]        = i * 10
      ans[:rice]         = j * 10
      ans[:protein]      = p
      ans[:fat]          = f
      ans[:carbohydrate] = c
      ans[:rest_fat]     = goal[:fat] - f
    end
  end
end
puts "chest: #{ans[:chest]}g"
puts "rice: #{ans[:rice]}g"
puts "protein: #{ans[:protein]}, fat: #{ans[:fat]}, carbohydrate: #{ans[:carbohydrate]}"
