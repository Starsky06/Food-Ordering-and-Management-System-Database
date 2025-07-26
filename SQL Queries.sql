/*
GROUP NUMBER: G93
PROGRAMME: CS
STUDENT ID: 2301757
STUDENT NAME: Ho Yu Hao
Submission date and time: 29 April 2025 4PM
*/

alter session set "_oracle_script"=true;
SET SERVEROUTPUT ON


/* Query 1: Customer Order History with Total Spending */

SELECT c.Customer_ID, c.First_Name || ' ' || c.Last_Name AS Customer_Name, COUNT(o.Order_ID) AS Total_Orders, 
SUM(o.Total_Amount) AS Total_Spent, MAX(o.Order_date) AS Last_Order_Date
FROM Customer c, Orders o
WHERE c.Customer_ID = o.Customer_ID
AND o.Order_Status = 'Completed'
GROUP BY c.Customer_ID, c.First_Name, c.Last_Name
ORDER BY Total_Spent DESC;



/* Query 2: Restaurant Performance Analysis */

SELECT r.Restaurant_ID, r.RestaurantName, COUNT(DISTINCT o.Order_ID) AS Total_Orders, 
SUM(o.Total_Amount) AS Total_Revenue, AVG(o.Total_Amount) AS Average_Order_Value, COUNT(DISTINCT o.Customer_ID) AS Unique_Customers
FROM Restaurant r, Orders o
WHERE r.Restaurant_ID = o.Restaurant_ID
AND o.Order_date BETWEEN TO_DATE('2025-04-01', 'YYYY-MM-DD')
AND TO_DATE('2025-04-30', 'YYYY-MM-DD')
AND o.Order_Status = 'Completed'
GROUP BY r.Restaurant_ID, r.RestaurantName
ORDER BY Total_Revenue DESC;



/* Stored procedure 1: Process New Order */

CREATE OR REPLACE PROCEDURE process_new_order(
    p_order_id IN VARCHAR2,
    p_customer_id IN VARCHAR2,
    p_restaurant_id IN VARCHAR2,
    p_order_type IN VARCHAR2,
    p_total_amount IN NUMBER  
)

IS
    v_exists NUMBER;
BEGIN
    -- Check if order already exists
    SELECT COUNT(*)
    INTO v_exists
    FROM Orders
    WHERE Order_ID = p_order_id;
    
    -- If order exists, update it
    IF v_exists > 0 THEN
        UPDATE Orders
        SET Order_date = SYSDATE,
            Order_Status = 'Pending',
            Order_time = TO_CHAR(SYSTIMESTAMP, 'HH24:MI'),
            Total_Amount = p_total_amount,
            Order_Type = p_order_type,
            Customer_ID = p_customer_id,
            Restaurant_ID = p_restaurant_id
        WHERE Order_ID = p_order_id;
    ELSE
        -- If order doesn't exist, insert it
        INSERT INTO Orders (
            Order_ID, Order_date, Order_Status, Order_time, 
            Total_Amount, Order_Type, Customer_ID, Restaurant_ID
        ) 
        VALUES (
            p_order_id, SYSDATE, 'Pending', TO_CHAR(SYSTIMESTAMP, 'HH24:MI'),
            p_total_amount, p_order_type, p_customer_id, p_restaurant_id
        );
    END IF;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Order ' || p_order_id || ' processed successfully.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error processing order: ' || SQLERRM);
END;
/

-- Usage Example 
BEGIN
   
    process_new_order('OR-1001', 'C-10001', 'R-1001', 'Dine-in', 50.75);
    process_new_order('OR-1011', 'C-10002', 'R-1002', 'Delivery', 35.20);
    
END;
/



/* Stored procedure 2: Update Inventory Levels */

CREATE OR REPLACE PROCEDURE update_inventory(
    p_inventory_id IN VARCHAR2,
    p_quantity_change IN NUMBER,
    p_transaction_type IN VARCHAR2,
    p_employee_id IN VARCHAR2
)
IS
    v_exists NUMBER;
    v_current_quantity NUMBER;
BEGIN
    -- Check if inventory exists
    SELECT COUNT(*)
    INTO v_exists
    FROM Inventory
    WHERE Inventory_ID = p_inventory_id;
    
    -- Get current quantity if exists
    IF v_exists > 0 THEN
        SELECT QuantityInStock
        INTO v_current_quantity
        FROM Inventory
        WHERE Inventory_ID = p_inventory_id;
        
        -- Update inventory based on transaction type
        IF p_transaction_type = 'Purchase' OR p_transaction_type = 'Restock' THEN
            UPDATE Inventory
            SET QuantityInStock = QuantityInStock + p_quantity_change
            WHERE Inventory_ID = p_inventory_id;
        ELSIF p_transaction_type = 'Sale' THEN
            -- Check stock before sale
            IF v_current_quantity < p_quantity_change THEN
                RAISE_APPLICATION_ERROR(-20002, 'Insufficient stock');
            END IF;
            
            UPDATE Inventory
            SET QuantityInStock = QuantityInStock - p_quantity_change
            WHERE Inventory_ID = p_inventory_id;
        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'Invalid transaction type');
        END IF;
    ELSE
        RAISE_APPLICATION_ERROR(-20003, 'Inventory item not found');
    END IF;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Inventory updated successfully');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating inventory: ' || SQLERRM);
END;
/

-- Usage Example 
BEGIN
    
    update_inventory('INV-1001', 20, 'Restock', 'E-12021');
    update_inventory('INV-1001', 5, 'Sale', 'E-12021');

END;
/



/* Function 1: Calculate Customer Loyalty Discount */

CREATE OR REPLACE FUNCTION calculate_loyalty_discount(
p_customer_id IN VARCHAR2

) RETURN NUMBER
IS
    v_loyalty_points NUMBER;
v_discount_percentage NUMBER;

BEGIN
    SELECT Loyalty_Points
    INTO v_loyalty_points
    FROM Customer
    WHERE Customer_ID = p_customer_id;
    
    -- Calculate discount based on points
    IF v_loyalty_points >= 200 THEN
        v_discount_percentage := 15;
    ELSIF v_loyalty_points >= 100 THEN
        v_discount_percentage := 10;
    ELSIF v_loyalty_points >= 50 THEN
        v_discount_percentage := 5;
    ELSE
        v_discount_percentage := 0;
    END IF; 
RETURN v_discount_percentage;

EXCEPTION

    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RETURN 0;
END;
/

--Usage Example 
SELECT calculate_loyalty_discount('C-10001') FROM dual;



/* Function 2: Calculate Employee Monthly Salary */

CREATE OR REPLACE FUNCTION calculate_employee_salary(
    p_employee_id IN VARCHAR2,
    p_hours_worked IN NUMBER
) RETURN NUMBER
IS
    v_hourly_rate NUMBER;
    v_salary NUMBER;
v_employee_type VARCHAR2(20);

BEGIN
    -- Get employee details
    SELECT HourlyRate, Employee_Type
    INTO v_hourly_rate, v_employee_type
    FROM Employee
    WHERE Employee_ID = p_employee_id;
    
    -- Calculate base salary
    v_salary := v_hourly_rate * p_hours_worked;
    
    -- Add bonuses for managers
    IF v_employee_type = 'Manager' THEN
        v_salary := v_salary * 1.1; -- 10% bonus for managers
    END IF;
RETURN ROUND(v_salary, 2);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RETURN 0;
END;
/

--Usage Example 
SELECT calculate_employee_salary('E-12021', 160) FROM dual;
