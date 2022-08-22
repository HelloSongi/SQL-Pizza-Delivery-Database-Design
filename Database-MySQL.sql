


CREATE TABLE `Orders` (
    `row_id` int  NOT NULL ,
    `order_id` varchar(10)  NOT NULL ,
    `created_at` datetime  NOT NULL ,
    `cust_id` int  NOT NULL ,
    `quantity` int  NOT NULL ,
    `delivery` boolean  NOT NULL ,
    `add_id` int  NOT NULL ,
    `item_id` int  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

CREATE TABLE `Customers` (
    `cust_id` int  NOT NULL ,
    `cust_firstName` varchar(50)  NOT NULL ,
    `cust_lastName` varchar(50)  NOT NULL ,
    PRIMARY KEY (
        `cust_id`
    )
);

CREATE TABLE `Address` (
    `add_id` int  NOT NULL ,
    `delivery_address1` varchar(200)  NOT NULL ,
    `delivery_address2` varchar(200)  NULL ,
    `delivery_city` varchar(50)  NOT NULL ,
    `delivery_zipCode` varchar(20)  NOT NULL ,
    PRIMARY KEY (
        `add_id`
    )
);

CREATE TABLE `Item` (
    `item_id` int  NOT NULL ,
    `item_name` varchar(50)  NOT NULL ,
    `item_cat` varchar(50)  NOT NULL ,
    `item_size` varchar(20)  NOT NULL ,
    `item_price` decimal(5,2)  NOT NULL ,
    `sku` varchar(20)  NOT NULL ,
    PRIMARY KEY (
        `item_id`
    )
);

CREATE TABLE `Recipe` (
    `row_id` int  NOT NULL ,
    `recipe_id` varchar(20)  NOT NULL ,
    `ing_id` varchar(20)  NOT NULL ,
    `quantity` int  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

CREATE TABLE `Ingredient` (
    `ing_id` varchar(20)  NOT NULL ,
    `ing_name` varchar(200)  NOT NULL ,
    `ing_weignt` int  NOT NULL ,
    `ing_meas` varchar(20)  NOT NULL ,
    `ing_price` decimal(5,2)  NOT NULL ,
    PRIMARY KEY (
        `ing_id`
    )
);

CREATE TABLE `Invertory` (
    `inv_id` int  NOT NULL ,
    `item_id` varchar(20)  NOT NULL ,
    `quantity` int  NOT NULL ,
    PRIMARY KEY (
        `inv_id`
    )
);

CREATE TABLE `Rotation` (
    `row_id` int  NOT NULL ,
    `rota_id` int  NOT NULL ,
    `date` datetime  NOT NULL ,
    `staff_id` varchar(20)  NOT NULL ,
    `shift_id` varchar(10)  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

CREATE TABLE `Staff` (
    `staff_id` int  NOT NULL ,
    `firstName` varchar(50)  NOT NULL ,
    `lastName` varchar(50)  NOT NULL ,
    `position` varchar(100)  NOT NULL ,
    `houry_rate` decimal(5,2)  NOT NULL ,
    PRIMARY KEY (
        `staff_id`
    )
);

CREATE TABLE `Shift` (
    `shift_id` varchar(20)  NOT NULL ,
    `day_of_week` varchar(10)  NOT NULL ,
    `start_time` time  NOT NULL ,
    `end_time` time  NOT NULL ,
    PRIMARY KEY (
        `shift_id`
    )
);

ALTER TABLE `Customers` ADD CONSTRAINT `fk_Customers_cust_id` FOREIGN KEY(`cust_id`)
REFERENCES `Orders` (`cust_id`);

ALTER TABLE `Address` ADD CONSTRAINT `fk_Address_add_id` FOREIGN KEY(`add_id`)
REFERENCES `Orders` (`add_id`);

ALTER TABLE `Item` ADD CONSTRAINT `fk_Item_item_id` FOREIGN KEY(`item_id`)
REFERENCES `Orders` (`item_id`);

ALTER TABLE `Recipe` ADD CONSTRAINT `fk_Recipe_recipe_id` FOREIGN KEY(`recipe_id`)
REFERENCES `Item` (`sku`);

ALTER TABLE `Ingredient` ADD CONSTRAINT `fk_Ingredient_ing_id` FOREIGN KEY(`ing_id`)
REFERENCES `Recipe` (`ing_id`);

ALTER TABLE `Invertory` ADD CONSTRAINT `fk_Invertory_item_id` FOREIGN KEY(`item_id`)
REFERENCES `Recipe` (`ing_id`);

ALTER TABLE `Rotation` ADD CONSTRAINT `fk_Rotation_date` FOREIGN KEY(`date`)
REFERENCES `Orders` (`created_at`);

ALTER TABLE `Staff` ADD CONSTRAINT `fk_Staff_staff_id` FOREIGN KEY(`staff_id`)
REFERENCES `Rotation` (`staff_id`);

ALTER TABLE `Shift` ADD CONSTRAINT `fk_Shift_shift_id` FOREIGN KEY(`shift_id`)
REFERENCES `Rotation` (`shift_id`);

