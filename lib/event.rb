require 'date'

class Event

  attr_reader :name, :food_trucks, :date_v

  def initialize(name)
    @name = name
    @food_trucks = []
    @date_v = Date.today
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

  def total_inventory
    result = Hash.new{|overstock, name| overstock[name] = {}}
    @food_trucks.each do |truck|
      truck.inventory.each do |item|
        result[item[0]] = {quantity: total_quantity(item),
                           food_trucks: food_trucks_that_sell(item[0])}
      end
    end
    result
  end

  def total_quantity(given)
    total = 0
    @food_trucks.each do |truck|
      truck.inventory.each do |item|
        total += item[1] if given[0] == item[0]
      end
    end
    total
  end

  def overstocked_items
    get_over_stock_list.map {|item| item[0]}
  end

  def get_over_stock_list
    overstock = Hash.new{|h,k| h[k] = {}}
    @food_trucks.each do |truck|
      truck.inventory.each do |item, quantity|
        overstock[item] = {vc: food_trucks_that_sell(item).length,
                           tq: quantity}
      end
    end
    overstock.find_all {|item| item[1][:vc] > 1 && item[1][:tq] > 50}
  end

  def date
    date_v.strftime("%d/%m/%Y")
  end

  def sell(item, amount)
      if total_quantity([item, 0]) < amount
        false
      else
        remove_quantity(item, amount)
        true
      end
  end

  def remove_quantity(g_item, number)
    total_inventory[g_item][:food_trucks].map do |truck|
      if truck.inventory[g_item] - number > 0
        truck.remove_stock(g_item, number)
      else
        require "pry"; binding.pry
      end
    end

  end


end
