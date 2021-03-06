class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def total_count
    contents.values.sum
  end

  def add_item(id)
    contents[id.to_s] = (contents[id.to_s] || 0) + 1
  end

  def decrease_quantity(id)
    if contents[id.to_s] > 0
      contents[id.to_s] -=1
    end
    if contents[id.to_s] == 0
      delete_item(id)
    end
  end

  def increase_quantity(id)
    contents[id.to_s] += 1
  end

  def count_of(id)
    contents[id.to_s].to_i
  end

  def item_and_quantity
    items = {}
    contents.each do |item_id, quantity|
      items[Item.find(item_id)] = quantity
    end
    items
  end

  def delete_item(id)
    contents.delete(id.to_s)
  end

  def destroy
    @contents.clear
  end

end
