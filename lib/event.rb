class Event

  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(truck)
    @food_trucks << truck
  end

  def food_truck_names
    @food_trucks.map {|truck| truck.name}
  end

  def food_trucks_that_sell(item)
    @food_trucks.find_all {|truck| truck.inventory.include?(item)}
  end

  def sorted_item_list
    @food_trucks.reduce([]) do |acc, truck|
      acc << truck.inventory.map {|item| item[0].name}
      acc.flatten.uniq.sort
    end
  end
end
