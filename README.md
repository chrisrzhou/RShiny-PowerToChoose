# Power To Choose Datavis

## About
[Power to Choose](http://www.powertochoose.org/) is a consumer choice website set up by the [PUC](https://www.puc.texas.gov/) to provide customers to compare offers and choose from various electricity plans in Texas.

This is a R Shiny data visualization project based on the information made available on powertochoose.org.  You can preview the app at this [AWS EC2 instance](http://ec2-54-183-164-175.us-west-1.compute.amazonaws.com:3838/PowerToChoose/).


The data is received from the CSV download URL and is parsed and reshaped in R using the amazing R package `dplyr`.

Throughout the application, the user is empowered with selection widgets to zoom in on data exploration of the dataset.  This site is designed with analysts in mind, and provides summary of information that is otherwise difficult to obtain by referring to the original website, for example:

- Finding the top 10 ranked companies
- Observing the trends/impacts made by specific companies
- Comparing companies against specific companies


## Visualizations:
- **Rankings:** This section is focused on company rankings by lowest electricity prices.  There is a summary that displays quick statistics of the dataset (*Best, Top 10, Top 30, Mean*).
- **Market:** This section is focused on the overall market summaries of products and prices.  The first visualization is a histogram with an adjustable binwidth, and the second visualization expands the information by providing details of the term length of the contract plans.
- **Data:** This section provides a search datatable similar to that found on [Power to Choose](http://www.powertochoose.org/)


## Other notes:
- Use the selection widgets to redefine the market conditions on the rankings to be determined, and to zone-in on specific companies by using the `REP Filters`.

- Download the "cleaned" and filtered dataset from the `Download Data` button at the bottom of the page.

- The `ggvis` library is great for R visualization but has some big limitations due to it being in its infant stages.  It is somewhat difficult to handle dataframes with no data, and this causes the shiny app to terminate.  The syntax is beautiful but a little clunky with some fairly commonly used requests.  Unfortunately, this is the current limitation with designing apps with `ggvis` but I'm definitely excited in seeing this library mature as along with `dplyr`, I think it is moving in for even greater features!  Great thanks to Hadley for all the work and tools he's built for the R community.

- This project/application is not affiliated with any electricity company nor the PUC.  The work is intended as a showcase of R Shiny data visualization capabilities.


## Resources
- [Power to Choose](http://www.powertochoose.org/)
- [PUC](https://www.puc.texas.gov/)
- [ERCOT](http://www.ercot.com/)
- [dplyr](http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)