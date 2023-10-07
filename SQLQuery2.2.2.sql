


-----select data that we are going to be using

select *
from [portfolio project].[dbo].['owid-covid-deaths-data$']
where continent is not null
order by 3,4



--Looking at tota_cases vs total_deats.
--- Show likelihood of dying if you contarct covid in your country.
---Shows what percentage of populaition got covid

select [location]
      ,[date]
      ,[population]
      ,[total_cases]
      --,[new_cases]
      ,[total_deaths]
	  --,[new_deaths]
	  ,(total_deaths/total_cases)*100 as pupalaitionspercentage
from [portfolio project].[dbo].['owid-covid-deaths-data$']
--where location like 'morocco'

order by 1,2



--ALTER TABLE [portfolio project].[dbo].['owid-covid-deaths-data$']
--ALTER COLUMN total_cases float; 
--ALTER TABLE [portfolio project].[dbo].['owid-covid-deaths-data$']
--ALTER column total_deaths float;


--looking at countries with heighst infection rate compared to population 
--- ???? ???????? ????? ??? ?????? 


select [location]
      ,[population]
      ,max([total_cases]) as heighsetinfactioncount
	  ,max(([total_cases]/[population]))*100 as percentpopulationinfacted

	  
from [portfolio project].[dbo].['owid-covid-deaths-data$']
--where location like 'morocco'
group by [location]
      ,[population]
order by percentpopulationinfacted desc

-- look at countries with heighest death count by populaition

select [location]

    ,max(total_deaths) as totaldeathscount 

from [portfolio project].[dbo].['owid-covid-deaths-data$']
where  continent is not null
group by [location]
      
order by totaldeathscount desc

------ LEATS BREAK THINGS DOWN BY CONTINENTS
--- SHAWING CONTINENTS WITH HEIGHEST DEATHS PER POPULATION

select [continent]

    ,max(cast(total_deaths as int )) as totaldeathscount 

from [portfolio project].[dbo].['owid-covid-deaths-data$']
where  continent is not null
group by [continent]
      
order by totaldeathscount desc

----- GLOBAL NUMBERS
--

--SELECT date 

--from [portfolio project].[dbo].['owid-covid-deaths-data$']
--where continent  is not null
--group by date 
--order by 1,2

 SELECT
   date,
   sum(new_deaths) as newdeaths,
   sum(new_cases)as newcases,
   CASE
      WHEN sum(new_cases) <> 0 THEN sum(new_deaths) / sum(new_cases) * 100
      ELSE null
   END AS percentagedeaths
FROM [portfolio project].[dbo].['owid-covid-deaths-data$']
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date, sum(new_cases);

 

--new_vaccinations is not null-looking at total population vs vaccination 

with PopVsVac ( continent, location, date, population, new_vaccinations, rollingpeoplevaccinated)
as 
(

SELECT  DEA.continent, DEA.location, DEA.date, DEA.population , vac.new_vaccinations
   ,SUM(CAST(VAC.new_vaccinations AS FLOAT )) over (partition by DEA.location order by DEA.location, DEA.date ) as rollingpeoplevaccinated
FROM [portfolio project].[dbo].['owid-covid-deaths-data$'] DEA
JOIN [portfolio project].[dbo].['owid-covid-vaccinations-data'] VAC
   ON DEA.LOCATION = VAC.LOCATION
   AND DEA.DATE = VAC.DATE
where DEA.CONTINENT  IS NOT NULL
--order by 2,3 
)

select *, (rollingpeoplevaccinated/population)*100 as percentpopulationvaccinated
from PopVsVac
Where location like 'morocco'


---TEMP TABLE
drop table if exists #percentpopulationvaccinated
CREATE TABLE #percentpopulationvaccinated
(
continent nvarchar(255),
location nvarchar (255),
date datetime ,
population numeric ,
new_vaccinations numeric ,
rollingpeoplevaccinated numeric 
)


insert into #percentpopulationvaccinated
SELECT  DEA.continent, DEA.location, DEA.date, DEA.population , vac.new_vaccinations
   ,SUM(CAST(VAC.new_vaccinations AS FLOAT )) over (partition by DEA.location order by DEA.location, DEA.date ) as rollingpeoplevaccinated
FROM [portfolio project].[dbo].['owid-covid-deaths-data$'] DEA
JOIN [portfolio project].[dbo].['owid-covid-vaccinations-data'] VAC
   ON DEA.LOCATION = VAC.LOCATION
   AND DEA.DATE = VAC.DATE
--where DEA.CONTINENT  IS NOT NULL
--order by 2,3

select *, (rollingpeoplevaccinated/population)*100 as percentpopulationvaccinated
from #percentpopulationvaccinated

--creating view to store data for later visualazations
create view percentpopulationvaccinated as 

SELECT  DEA.continent, DEA.location, DEA.date, DEA.population , vac.new_vaccinations
   ,SUM(CAST(VAC.new_vaccinations AS FLOAT )) over (partition by DEA.location order by DEA.location, DEA.date ) as rollingpeoplevaccinated
FROM [portfolio project].[dbo].['owid-covid-deaths-data$'] DEA
JOIN [portfolio project].[dbo].['owid-covid-vaccinations-data'] VAC
   ON DEA.LOCATION = VAC.LOCATION
   AND DEA.DATE = VAC.DATE
where DEA.CONTINENT  IS NOT NULL
--order by 2,3

select *
from percentpopulationvaccinated






