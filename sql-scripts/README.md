# Initial Database Setup

To set up the database tables, procedures, and insert dummy records for the web application, follow the instructions below.

## Prerequisites

1. **Oracle Database**: Ensure you have Oracle Database installed or Oracle cloud Database running.
2. **SQL*Plus or SQL Developer**: You need either SQL*Plus or SQL Developer to run the script.

## Running the Database Setup Script

**1. Clone the Repository:**

- `git clone https://github.com/Pal-96/ManageMed.git`

- `cd ManageMed/sql-scripts/`

**2. If you have:**
- SQL*Plus: Execute below command

    `sqlplus username/password@hostname:port/service_name`
- SQL Developer: Open SQL Developer and connect to your Oracle Database instance.

**3. Run the script:**
- SQL*Plus: `@path/to/repo/script/initial-db-setup.sql`
- SQL Developer: Open the **initial-db-setup.sql** file from the sql-scripts directory, and click the "Run Script" button (usually a green play button with a note).

**4. Verify the Setup:**

Check the database to ensure that the tables, procedures, and dummy records have been created successfully.


# Logical Data Model

![Logical](https://github.com/user-attachments/assets/ba5b794f-d8b3-4e0b-bc69-957ac49b05d6)


# Relational Data Model

![Relational_1](https://github.com/user-attachments/assets/b37e908f-8a86-46ad-b653-f79fe322c46e)
