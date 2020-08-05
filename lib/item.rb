class Item

  attr_reader :name, :price

  def initialize(item)
    @name  = item[:name]
    @price = item[:price].split("$")[1].to_f.round(2)
  end
end
