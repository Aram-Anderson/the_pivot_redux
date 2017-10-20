class StoreCreator

  def initialize(name)
    @name = name
  end

  def execute
    Store.create(name: name, slug: slug)
  end


  private

  attr_reader :name

  def slug
    name.parameterize
  end

end
