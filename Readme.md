# Food Ordering System

This repository contains the source code and related files for a **Food Ordering System** built using Django. The system allows customers to browse and order food from restaurants, while also managing categories, customers, drivers, and discounts.

## Project Structure

- **ER Diagram.jpg**: Entity-Relationship diagram illustrating the database schema.
- **Proposal.pdf**: Initial project proposal document.
- **Report.pdf**: Final project report documenting the system's features, design, and implementation.

### Database Files

- **Files/*.sql**: SQL files used to define and populate the database.

## Getting Started

### Prerequisites

- Python 3.8+
- Django 5.0.6
- SQL Server with ODBC Driver 17 for SQL Server

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Narges-Mntzr/Food-Ordering-System.git
   ```
2. Navigate to the project directory:
   ```bash
   cd food-ordering-system/myproject
   ```
3. Install the required packages:
   ```bash
   pip install -r requirements.txt
   ```
4. Set up the database by running the SQL scripts provided in the `Files` directory.

### Running the Application

1. Apply database migrations:
   ```bash
   python manage.py migrate
   ```
2. Start the development server:
   ```bash
   python manage.py runserver
   ```

### Usage

- Access the application at `http://localhost:8000/`.
- The admin panel is accessible at `http://localhost:8000/admin/`.
