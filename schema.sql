CREATE TABLE items(
    iid int unique
    name text
    quantity int
    PRIMARY KEY (iid)
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(id)
)

CREATE TABLE warehouses(
    wid int unique
    name text
    quantity int
    PRIMARY KEY (wid)
)


-- https://www.w3schools.com/sql/sql_foreignkey.asp