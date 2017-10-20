Item.destroy_all
Category.destroy_all
User.destroy_all
Order.destroy_all
Store.destroy_all
User.destroy_all
Role.destroy_all

role_1 = Role.create(name: "Registered User")
role_2 = Role.create(name: "Business Manager")
role_3 = Role.create(name: "Store Admin")
role_4 = Role.create(name: "Platform Admin")

store = StoreCreator.new("Mimi's shop of horrors").execute
store_2 = StoreCreator.new("Why, dear god why").execute

user = User.create(first_name: "Mimi", last_name: "Le", email: "mimi@mimi.com", password: "mimi", address: "666 Spooky Ave, Halloween City, NO 66666")
user_1 = User.create!(first_name: "Ricky", last_name: "Hoola", email: "ricky@ricky.com", password: "ricky", address: "1111 Hoola Hoop Drive, Big Island, HI 90505")
user_2 = User.create(first_name: "Sam", last_name: "Snider", email: "sam@sam.com", password: "sam", address: "1000 Sunny Dr., Sunshine, CO 10000")
user_3 = User.create(first_name: "Kali", last_name: "Bike Rider", email: "kali@biking.com", password: "bike", address: "1010 Biking Home, Cool CA 10101")

UserRole.create(user: user, role: role_3, store: store)
UserRole.create(user: user_1, role: role_2, store: store)
UserRole.create(user: user_2, role: role_1, store: store)
UserRole.create(user: user_3, role: role_1, store: store)

description = "Lorem ipsum dolor sit amet, officiis quaerendum eu nam, voluptua deterruisset vix at. In dico sonet aliquip has, eos prima appellantur ea. Omnesque facilisi cu pro. Ut vix brute etiam repudiare. Esse animal explicari ad eam, vis ex oratio ornatus voluptatibus, movet sadipscing ea qui."

clothing = Category.create(title: "Clothing", slug: "clothing")

clothing.items.create(title: "Baby Unicorn",
                      description: description,
                      price: 39.99,
                      image: File.new("./app/assets/images/baby-unicorn-onesie.png"),
                      store_id: 1)


clothing.items.create(title: "Adult Unicorn",
                      description: description,
                      price: 59.99,
                     image: File.new("./app/assets/images/unicorn-onesie.png"),
                      store_id: 1)


clothing.items.create(title: "Adult Squirrel - Pink/White",
                      description: description,
                      price: 59.99,
                      image: File.new("./app/assets/images/flying-squirrel-onesie-1.png"),
                      store_id: 1)


clothing.items.create(title: "Adult Squirrel - Orange/Black",
                      description: description,
                      price: 59.99,
                      image: File.new("./app/assets/images/flying-squirrel-onesie-2.png"),
                      store_id: 1)


clothing.items.create(title: "Adult Giraffe",
                      description: description,
                      price: 59.99,
                      image: File.new("./app/assets/images/giraffe-onesie.png"),
                      store_id: 1)


clothing.items.create(title: "Adult Leopard",
                      description: description,
                      price: 49.99,
                      image: File.new("./app/assets/images/leopard-onesie.png"),
                      store_id: 1)


clothing.items.create(title: "Adult Tiger",
                      description: description,
                      price: 49.99,
                      image: File.new("./app/assets/images/tiger-onesie.png"),
                      store_id: 1)


clothing.items.create(title: "Adult Penguin",
                      description: description,
                      price: 49.99,
                      image: File.new("./app/assets/images/penguin-onesie.png"),
                      store_id: 1)


clothing.items.create(title: "Young Pikachu - Boy",
                      description: description,
                      price: 29.99,
                      image: File.new("./app/assets/images/pikachu-onesie-boy.png"),
                      store_id: 1)


clothing.items.create(title: "Young Pikachu - Girl",
                      description: description,
                      price: 29.99,
                      image: File.new("./app/assets/images/pikachu-onesie-girl.png"),
                      store_id: 2)


clothing.items.create(title: "Adult Zebra",
                      description: description,
                      price: 29.99,
                      image: File.new("./app/assets/images/zebra-onesie.png"),
                      store_id: 2)


clothing.items.create(title: "Adult Sloth",
                      description: description,
                      price: 69.99,
                      image: File.new("./app/assets/images/sloth-onesie.png"),
                      store_id: 2)


statuses = ["ordered", "paid", "cancelled", "completed"]
users = [user_1.id, user_2.id, user_3.id]

statuses.each do |status|
  users.each do |user|
    Order.create(status: status, user_id: user.id)
  end
end

Order.all.each do |order|
  order.items << Item.all.sample
end

OrderItem.all.each do |order_item|
  order_item.quantity = rand(1..10)
  order_item.save!
end
