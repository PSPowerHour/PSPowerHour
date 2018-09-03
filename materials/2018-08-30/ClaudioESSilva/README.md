* **Name**: Cláudio Silva
* **Title**: PowerShell and RegExp to convert code
* **Abstract**: I had a project where I needed to convert more than 100K lines of code. Can you imaginethe pain of doing it all by hand? I have created an PowerShell function that uses regularexpression in order to do the find/replace and used it on +1000 individual files. I did in less than 2 weeks what I initial expected to be several months.  Note: I have used it to convert from Firebird SQL to T-SQL flavor but you can use it to other goals.
* **Twitter**: [@claudioessilva](http://twitter.com/claudioessilva)
* **SlackID**: @ClaudioESSilva
* **GitHub**: [claudioessilva](http://www.github.com/claudioessilva)
* **Blog**: https://claudioessilva.eu




# This is PowerShell Power Hour!

### Cláudio Silva - Bio
 - SQL Server DBA
 - Cloud and Datacenter Management (PowerShell) MVP
 - [dbatools](https://dbatools.io) and [dbachecks](https://dbachecks.io) contributor
 - Speaker on several SQL Server & PowerShell user groups and conferences

<br>

# #PSPowerHour

## PowerShell and RegExp to convert code

### Problem
Converting large amounts of code is painfull!
To help (or not), the source and destination languages usually have lots of differences.

In this case I wanted to convert Firebird SQL to T-SQL. Firebird script has more than 60K lines of code. More than 1K objects (single files)

#### Example

This Firebird SQL code
```
WHERE [column] STARTING 'potatos'
```

translates to SQL Server T-SQL
```
WHERE [column] LIKE 'potatos%'
```

##### More complex example
Firebird SQL code:
```
CREATE OR ALTER TRIGGER Customers_BI FOR Customers
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_Customers_id,1);
end;
```

Can be translated to this SQL Server T-SQL code:
```
CREATE TRIGGER dbo.Customers_BI
ON dbo.Customers
INSTEAD OF INSERT
AS
    BEGIN
          IF EXISTS
            (
                SELECT
                       1
                  FROM INSERTED
                 WHERE Inserted.ID IS NULL
            )
              BEGIN
                    INSERT INTO dbo.Customers (ID, <other columns>
                    SELECT
                           NEXT VALUE FOR dbo.gen_Customers_id
                         , <other columns>
                    FROM INSERTED;
             END
    END;
```

### Approach
 - Create a find/replace function that accepts regular expressions as parameter (used hashtable to multiple options at once)
 - Fulfill an hashtable with all the matches we need
 - Run the function for each file

### Advantages
 - This is an heavely repetitive task
 - Eliminate the risk from the process because this is highly prone to errors

<br>

### Outcome
 - I have made a couple of weeks what would take me several months.
 - "_You work too fast for us_"

<br>
<br>

## Note:
During the presentation, while running the trigger conversion (@[31m47s](https://www.youtube.com/watch?v=3Yq4sVWJrWo&feature=youtu.be&t=31m47s)) we can see an error that happened because I forgot to add a "carriage return" (CR) character between the two entries.
The hashtable entries needs to be one per line, hence the error.

Here is the video that shows the error and and how to fix.
[Fix hastable entries](https://claudioessilvaeu.files.wordpress.com/2018/08/fix_hastable_entries.gif)
