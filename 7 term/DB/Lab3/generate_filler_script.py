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
