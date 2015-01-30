# Power To Choose Explorer
AWS EC2 link: <a href="http://shiny.vis.datanaut.io/PowerToChoose/" target="_blank">http://shiny.vis.datanaut.io/PowerToChoose/</a>

------

## About
<a href="http://www.powertochoose.org/" target="_blank">Power to Choose</a> is a consumer choice website set up by the <a href="https://www.puc.texas.gov/" target="_blank">PUC</a> to provide customers to compare offers and choose from various electricity plans in Texas.

The data is received from the CSV download URL and is parsed and reshaped in R using the amazing R package `dplyr`.

Throughout the application, the user is empowered with selection widgets to zoom in on data exploration of the dataset.  This site is designed with analysts in mind, and provides summary of information that is otherwise difficult to obtain by referring to the original website, for example:

- *Finding the top 10 ranked companies*
- *Observing the trends/impacts made by specific companies*
- *Comparing companies against specific companies*

------

## Visualizations
- **Rankings:** This section is focused on company rankings by lowest electricity prices.  There is a summary that displays quick statistics of the dataset (*Best, Top 10, Top 30, Mean*).
- **Market:** This section is focused on the overall market summaries of products and prices.  The first visualization is a histogram with an adjustable binwidth, and the second visualization expands the information by providing details of the term length of the contract plans.
- **Data:** This section provides a search datatable similar to that found on Powertochoose.org.

------

## Other notes
- Use the selection widgets to redefine the market conditions on the rankings to be determined, and to zone-in on specific companies by using the `REP Filters`.

- Download the "cleaned" and filtered dataset from the `Download Data` button at the bottom of the page.

- The `ggvis` library is great for R visualization but has some big limitations due to it being in its infant stages.  It is somewhat difficult to handle dataframes with no data, and this causes sometimes abrutly terminates the app.  The syntax is overall beautiful but a little clunky with slightly detailed functionality.  Unfortunately, this is the current limitation with designing apps with `ggvis` but I'm definitely excited in seeing this library mature as along with `dplyr`, I think it is moving in for even greater features!  Great thanks to Hadley for all the work and tools he's built for the R community.

- This project/application is not affiliated with any electricity company nor the PUC.  The work is intended as a showcase of R Shiny data visualization capabilities.

------

## Resources
- <a href="http://chrisrzhou.datanaut.io/" target="_blank">Homepage</a>
- <a href="http://shiny.vis.datanaut.io/" target="_blank">R Shiny Projects</a>
- <a href="https://github.com/chrisrzhou/RShiny-PowerToChoose" target="_blank">Github Project</a>
- <a href="http://www.powertochoose.org/" target="_blank">Power to Choose</a>
- <a href="https://www.puc.texas.gov/" target="_blank">PUC</a>
- <a href="http://www.ercot.com/" target="_blank">ERCOT</a>
