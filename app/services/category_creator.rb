class CategoryCreator

  def initialize(title)
    @title = title
    execute
  end

  private

  attr_reader :title

  def execute
    Category.create(title: title, slug: get_slug)
  end

  def get_slug
    title.parameterize
  end
end
