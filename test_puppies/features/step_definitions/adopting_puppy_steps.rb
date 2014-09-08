	Given /^I am on the puppy adoption site$/ do
		@browser.goto "http://puppies.herokuapp.com"
	end

	When /^I click the View Details button$/ do
		@browser.button(:value => "View Details").click
	end

	When /^I click the Adopt Me button$/ do
		@browser.button(:value => "Adopt Me!").click
		@cart = ShoppingCartPage.new(@browser)
	end

	When /^I click the Complete the Adoption button$/ do
		@browser.button(:value => "Complete the Adoption").click
	end

	When /^I enter "([^\"]*)" in the name field$/ do |name|
		@browser.text_field(:id => "order_name").set(name)
	end

	When /^I enter "([^\"]*)" in the address field$/ do |address|
		@browser.text_field(:id => "order_address").set(address)
	end

	When /^I enter "([^\"]*)" in the email field$/ do |email|
		@browser.text_field(:id => "order_email").set(email)
	end

	When /^I select "([^\"]*)" from the pay with dropdown$/ do |pay_type|
		@browser.select_list(:id => "order_pay_type").select(pay_type)
	end

	When /^I click the Place Order button$/ do
		@browser.button(:value => "Place Order").click
	end

	Then /^I should see ([^]*) as the name for line item (\d+)$/ do |name, \line_item|
		row = (line_item.to_i - 1) * 6
		@browser.table(:index => 0)[row][1].text.should include name
	end

	When /^I should see ([^]*) as the subtotal for line item (\d+)$/ do |subtotal,\line_item|
		row = (line_item.to_i - 1) * 6
		@browser.table(:index => 0)[row][3].text.should == subtotal
	end

	When /^I should see ([^]*) as the cart total$/ do |total|
		@browser.td(:class => 'total_cell').text.should == total
	end

	private
		def row_for(line_item)
			(line_item - 1) * 6
		end

		def cart_line_item(line_item)
			@browser.table(:index => 0)[row_for(line_item)]
		end
	end

	Then /^I should see ([^]*) as the name for line item (\d+)$/ do |name, line_item|
		# cart_line_item(line_item.to_i)[1].text.should include name
		@cart.name_for_line_item(line_item.to_i).should include name
	end

	When /^I should see ([^]*) as the subtotal for line item (\d+)$/ do |subtotal,\
		line_item|
		# cart_line_item(line_item.to_i)[3].text.should == subtotal
		@cart.subtotal_for_line_item(line_item.to_i).should == subtotal
	end

	When /^I should see ([^]*) as the cart total$/ do |total|
		# @browser.td(:class => 'total_cell').text.should == total
		@cart.cart_total.should == total
	end

	Then /^I should see "([^\"]*)"$/ do |expected|
		@browser.text.should include expected
	end