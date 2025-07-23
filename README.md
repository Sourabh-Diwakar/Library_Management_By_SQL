# Library Management System using SQL

![SQL Project GIF](https://media.giphy.com/media/iIGT8Y1rOYhBpdHh1C/giphy.gif)

## Overview

This project implements a **Library Management System using SQL**, enabling efficient tracking and management of:

- Books
- Members
- Employees
- Book Issues and Returns
- Branches

using relational databases and advanced SQL operations.

---

##  Key Features

✅ Create and manage library branches, employees, books, and members  
✅ Track book issuance and returns with relational integrity  
✅ Calculate rental income by category and generate branch performance reports  
✅ Stored procedures for automating book issuing and return status updates  
✅ Practical SQL tasks to handle real-life library operations

---

## Project Structure

- **`library_management.sql`**: Core database schema, table creation, and seed data.
- **`projects task.sql`**: Practical SQL queries and stored procedures:
    - Retrieve books by employee/category
    - Delete/Update records
    - Calculate rental income
    - Identify overdue books
    - Branch performance reporting
    - Stored procedures for book issuing and returns
- **`Tasks.md`**: Clean reference list of tasks executed within this project.

---

##  Tables Created

- `branch`
- `employe`
- `books`
- `members`
- `issued_status`
- `return_status`

with **foreign key constraints ensuring relational integrity**.

---

##  Tech Stack

- **SQL Server** (compatible with MySQL/PostgreSQL with minor adjustments)
- **SQL (DDL, DML, Stored Procedures)**
- **Relational Database Design & Normalization**

---

##  Sample Tasks Performed

✅ Retrieve all books issued by a specific employee  
✅ Retrieve all books in a specific category  
✅ Track and manage issued/returned books  
✅ Identify members who issued multiple books  
✅ Generate **branch performance reports** (books issued, returned, revenue)  
✅ Identify **members with overdue books** (>30 days)  
✅ Create **summary tables** and **dynamic reports**  
✅ Automate book issue/return updates with **stored procedures**

---

##  Key Learning Outcomes

✅ Master relational database design for management systems  
✅ Apply advanced SQL (JOINS, GROUP BY, HAVING, CASE) to real-life scenarios  
✅ Practice stored procedure creation for database automation  
✅ Learn to build **report-ready queries** for insights and business decisions


