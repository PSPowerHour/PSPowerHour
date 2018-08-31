/* Trigger: Customers_BI */
CREATE OR ALTER TRIGGER Customers_BI FOR Customers
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_Customers_id,1);
end;