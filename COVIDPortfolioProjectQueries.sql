select *
from PortfolioProject..CovidDeaths
where continent is not null
order by 3,4

--select *
--from PortfolioProject..CovidVaccinations
--order by 3,4

Select Location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
order by 1,2



-- Total Cases vs Total Deaths
-- Likelihood of dying if you contract covid in the US

Select Location, date,total_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where location = 'United States'
and total_deaths is not null
order by 1,2

-- Total Cases vs Population
-- Shows what percentage contracted Covid

Select Location, date,total_cases, Population,(total_cases/population)*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
--where location = 'United States'
where total_cases is not null
order by 1,2


-- Looking at countries with the highest infection rate compared to population

Select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX(total_cases/population)*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
--where location = 'United States'
group by Location, Population
order by PercentPopulationInfected desc


-- breaking down deaths by continent

Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where location = 'United States'
where continent is not null
group by continent
order by TotalDeathCount desc


-- Showing continents with the highest death count per population

Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where location = 'United States'
where continent is not null
group by continent
order by TotalDeathCount desc


-- GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
--where location = 'United States'
where continent is not null
--group by date
order by 1,2


-- Looking at Total Population vs Vaccinations


With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.Location,
dea.Date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on  dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
from PopvsVac

-- TEMP TABLE

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.Location,
dea.Date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	On  dea.location = vac.location
	and dea.date = vac.date
	--where dea.continent is not null
order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
from #PercentPopulationVaccinated



-- Creating view to store data for later visualization


Create View PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.Location,
dea.Date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	On  dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3

select *
from PercentPopulationVaccinated

Create view DeathCountPerContinent as
Select continent, MAX(Cast(total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths
--where location = 'United States'
where continent is not null
group by continent

select *
from DeathCountPerContinent

Create view InfectionRatesComparedToPopulation as
Select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX(total_cases/population)*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
--where location = 'United States'
group by Location, Population

Create view  PercentPopulationIsInfected as
Select Location, date,total_cases, Population,(total_cases/population)*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
--where location = 'United States'
where total_cases is not null

Create view LikelihoodOfDyingIfInfectedByCountry as
Select Location, date,total_cases, total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where total_deaths is not null
