class StoreCreator

  def initialize(name, status = 0)
    @name = name
    @status = status
  end

  def execute
    Store.create(name: name, slug: slug, status: status)
  end


  private

  attr_reader :name, :status

  def slug
    name.parameterize
  end

end
