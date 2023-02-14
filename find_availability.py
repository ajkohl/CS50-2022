from cs50 import SQL

db = SQL("sqlite:///amazon.db")


def find_availability(item_id):
    """Returns a list of warehouses in which an item with `item_id` is in stock"""
    warehouses = db.execute("SELECT warehouses.name FROM warehouses JOIN items ON warehouses.wid = items.warehouse_id WHERE items.iid = ?", item_id)
