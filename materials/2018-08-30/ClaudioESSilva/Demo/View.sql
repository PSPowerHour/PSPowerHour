/* View: V_Customers */
CREATE VIEW V_Customers(
    ID,
    NAME,
    COMPANY_NAME)
AS
select ID, NAME, COMPANY_NAME
FROM Customers
WHERE name STARTING 'potatos'
;
