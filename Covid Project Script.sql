select * from dbo.coviddeaths$
select * from covidvacc

select  country,date, total_cases,new_tests, population
from coviddeaths$
order by 1,2 desc


-- Looking at Total Cases Vs Population

select  country,date, total_cases,population, (total_cases/population)*100 as PercentagepopulationInfected
from coviddeaths$
where country like '%states%'
order by 1,2 

-- Looking at countries with highest infection rates 

select  country,population,max(total_cases)  as HighInfectionCount,max((total_cases/population))*100 as PercentagepopulationInfected
from coviddeaths$
group by country,population
order by PercentagepopulationInfected desc

-- showing countries with highest death count per population

select  country,max(total_deaths)  as totaldeathcount
from coviddeaths$
where continent is not null
group by country
order by totaldeathcount desc

select  country,max(total_deaths)  as TotalDeathCount
from coviddeaths$
where continent is null
group by country
order by TotalDeathCount desc

---global numbers

SELECT 
    SUM(ISNULL(new_cases, 0)) AS total_cases,
    SUM(ISNULL(new_deaths, 0)) AS totaldeaths,
    CASE 
        WHEN SUM(ISNULL(new_cases, 0)) > 0 THEN 
            SUM(ISNULL(new_deaths, 0)) * 100.0 / SUM(ISNULL(new_cases, 0))
        ELSE 0 
    END AS DeathPercentage
FROM 
    coviddeaths$
WHERE 
    continent IS NOT NULL

ORDER BY 
    1,2;

--Total population vs vaccinations
select * from coviddeaths$

select dt.continent ,dt.country,dt.date,vac.population,vac.new_vaccinations
,sum(convert(float,vac.new_vaccinations))
over 
(partition by dt.country order by dt.country,dt.date) as rollingpeoplevaccinated
from coviddeaths$ dt
join covidvacc as vac
on dt.country=vac.country
and dt.date=vac.date
where dt.continent is not null
order by 2,3

--- Use CTE
----Total population vs vaccinations
with PopvsVac (continent,country,date,population,new_vaccinations, rollingpeoplevaccinated)
as
(
select dt.continent ,dt.country,dt.date,vac.population,vac.new_vaccinations
,sum(convert(float,vac.new_vaccinations))
over 
(partition by dt.country order by dt.country,dt.date) as rollingpeoplevaccinated
from coviddeaths$ dt
join covidvacc as vac
on dt.country=vac.country
and dt.date=vac.date
where dt.continent is not null
--order by 2,3
)
select * , (rollingpeoplevaccinated/population)*100
from PopvsVac as populationwisevaccinatedpeople


---Temp Table
drop table if exists #PercentPopultionVaccinated
Create Table #PercentPopultionVaccinated
(
continent nvarchar(255),
country nvarchar(255),
Date datetime,
population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into #PercentPopultionVaccinated
select dt.continent ,dt.country,dt.date,vac.population,vac.new_vaccinations
,sum(convert(float,vac.new_vaccinations))
over 
(partition by dt.country order by dt.country,dt.date) as rollingpeoplevaccinated
from coviddeaths$ dt
join covidvacc as vac
on dt.country=vac.country
and dt.date=vac.date
--where dt.continent is not null
--order by 2,3


--Creating View to store data for later visualization

Create View PercentPopulationVaccinated as
select dt.continent ,dt.country,dt.date,vac.population,vac.new_vaccinations
,sum(convert(float,vac.new_vaccinations))
over 
(partition by dt.country order by dt.country,dt.date) as rollingpeoplevaccinated
from coviddeaths$ dt
join covidvacc as vac
on dt.country=vac.country
and dt.date=vac.date
where dt.continent is not null
