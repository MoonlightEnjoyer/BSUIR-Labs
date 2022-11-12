from faker import Faker
from faker.providers import BaseProvider

def insert(file, table_name, columns, values):
	for value in values:
		file.write("INSERT INTO " + table_name + " (")
		column_counter = 0
		for column in columns:
			file.write(column)
			column_counter += 1
			if column_counter != len(columns):
				file.write(", ")
		file.write(") ")
		file.write("VALUES (")
		value_counter = 0
		for v in value:
			file.write("'")
			file.write(str(v))
			file.write("'")
			value_counter += 1
			if value_counter != len(value):
				file.write(", ")
		file.write(");\n")


class ProductProvider(BaseProvider):
	__provider__ = "product"
	products = ["rice", "beer", "coil", "paper"]
	
	def product(self):
		return self.random_element(self.products)

faker = Faker()
faker.add_provider(ProductProvider)

def generate_products(number):
	products = []
	
	for i in range(number):
		products.append((i, faker.product(), faker.random_number(digits=4), faker.random_number(digits=6)))
	return products

def generate_suppliers(number):
	suppliers = []
	
	for i in range(number):
		suppliers.append((i, faker.company(), faker.address(), faker.phone_number()))
	return suppliers

def generate_shippers(number):
	shippers = []
	
	for i in range(number):
		shippers.append((i, faker.company(), faker.address(), faker.phone_number()))
	return shippers

def generate_warehouses(number):
	warehouses = []
	
	for i in range(number):
		warehouses.append((i, faker.address(), faker.phone_number(), faker.random_number(digits = 5))) #id of real supplier must be here
	return warehouses

def generate_freights(number):
	freights = []
	
	for i in range(number):
		freights.append((i, faker.date(), faker.date(), faker.address(), faker.random_number(digits = 5))) # id of real customer must be here
	return freights

def generate_drivers(number):
	drivers = []
	
	for i in range(number):
		drivers.append((i, faker.name(), str(faker.random_number(digits = 5)), faker.random_number(digits = 5), faker.random_number(digits = 5))) # id of real freight and shipper  must be here
	return drivers

def generate_trucks(number):
	trucks = []
	
	for i in range(number):
		trucks.append((i, str(faker.random_number(digits = 5)), faker.random_number(digits = 3), faker.random_number(digits = 5))) # change registration number and max load generation, insert real driver id
	return trucks

def generate_customers(number):
	customers = []
	
	for i in range(number):
		customers.append((i, faker.name(), faker.address(), faker.phone_number()))
	return customers



f =  open("fill_database.sql", "w")
product_columns = ["id", "name", "price", "number"]
supplier_columns = ["id", "name", "address", "phone_number"]
shipper_columns = ["id", "name", "address", "postal_code"]
warehouse_columns = ["id", "address", "phone_number", "supplier_id"]
freight_columns = ["id", "start_date", "end_date", "destination", "customer_id"]
driver_columns = ["id", "name", "passport_number", "freight_id", "shipper_id"]
truck_columns = ["id", "registration_number", "max_load", "driver_id"]
customer_columns = ["id", "name", "address", "phone_number"]

insert(f, "product", product_columns, generate_products(10))
insert(f, "supplier", supplier_columns, generate_suppliers(10))
insert(f, "shipper", shipper_columns, generate_shippers(10))
insert(f, "warehouse", warehouse_columns, generate_warehouses(10))
insert(f, "freight", freight_columns, generate_freights(10))
insert(f, "driver", driver_columns, generate_drivers(10))
insert(f, "truck", truck_columns, generate_trucks(10))
insert(f, "customer", customer_columns, generate_customers(10))
