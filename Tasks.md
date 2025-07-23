## Task

-- 1: - Retrieve All Books Issued by a Specific Employee
--Objective: Select all books issued by the employee with emp_id = 'E101'

-- 2. Retrieve All Books in a Specific Category  ='classic' :

--3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table

-- 4: List Members Who Have Issued More Than One Book 
 -- Objective: Use GROUP BY to find members who have issued more than one book.

--5. Create a New Book Record 
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

-- 6: Update an Existing Member's Address = '125 Main St'  with member_id = 'C101';

 -- 7: Find Total Rental Income by Category_:

--8: -List Employees with Their Branch Manager's Name and their branch details:

--9: Create Summary Tables: Used CTAS to generate new tables based on query results 
        --each book and total book_issued_cnt :
-- 10. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:

-- 11: Retrieve the List of Books Not Yet Returned

--12 : -  List Members Who Registered in the Last 180 Days:
--13 :-write a new query to find the active_members containing members who have issued at least one book in the last 2 months.

--14 :- Find Employees with the Most Book Issues Processed Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.

-- 15:-  Branch Performance Report  Write a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.

-- 16 : -  Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's_id, member's name, book title, issue date, and days overdue.


--19: SCreate a stored procedure to manage the status of books in a library system. 
Description: Write a stored procedure that updates the status of a book in the library based on its issuance. The procedure should function as follows: The stored procedure should take the book_id as an input parameter. The procedure should first check if the book is available (status = 'yes'). If the book is available, it should be issued, and the status in the books table should be updated to 'no'. If the book is not available (status = 'no'), the procedure should return an error message indicating that the book is currently not available.
--20: -  Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).



