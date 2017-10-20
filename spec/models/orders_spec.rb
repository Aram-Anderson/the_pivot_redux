require 'rails_helper'

RSpec.describe Order do
	describe 'validations' do
		describe 'invalid attributes' do
      it 'is invalid without a status' do
				Role.create([{role: 0}, {role: 1}, {role: 2}, {role: 3}])
        user = User.create!(first_name: "Testy", last_name: "McTest", password: "testing", email: "tester@testmail")
        user.orders.create
        expect(user.orders.first).to be_invalid
      end

    end
    describe 'valid attributes' do
      it 'is valid with a status' do
				Role.create([{role: 0}, {role: 1}, {role: 2}, {role: 3}])
        user = User.create!(first_name: "Testy", last_name: "McTest", password: "testing", email: "tester@testmail")
        user.orders.create(status: "ordered")
        expect(user.orders.first).to be_valid
      end
    end
  end
  describe 'realtionships' do
    it 'belongs to a user' do
			Role.create([{role: 0}, {role: 1}, {role: 2}, {role: 3}])
      user = User.create!(first_name: "Testy", last_name: "McTest", password: "testing", email: "tester@testmail")
      order = user.orders.create(status: "ordered")
      expect(order).to respond_to(:user)
    end
    it 'has many items' do
			Role.create([{role: 0}, {role: 1}, {role: 2}, {role: 3}])
      user = User.create!(first_name: "Testy", last_name: "McTest", password: "testing", email: "tester@testmail")
      order = user.orders.create(status: "ordered")
      expect(order).to respond_to(:items)
    end
    it 'belongs to a items' do
			Role.create([{role: 0}, {role: 1}, {role: 2}, {role: 3}])
      user = User.create!(first_name: "Testy", last_name: "McTest", password: "testing", email: "tester@testmail")
      order = user.orders.create(status: "ordered")
      category = Category.create(title: "Animals", slug: "animals")
      one_url = "http://pandathings.com/wp-content/uploads/2016/10/onesie-6-300x300.png"
			item = category.items.create(title: "Funsie Onesie", description: "number one", price: 8.00, image: one_url )
      expect(item).to respond_to(:orders)
    end
  end

	describe "instance methods" do
		it "can return total price of items" do
			Role.create([{role: 0}, {role: 1}, {role: 2}, {role: 3}])
			user = User.create!(first_name: "Testy", last_name: "McTest", password: "testing", email: "tester@testmail")
			order = user.orders.create!(status: "ordered")
			category = Category.create(title: "Animals", slug: "animals")
			one_url = "http://pandathings.com/wp-content/uploads/2016/10/onesie-6-300x300.png"
			item_1 = order.items.create(title: "Funsie Onesie", description: "number one", price: 8.00, image: one_url, category_id: 1)
			item_2 = order.items.create(title: "Funsie Twosie", description: "number two", price: 22.00, image: one_url, category_id: 1)

			expect(order.total_price).to eq(30.0)
		end

		it "can add an item" do
			Role.create([{role: 0}, {role: 1}, {role: 2}, {role: 3}])
			user = User.create!(first_name: "Testy", last_name: "McTest", password: "testing", email: "tester@testmail")
			store = create(:store)
			order = user.orders.create!(status: "ordered")
			category = Category.create(title: "Animals", slug: "animals")
			one_url = "http://pandathings.com/wp-content/uploads/2016/10/onesie-6-300x300.png"
			item = category.items.create(title: "Funsie Onesie", description: "number one", price: 8.00, image: one_url, store: store)
			item_hash = {item => 1}

			expect(order.items).to eq([])

			order.add(item_hash)

			expect(order.items.first).to eq(item)
		end

		it "can return the order date" do
			Role.create([{role: 0}, {role: 1}, {role: 2}, {role: 3}])
			user = User.create!(first_name: "Testy", last_name: "McTest", password: "testing", email: "tester@testmail")
			order = user.orders.create!(status: "ordered", created_at: "2017-09-13 01:13:04 -0600")

			expect(order.date).to eq("Sep. 13, 2017")
		end
	end

	describe "class methods" do
		it "can count by status" do
			Role.create([{role: 0}, {role: 1}, {role: 2}, {role: 3}])
			user = User.create(first_name: "Testy", last_name: "McTest", password: "testing", email: "tester@testmail")
			user.orders.create(status: "ordered")
			user.orders.create(status: "ordered")
			user.orders.create(status: "ordered")
			user.orders.create(status: "paid")
			user.orders.create(status: "paid")
			user.orders.create(status: "cancelled")

			status_count = {"paid"=>2, "ordered"=>3, "cancelled"=>1}

			expect(Order.count_by_status).to eq(status_count)
		end

		it "can filter by status" do
			Role.create([{role: 0}, {role: 1}, {role: 2}, {role: 3}])
			user = User.create(first_name: "Testy", last_name: "McTest", password: "testing", email: "tester@testmail")
			order_1 = user.orders.create(status: "ordered")
			user.orders.create(status: "ordered")
			user.orders.create(status: "ordered")
			user.orders.create(status: "paid")
			user.orders.create(status: "paid")
			user.orders.create(status: "cancelled")

			collection = Order.filter_by_status("ordered")

			expect(collection.first).to eq(order_1)
			expect(collection.count).to eq(3)
		end
	end
end
