CREATE OR ALTER PROCEDURE DEL_INS_Customers
AS
declare variable NAME type of column Customers.NAME;
declare variable COMPANY_NAME type of column Customers.COMPANY_NAME;
begin
  /* Procedure Text */
  delete from Customers;
  for
    select NAME, COMPANY_NAME
    from v_Customers
    into :NAME, :COMPANY_NAME
  do
  begin
     insert into Customers (NAME, COMPANY_NAME)
     values (:NAME, :COMPANY_NAME);
  end
end;