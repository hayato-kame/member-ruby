names = %w(Taro Jiro Hana John Mike Sophy Bill Alex Mary Tom)
fnames = ["佐藤", "鈴木", "高橋", "田中"]
gnames = ["太郎", "次郎", "花子"]
0.upto(9) do |idx|
  Member.create(
    number: idx + 10,
    name: names[idx],
    full_name: "#{fnames[idx % 4]} #{gnames[idx % 3]}",
    email: "#{names[idx]}@example.com",
    birthday: "1981-12-01",
    gender: [1, 1, 2][idx % 3],
    administrator: (idx == 0),
    password: "member!",
    password_confirmation: "member!"
  )
end

0.upto(29) do |idx|
  Member.create(
    number: idx + 20,
    name: "John#{idx + 1}",
    full_name: "John Doe#{idx + 1}",
    email: "John#{idx + 1}@example.com",
    birthday: "1981-12-01",
    gender: 1,
    administrator: false,
    password: "member!",
    password_confirmation: "member!"
    )
end

filename = "IMG_2066.jpg"
path = Rails.root.join(__dir__, filename)
m = Member.find_by!(number: 10)

File.open(path) do |f|
  m.profile_picture.attach(io: f, filename: filename)
end 

