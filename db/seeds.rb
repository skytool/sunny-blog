# Admin user
admin = User.find_or_create_by!(email: "admin@example.com") do |u|
  u.password = "password123"
  u.password_confirmation = "password123"
  u.admin = true
end
admin.update!(admin: true) unless admin.admin?
puts "✅ Admin: admin@example.com / password123"

# Categories
categories = %w[일상 여행 음식 사진 생각].map { |n| Category.find_or_create_by!(name: n) }

# Tags
tags = %w[여름 겨울 봄 가을 맛집 카페 바다 산 도시 자연].map { |n| Tag.find_or_create_by!(name: n) }

# Posts
[
  { title: "제주도에서 보낸 일주일", content: "제주도는 언제나 새로운 매력을 품고 있습니다. 이번에는 서귀포 쪽 올레길을 중심으로 걸었는데, 바닷바람과 함께 걷는 그 느낌이 잊을 수 없어요.", excerpt: "제주도 올레길과 한라산 여행기", published: true, category: categories[1], post_tags: [ tags[0], tags[6] ] },
  { title: "서울의 숨겨진 카페 5곳", content: "서울에는 정말 개성 있는 카페들이 많습니다. 성수동의 빈티지 감성 카페부터 북촌의 한옥 카페까지, 각각의 매력이 넘칩니다.", excerpt: "서울 숨겨진 카페 명소 소개", published: true, category: categories[2], post_tags: [ tags[5] ] },
  { title: "봄날의 벚꽃 나들이", content: "올해 봄에는 경주로 벚꽃 구경을 다녀왔어요. 불국사 주변의 벚꽃길은 정말 장관이었습니다.", excerpt: "경주 불국사 벚꽃길 여행", published: true, category: categories[0], post_tags: [ tags[2] ] }
].each do |attrs|
  pt = attrs.delete(:post_tags)
  post = Post.find_or_create_by!(title: attrs[:title]) { |p| p.assign_attributes(attrs.merge(user: admin)) }
  post.tags = pt
  post.save!
end
puts "✅ Posts created"

# Travel spots
spots = [
  { name: "제주도", country: "한국", city: "제주시", description: "한라산, 올레길, 오름의 섬", cover_image: "https://images.unsplash.com/photo-1590760475226-60ada5127a6f?w=400" },
  { name: "교토", country: "일본", city: "교토", description: "일본 전통 문화의 중심지", cover_image: "https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=400" },
  { name: "파리", country: "프랑스", city: "파리", description: "낭만의 도시", cover_image: "https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=400" },
  { name: "발리", country: "인도네시아", city: "우붓", description: "신들의 섬 발리", cover_image: "https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=400" }
].map { |a| TravelSpot.find_or_create_by!(name: a[:name]) { |s| s.assign_attributes(a) } }
puts "✅ Travel spots created"

# Reviews
[
  { travel_spot: spots[0], title: "제주 올레길 완주 후기", content: "올레 7코스를 완주했습니다. 바닷가를 따라 걷는 길이 정말 아름다웠어요.", rating: 5, visited_at: 1.month.ago },
  { travel_spot: spots[1], title: "교토 벚꽃 시즌 방문", content: "마루야마 공원의 벚꽃이 활짝 핀 시기에 방문했어요. 기온 거리 힐링 완료!", rating: 5, visited_at: 2.months.ago },
  { travel_spot: spots[2], title: "파리 3박 4일 여행", content: "에펠탑 야경은 환상적! 루브르는 이틀 이상 잡으세요. 크루아상이 이렇게 맛있을 줄이야.", rating: 4, visited_at: 3.months.ago }
].each { |a| TravelReview.find_or_create_by!(title: a[:title]) { |r| r.assign_attributes(a.merge(user: admin)) } }
puts "✅ Travel reviews created"
puts "\n🎉 Done! Login: admin@example.com / password123"
