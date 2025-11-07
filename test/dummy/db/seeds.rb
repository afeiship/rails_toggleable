# db/seeds.rb

puts "Seeding Users..."

# 创建几个用户
users_data = [
  { name: "Alice Johnson", email: "alice@example.com", active: true },
  { name: "Bob Smith", email: "bob@example.com", active: false },
  { name: "Charlie Brown", email: "charlie@example.com", active: true },
  { name: "Diana Prince", email: "diana@example.com", active: true },
  { name: "Ethan Hunt", email: "ethan@example.com", active: false }
]

users_data.each do |user_attrs|
  user = User.find_or_create_by!(email: user_attrs[:email]) do |u|
    u.name = user_attrs[:name]
    u.active = user_attrs[:active] # 这里会用到我们添加的 toggleable 字段
  end
  puts "Created/Found User: #{user.name} (Active: #{user.active?})"
end

puts "\nSeeding Posts..."

# 创建几个文章
posts_data = [
  {
    title: "Introduction to Rails",
    content: "Rails is a powerful web application framework...",
    published: true,
    user: User.find_by!(email: "alice@example.com")
  },
  {
    title: "Advanced Ruby Techniques",
    content: "Exploring metaprogramming and other advanced features...",
    published: false,
    user: User.find_by!(email: "bob@example.com")
  },
  {
    title: "Building APIs with Rails",
    content: "Creating robust and scalable APIs...",
    published: true,
    user: User.find_by!(email: "charlie@example.com")
  },
  {
    title: "Rails Security Best Practices",
    content: "Protecting your application from common vulnerabilities...",
    published: true,
    user: User.find_by!(email: "diana@example.com")
  },
  {
    title: "Testing Rails Applications",
    content: "Writing effective unit, integration, and system tests...",
    published: false,
    user: User.find_by!(email: "ethan@example.com")
  }
]

posts_data.each do |post_attrs|
  post = Post.find_or_create_by!(title: post_attrs[:title]) do |p|
    p.content = post_attrs[:content]
    p.published = post_attrs[:published]
    p.user = post_attrs[:user] # 假设 Post 有一个 user 关联
  end
  puts "Created/Found Post: '#{post.title}' (Published: #{post.published?}) by #{post.user.name}"
end

puts "\nSeeding completed!"