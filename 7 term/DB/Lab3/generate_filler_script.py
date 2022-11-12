from faker import Faker
from faker.providers import BaseProvider
from random import seed
from random import randint
import random
import string


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
		products.append((i, faker.product(), randint(1, 1000000)/100, randint(0, 9999999)))
	return products

def generate_suppliers(number):
	suppliers = []
	
	for i in range(number):
		suppliers.append((i, faker.company(), faker.address(), faker.phone_number()))
	return suppliers

def generate_shippers(number):
	shippers = []
	
	for i in range(number):
		shippers.append((i, faker.company(), faker.address(), ''.join([elem for elem in random.choices(string.digits, k=6)])))
	return shippers

def generate_warehouses(number, suppliers):
	warehouses = []
	seed(1)
	for i in range(number):
		warehouses.append((i, faker.address(), faker.phone_number(), suppliers[randint(0, len(suppliers) - 1)][0]))
	return warehouses

def generate_freights(number, customers):
	freights = []
	seed(1)
	for i in range(number):
		freights.append((i, faker.date(), faker.date(), faker.address(), customers[randint(0, len(customers) - 1)][0]))
	return freights

def generate_drivers(number, freights, shippers):
	drivers = []
	seed(1)
	for i in range(number):
		drivers.append((i, faker.name(), ''.join([elem for elem in random.choices(string.digits, k=8)]) + ''.join([elem for elem in random.choices(string.ascii_uppercase, k=3)]) + ''.join([elem for elem in random.choices(string.digits, k=2)]), freights[randint(0, len(freights) - 1)][0], shippers[randint(0, len(shippers) - 1)][0]))
	return drivers

def generate_trucks(number, drivers):
	trucks = []
	seed(1)
	for i in range(number):
		trucks.append((i, ''.join([elem for elem in random.choices(string.digits, k=4)]) + '-' + ''.join([elem for elem in random.choices(string.ascii_uppercase, k=2)]) + random.choice(string.digits), randint(2, 50), drivers[randint(0, len(drivers) - 1)][0]))
	return trucks

def generate_customers(number):
	customers = []
	
	for i in range(number):
		customers.append((i, faker.name(), faker.address(), faker.phone_number()))
	return customers

def fill_supplier_shipper(suppliers, shippers):
	result = []
	id = 0
	for i in range(len(suppliers)):
		for j in range(1, randint(2, len(shippers) * 0.2) + 3):
			result.append((id, i, shippers[randint(0, len(shippers) - 1)][0]))
			id += 1
	return result

def fill_warehouse_product(warehouses, products):
	result = []
	id = 0
	for i in range(len(warehouses)):
		for j in range(1, randint(2, len(products) * 0.2) + 3):
			result.append((id, i, products[randint(0, len(products) - 1)][0]))
			id += 1
	return result

def fill_freight_product(freight, products):
	result = []
	id = 0
	for i in range(len(freight)):
		for j in range(1, randint(2, len(products) * 0.2) + 3):
			result.append((id, i, products[randint(0, len(products) - 1)][0]))
			id += 1
	return result


f =  open("fill_database.sql", "w")
product_columns = ["id", "name", "price", "number"]
supplier_columns = ["id", "name", "address", "phone_number"]
shipper_columns = ["id", "name", "address", "postal_code"]
warehouse_columns = ["id", "address", "phone_number", "supplier_id"]
freight_columns = ["id", "start_date", "end_date", "destination", "customer_id"]
driver_columns = ["id", "name", "passport_number", "freight_id", "shipper_id"]
truck_columns = ["id", "registration_number", "max_load", "driver_id"]
customer_columns = ["id", "name", "address", "phone_number"]
supplier_shipper_columns = ["id", "supplier_id", "shipper_id"]
warehouse_product_columns = ["id", "warehouse_id", "product_id"]
freight_product_columns = ["id", "freight_id", "product_id"]

products = generate_products(10)
suppliers = generate_suppliers(10)
shippers = generate_shippers(10)
customers = generate_customers(10)
warehouses = generate_warehouses(10, suppliers)
freights = generate_freights(10, customers)
drivers = generate_drivers(10, freights, shippers)
trucks = generate_trucks(10, drivers)
supplier_shipper = fill_supplier_shipper(suppliers, shippers)
warehouse_product = fill_warehouse_product(warehouses, products)
freight_product = fill_freight_product(freights, products)



insert(f, "product", product_columns, products)

insert(f, "supplier", supplier_columns, suppliers)

insert(f, "shipper", shipper_columns, shippers)

insert(f, "customer", customer_columns, customers)

insert(f, "warehouse", warehouse_columns, warehouses)

insert(f, "freight", freight_columns, freights)

insert(f, "driver", driver_columns, drivers)

insert(f, "truck", truck_columns, trucks)

insert(f, "supplier_shipper", supplier_shipper_columns, supplier_shipper)

insert(f, "warehouse_product", warehouse_product_columns, warehouse_product)

insert(f, "freight_product", freight_product_columns, freight_product)