
--------------------project Tasks-------------


-- 1:- Retrieve All Books Issued by a Specific Employee
--Objective: Select all books issued by the employee with emp_id = 'E101'

select  * from issued_status
where issued_emp_id= 'E101';


-- 2. Retrieve All Books in a Specific Category  ='classic' :

select * from books
where category='classic';



--3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table

select*from issued_status
where issued_id='IS121';    -- to check the record 


DELETE from issued_status
where issued_id='IS121';



 -- 4: List Members Who Have Issued More Than One Book 
 -- Objective: Use GROUP BY to find members who have issued more than one book.


 select issued_emp_id,
 count(issued_id) as tottal_book_issued
 from issued_status
 group by issued_emp_id
 having COUNT(issued_id)>1;

 ----or-----

 SELECT member_id,member_name
FROM members 
JOIN issued_status i ON member_id = member_id
GROUP BY member_id, member_name
HAVING COUNT(issued_book_isbn) >1;

select *from issued_status
where issued_member_id ='C106'; ---- to check to it exists or not 
  
 select  member_name from members
where member_id ='C106';




--5. Create a New Book Record 
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

insert into books(
	isbn_, 
	book_title, 
	category, 
	rental_price,
	status_ , 
	author,
	publisher
)
	VALUES
	('978-1-60129-456-2', 
	'To Kill a Mockingbird', 
	'Classic',
	  6.00, 
	  'yes' ,
	 'Harper Lee',
	 'J.B. Lippincott & Co.');
	select * from books;


-- 6: Update an Existing Member's Address = '125 Main St'  with member_id = 'C101';

UPDATE members
SET member_address = '125 Main St'
WHERE member_id = 'C101';
SELECT * FROM members;

SELECT * FROM members
WHERE member_id = 'C101'; -- to check update



 -- 7: Find Total Rental Income by Category_:

SELECT
   category,
    SUM(rental_price) AS total_rental_income,
	COUNT(category) AS TOTAL_CATEGORY
FROM books
GROUP BY
   category;

 select  rental_price,category from books;
 
--8:-List Employees with Their Branch Manager's Name and their branch details:
  
select 
e1.*,
b1.manager_id,
e2.emp_name as manager

from employe as e1
join
branch as b1
on b1.branch_id=e1.branch_id
join 
employe as e2
on b1.manager_id=e2.emp_id



 --9: Create Summary Tables: Used CTAS to generate new tables based on query results 
        --each book and total book_issued_cnt

 -- isbn= 'International Standard Book Number'
-- create table summery as 
select 
   isbn_,
    book_title,
   COUNT(isbn_) AS total_book_issued
FROM
 books
 JOIN
issued_status as ist
ON ist.issued_book_isbn = isbn_
GROUP BY
    isbn_, book_title;

-- 10. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:


--CREATE TABLE HighPricedBooks AS
SELECT 
    isbn_,
    book_title,
    rental_price
FROM
    books
WHERE
    rental_price > 7.00;



-- 11: Retrieve the List of Books Not Yet Returned

SELECT 
DISTINCT ist.issued_book_name
FROM issued_status as ist
LEFT JOIN
return_status as rs
ON ist.issued_id = rs.issued_id
WHERE rs.return_id IS NULL;


--12 :-  List Members Who Registered in the Last 180 Days:
INSERT INTO members(member_id, member_name, member_address, reg_date)
VALUES
('C121', 'sam', '154 Main St', '2025-03-01'),
('C120', 'john', '100 Main St', '2025-02-01');

select
member_id, reg_date
From  members
Where reg_date >= DATEADD(day, -180, GETDATE());

   

--13 :-write a new query to find the active_members containing members who have issued at least one book in the last 2 months.
SELECT 
member_id,
member_name,
reg_date
FROM members
WHERE member_id IN (
    SELECT DISTINCT issued_member_id
    FROM issued_status
    WHERE issued_date >= DATEADD(month, -2, GETDATE())
);


    
--14 :- Find Employees with the Most Book Issues Processed
-- Write a query to find the top 3 employees who have processed the most book issues. 
--Display the employee name, number of books processed, and their branch.
 SELECT top 3
 e.emp_name,
 b.branch_id,
 b.branch_address,
COUNT(ist.issued_id) AS no_book_issued
FROM issued_status AS ist
join employe AS e ON e.emp_id = ist.issued_emp_id
join branch AS b ON e.branch_id = b.branch_id
GROUP By e.emp_name, b.branch_id, b.branch_address
order by no_book_issued desc; 




---Branch Performance Report
/* 15:-  Branch Performance Report
 Write a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.
*/
  
  SELECT
    b.branch_id,
    b.manager_id,
    COUNT(i.issued_id) AS book_issued,
    COUNT(r.return_id) AS book_return,
    SUM(bk.rental_price) AS Total_revenue
FROM issued_status AS i
JOIN employe AS e ON e.emp_id = i.issued_emp_id
JOIN branch AS b ON e.branch_id = b.branch_id
LEFT JOIN return_status AS r ON r.issued_id = i.issued_id
JOIN books AS bk ON i.issued_book_isbn = bk.isbn_
GROUP BY b.branch_id, b.manager_id;





/* 16:-  Write a query to identify members who have overdue books (assume a 30-day return period). 
Display the member's_id, member's name, book title, issue date, and days overdue.*/

   
SELECT
    i.issued_member_id,
    m.member_name,
    b.book_title,
    i.issued_date,
    r.return_date,
    DATEDIFF(day, i.issued_date, GETDATE()) AS over_dues_days
FROM
issued_status AS i
join members AS m ON m.member_id = i.issued_member_id
join books AS b ON b.isbn_ = i.issued_book_isbn
left join return_status AS r ON r.issued_id = i.issued_id
Where r.return_date IS NULL AND DATEDIFF(day, i.issued_date, GETDATE()) > 30
ORDER BY i.issued_member_id;



/*
Task 19: Stored Procedure Objective: 

Create a stored procedure to manage the status of books in a library system. 

Description: Write a stored procedure that updates the status of a book in the library based on its issuance. 

The procedure should function as follows: 

The stored procedure should take the book_id as an input parameter. 

The procedure should first check if the book is available (status = 'yes'). 

If the book is available, it should be issued, and the status in the books table should be updated to 'no'. 

If the book is not available (status = 'no'), the procedure should return an error message indicating that the book is currently not available.
*/

CREATE PROCEDURE issue_book
    @p_issued_id VARCHAR(10),
    @p_issued_member_id VARCHAR(30),
    @p_issued_book_isbn VARCHAR(30),
    @p_issued_emp_id VARCHAR(10)
AS
BEGIN
    DECLARE
        @v_status VARCHAR(10);

    -- Checking if book is available 'yes'
    Select  @v_status = status_
    From books
    Where isbn_ = @p_issued_book_isbn;

    IF @v_status = 'yes'
    BEGIN
        INSERT INTO issued_status (issued_id,
		issued_member_id, 
		issued_date,
		issued_book_isbn, 
		issued_emp_id
		)
        VALUES
            (@p_issued_id, @p_issued_member_id, GETDATE(), @p_issued_book_isbn, @p_issued_emp_id);

        UPDATE books
        Set status_ = 'no'
        Where  isbn_ = @p_issued_book_isbn;

        SELECT 'Book records added successfully for book isbn : ' + @p_issued_book_isbn; -- Simulate RAISE NOTICE
    END
    ELSE
    BEGIN
        SELECT 'Sorry to inform you the book you have requested is unavailable book_isbn: ' + @p_issued_book_isbn; -- Simulate RAISE NOTICE
    END

END;

-----------execute the procedure
exec issue_book '0IS155', 'C108', '978-0-553-29698-2', 'E104' ;

       
exec issue_book 'IS156', 'C108', '978-0-375-41398-8', 'E104';

-------check the execution

-- '978-0-553-29698-2' = yes
-- '978-0-375-41398-8' = no


SELECT * FROM books
WHERE isbn_ = '978-0-375-41398-8'


SELECT * FROM books
WHERE isbn_ = '978-0-553-29698-2'

update books
set status_='yes'
WHERE isbn_ = '978-0-553-29698-2'


/*Update Book Status on Return
 20:-  Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).
*/
SELECT * FROM issued_status
WHERE issued_book_isbn = '978-0-330-25864-8';
-- IS104

SELECT * FROM books
WHERE isbn_ = '978-0-451-52994-2';

UPDATE books
SET status_ = 'no'
WHERE isbn_ = '978-0-451-52994-2';

SELECT * FROM return_status
WHERE issued_id = 'IS131';

-- Insert Statement
INSERT INTO return_status (return_id, issued_id, return_date, book_quality)
VALUES
    ('RS126', 'IS131', GETDATE(), 'Good');

-- Select Statement
SELECT *
FROM return_status
WHERE issued_id = 'IS131';

-- Stored Procedure
CREATE PROCEDURE add_return_records
    @p_return_id VARCHAR(10),
    @p_issued_id VARCHAR(10),
    @p_book_quality VARCHAR(10)
AS
BEGIN
    DECLARE
        @v_isbn VARCHAR(50),
        @v_book_name VARCHAR(80);

    -- Inserting into returns based on user input
    INSERT INTO return_status (return_id, 
	issued_id, 
	return_date, 
	book_quality
	)
    VALUES
        (@p_return_id, @p_issued_id, GETDATE(), @p_book_quality);

    SELECT
        @v_isbn = issued_book_isbn,
        @v_book_name = issued_book_name
    FROM issued_status
    WHERE issued_id = @p_issued_id;

    UPDATe books
    SET status_ = 'yes'
    WHERE isbn_ = @v_isbn;

    SELECT 'Thank you for returning the book: ' + @v_book_name; -- Simulate RAISE NOTICE

END;

--- excute the porcedure
exec add_return_records 'RS136', 'IS124', 'Good' ;

exec add_return_records 'RS144', 'IS130', 'Good' ;



 ---- test the execution

--issued_id = IS135
--isbn = '978-0-307-58837-1'

SELECT * FROM books
WHERE isbn_ = '978-0-307-58837-1';

SELECT * FROM issued_status
WHERE issued_book_isbn = '978-0-307-58837-1';

SELECT * FROM return_status
WHERE issued_id = 'IS124';








