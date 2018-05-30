# final-project

## Project Description

1. We will be working with datasets that display information about an NBA season including game statistics, player names, etc. The data was sourced from and collected through a .csv file on a website called **MySportsFeeds**.

2. Our target audience is sports enthusiasts (specifically NBA) and potentially sports analysts, or recruiters, who are interested in a specific team. The data will give the statistic of the number of NBA players born in each state, filtered by team. Another piece of data will show the colleges that the number of players attended, filtered by team.

3. Question 1 - How many professional basketball players were born in each state? Filter by team.

   Question 2 - What is the rank of each NBA player? Who are the top 3 2017-2018 NBA players?

   Question 3 - How many players in the NBA attended each college? Filter by team.

   Question 4 - Which colleges produced the most amount of active NBA players?

## Technical Description

1. We are getting our data from MySportsFeeds and the data is in the form of a .csv file.

2. We think we are going to have to filter down the data for sure. One weird thing is that in the first .csv file we acquired, there are weird hashtags in certain rows/cols so we will probably have to reformat this. Another weird thing about the data is that coaches are included with the players, so we will have to filter out the coaches to make an accurate rank of each NBA player. Finally, we will also need to figure out what certain columns signify because it may not be entirely clear.

3. We will be using the **_plotly_** library to visualize data on maps. We also used the **_DT_** library to store information in a data table. Besides this, I believe all other libraries we will use will be standard for this project.
