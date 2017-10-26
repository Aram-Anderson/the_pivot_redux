start = Time.now

puts "started seeding at #{start}"

Item.destroy_all
Category.destroy_all
User.destroy_all
Order.destroy_all

Role.create([{role: 0}, {role: 1}])


bus_man = Role.find(1)
bus_admin = Role.find(2)


mimi = User.create(first_name: "Mimi", last_name: "Le", email: "mimi@mimi.com", password: "mimi", address: "666 Spooky Ave, Halloween City, NO 66666", phone: "+13033333333")
user_1 = User.create!(first_name: "Ricky", last_name: "Hoola", email: "ricky@ricky.com", password: "ricky", address: "1111 Hoola Hoop Drive, Big Island, HI 90505", phone: "+13033333333")
user_2 = User.create(first_name: "Sam", last_name: "Snider", email: "snider@sam.com", password: "sam", address: "1000 Sunny Dr., Sunshine, CO 10000", phone: "+13033333333")
user_3 = User.create(first_name: "Kali", last_name: "Bike Rider", email: "kali@biking.com", password: "bike", address: "1010 Biking Home, Cool CA 10101", phone: "+13033333333")
user_4 = User.create(first_name: "Sam", last_name: "Nayrouz", email: "sam@sam.com", password: "sam123", address: "1010 Biking Home, Cool CA 10101", phone: "+13033333333", platform_admin: true)

description = "Lorem ipsum dolor sit amet, officiis quaerendum eu nam, voluptua deterruisset vix at. In dico sonet aliquip has, eos prima appellantur ea. Omnesque facilisi cu pro. Ut vix brute etiam repudiare. Esse animal explicari ad eam, vis ex oratio ornatus voluptatibus, movet sadipscing ea qui."

unicorn = Category.create(title: "Unicorns", slug: "unicorns")
squirrel = Category.create(title: "Squirrels", slug: "squirrels")
giraffe = Category.create(title: "Giraffes", slug: "giraffes")
cat = Category.create(title: "Cats", slug: "cats")
penguin = Category.create(title: "Penguins", slug: "penguins")
pokemon = Category.create(title: "Pokemon", slug: "pokemon")
zebra = Category.create(title: "Zebras", slug: "zebras")
sloth = Category.create(title: "Sloths", slug: "sloths")
cow = Category.create(title: "Cows", slug: "cows")
bird = Category.create(title: "Birds", slug: "birds")

store = StoreCreator.new("onesies").execute
onesie_manager = UserRole.create(user_id: 1, role_id: bus_man.id, store_id: store.id)
onesie_admin = UserRole.create(user_id: 2, role_id: bus_admin.id, store_id: store.id)



unicorn.items.create(title: "Baby Unicorn",
                      description: description,
                      price: 39.99,
                      image: File.new("./app/assets/images/baby-unicorn-onesie.png"),
                      store: store)


unicorn.items.create(title: "Adult Unicorn",
                      description: description,
                      price: 59.99,
                     image: File.new("./app/assets/images/unicorn-onesie.png"),
                      store: store)


squirrel.items.create(title: "Adult Squirrel - Pink/White",
                      description: description,
                      price: 59.99,
                      image: File.new("./app/assets/images/flying-squirrel-onesie-1.png"),
                    store: store)


squirrel.items.create(title: "Adult Squirrel - Orange/Black",
                      description: description,
                      price: 59.99,
                      image: File.new("./app/assets/images/flying-squirrel-onesie-2.png"),
                    store: store)


giraffe.items.create(title: "Adult Giraffe",
                      description: description,
                      price: 59.99,
                      image: File.new("./app/assets/images/giraffe-onesie.png"),
                    store: store)


cat.items.create(title: "Adult Leopard",
                      description: description,
                      price: 49.99,
                      image: File.new("./app/assets/images/leopard-onesie.png"),
                    store: store)


cat.items.create(title: "Adult Tiger",
                      description: description,
                      price: 49.99,
                      image: File.new("./app/assets/images/tiger-onesie.png"),
                      store: store)


penguin.items.create(title: "Adult Penguin",
                      description: description,
                      price: 49.99,
                      image: File.new("./app/assets/images/penguin-onesie.png"),
                    store: store)


pokemon.items.create(title: "Young Pikachu - Boy",
                      description: description,
                      price: 29.99,
                      image: File.new("./app/assets/images/pikachu-onesie-boy.png"),
                    store: store)


pokemon.items.create(title: "Young Pikachu - Girl",
                      description: description,
                      price: 29.99,
                      image: File.new("./app/assets/images/pikachu-onesie-girl.png"),
                      store: store,
                      condition: 1)


zebra.items.create(title: "Adult Zebra",
                      description: description,
                      price: 29.99,
                      image: File.new("./app/assets/images/zebra-onesie.png"),
                      store: store,
                     condition: 1)


sloth.items.create(title: "Adult Sloth",
                      description: description,
                      price: 69.99,
                      image: File.new("./app/assets/images/sloth-onesie.png"),
                      store: store,
                      condition: 1)


STORES = []

20.times do
  STORES << StoreCreator.new(Faker::Company.name).execute
end

unicorn.items.create(title: "Baby Unicorn",
                      description: description,
                      price: 39.99,
                      image: File.new("./app/assets/images/baby-unicorn-onesie.png"),
                      store: STORES.sample)


unicorn.items.create(title: "Adult Unicorn",
                      description: description,
                      price: 59.99,
                     image: File.new("./app/assets/images/unicorn-onesie.png"),
                      store: STORES.sample)


squirrel.items.create(title: "Adult Squirrel - Pink/White",
                      description: description,
                      price: 59.99,
                      image: File.new("./app/assets/images/flying-squirrel-onesie-1.png"),
                    store: STORES.sample)


squirrel.items.create(title: "Adult Squirrel - Orange/Black",
                      description: description,
                      price: 59.99,
                      image: File.new("./app/assets/images/flying-squirrel-onesie-2.png"),
                    store: STORES.sample)


giraffe.items.create(title: "Adult Giraffe",
                      description: description,
                      price: 59.99,
                      image: File.new("./app/assets/images/giraffe-onesie.png"),
                    store: STORES.sample)


cat.items.create(title: "Adult Leopard",
                      description: description,
                      price: 49.99,
                      image: File.new("./app/assets/images/leopard-onesie.png"),
                    store: STORES.sample)


cat.items.create(title: "Adult Tiger",
                      description: description,
                      price: 49.99,
                      image: File.new("./app/assets/images/tiger-onesie.png"),
                      store: STORES.sample)


penguin.items.create(title: "Adult Penguin",
                      description: description,
                      price: 49.99,
                      image: File.new("./app/assets/images/penguin-onesie.png"),
                    store: STORES.sample)


pokemon.items.create(title: "Young Pikachu - Boy",
                      description: description,
                      price: 29.99,
                      image: File.new("./app/assets/images/pikachu-onesie-boy.png"),
                    store: STORES.sample)


pokemon.items.create(title: "Young Pikachu - Girl",
                      description: description,
                      price: 29.99,
                      image: File.new("./app/assets/images/pikachu-onesie-girl.png"),
                      store: STORES.sample,
                      condition: 1)


zebra.items.create(title: "Adult Zebra",
                      description: description,
                      price: 29.99,
                      image: File.new("./app/assets/images/zebra-onesie.png"),
                      store: STORES.sample,
                     condition: 1)


sloth.items.create(title: "Adult Sloth",
                      description: description,
                      price: 69.99,
                      image: File.new("./app/assets/images/sloth-onesie.png"),
                      store: STORES.sample,
                      condition: 1)


statuses = ["ordered", "paid", "cancelled", "completed"]
users = [user_1.id, user_2.id, user_3.id, user_4.id]

statuses.each do |status|
  users.each do |user|
    Order.create(status: status, user_id: user)
  end
end

Order.all.each do |order|
  order.items << Item.all.sample
end

OrderItem.all.each do |order_item|
  order_item.quantity = rand(1..10)
  order_item.save!
end

Category.all.each do |category|
  50.times do
    category.items.create(title: Faker::Lorem.word, description: LiterateRandomizer.paragraph, price: rand(0.99..500.00).round(2), store: STORES.sample)
  end
end

1000.times do
  User.create(first_name:  Faker::Name.first_name, last_name:  Faker::Name.last_name, email:  Faker::Internet.email, password:  Faker::Internet.password, address:  Faker::Address.street_address, phone: Faker::PhoneNumber.phone_number)
end

User.all.each do |user|
  rand(10..20).times do
    order = user.orders.create(status: statuses.sample)
    order.items << Item.all.sample(rand(1..5))
  end
end
puts "Seeding took #{Time.now - start} seconds"
