# COVID-19 Data Analysis with SQL

This project contains SQL scripts for analyzing COVID-19 data using two primary datasets: `coviddeaths$` and `covidvacc`. It focuses on key metrics like infection rates, death counts, and vaccination rollouts across different countries and continents.

##  Key Features

- Total cases vs population analysis
- Infection and death rate breakdown by country
- Highest infection and death counts globally
- Global summaries with calculated death percentages
- Vaccination progress using:
  - Window functions (rolling counts)
  - CTEs for cleaner logic
  - Temp tables for modular data handling
  - Views for future data visualization

##  Files Included

- `covid_analysis.sql` — The main SQL script containing all queries and logic
- (Optional) `README.md` — Project overview and usage

##  Technologies Used

- Microsoft SQL Server / T-SQL
- Window functions
- CTEs
- Temp Tables
- Views

## 📈 Dataset Source

Data adapted from [Our World in Data](https://ourworldindata.org/coronavirus).

## 🚀 Getting Started

1. Load the `coviddeaths$` and `covidvacc` tables into your SQL Server instance.
2. Run the script step-by-step to explore and analyze the data.
3. Use the final views or temp tables for data visualization or BI tools like Power BI or Tableau.

---

**Note**: Make sure your dataset column names match the ones used in the script (`total_cases`, `new_tests`, `population`, etc.)


