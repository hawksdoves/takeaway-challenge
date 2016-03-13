require_relative 'menu'

class CustomerOrder 

	attr_reader :my_order, :current_menu

	def initialize(instance_menu)
		@instance_menu = instance_menu
		@current_menu = @instance_menu.menu_list	
		@my_order = Hash.new
	end

	def add_to_order(this_dish, quantity)
		fail "#{this_dish} is not on the menu." if !@instance_menu.find(this_dish)
		if !find_item(this_dish).empty?
		 	@my_order[selected(this_dish)] = find_quantity(this_dish) + quantity
		else
			@my_order[selected(this_dish)] = quantity
		end
	end

	def remove_from_order(this_dish, quantity)
		fail "#{this_dish} is not in your order." if find_item(this_dish).empty?
		quantity < find_quantity(this_dish) ? @my_order[selected(this_dish)] = find_quantity(this_dish) - quantity : @my_order.delete(remove(this_dish))
	end

	def total_cost		 
		 cost
		 @sum
	end

	private

	def find_quantity(this_dish)
		@my_order[selected(this_dish)] 
	end

	def selected(this_dish)
		@current_menu.select {|k,v| k == this_dish }
	end

	def find_item(this_dish)
		@my_order.select{ |k,v| k[this_dish]}
	end

	def remove(this_dish)
		find_item(this_dish).keys[0]
	end

	def item_list
		help = []
		@my_order.keys.each {|value| value.each {|k,v| help << v}}
		help
	end

	def cost
		@sum = 0
		[@my_order.values,item_list].transpose.map{|x| x.reduce :*}.each {|k| @sum+=k}
	end

	# def subtotal
	# 	totals = Hash.new
	# 	cost.each {|key| @my_ordertotals[key] = cost[i]}
	# 	totals
	# end

end
