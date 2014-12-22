# Shiny UI code

shinyUI(fluidPage(
    tags$head(
        tags$link(rel="stylesheet", type="text/css", href="app.css")
    ),
    tags$link(
        rel = "stylesheet", 
        href="https://fonts.googleapis.com/css?family=Roboto+Slab"
    ),
    
    titlePanel(
        div(class="header",
            h1("PTC Shiny App"),
            p(class="text-small",
              a(href="http://www.powertochoose.org", target="_blank", "www.powertochoose.org"),
              "data visualizations created by ",
              a(href="https://www.linkedin.com/in/chrisrzhou", target="_blank", "Chris Zhou"),
              "with ",
              a(href="http://shiny.rstudio.com/", target="_blank", "R Shiny"), ",",
              a(href="http://ggvis.rstudio.com/", target="_blank", "ggvis"),
              ", and the amazing dataframe library",
              a(href="http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html", target="_blank", "dplyr")
            )
        ),
        windowTitle = "PTC Shiny App"
    ),
    
    sidebarLayout(
        sidebarPanel(
            h3("REP FILTERS"),
            selectInput("rep1", "Select REP 1:", REPS, REPS[[1]]),
            selectInput("rep2", "Select REP 2:", REPS, REPS[[2]]),
            selectInput("rep3", "Select REP 3:", REPS, REPS[[3]]),
            hr(),
            h3("MAIN FILTERS"),
            selectInput("tdu", "Select TDU:", TDUS, TDUS[[1]]),
            selectInput("usage", "Select Usage:", USAGE, "KWH1000"),
            checkboxGroupInput("rate_type", "Choose Rate Types:", RATE_TYPES, RATE_TYPES[[1]]),
            hr(),
            h3("ADDITIONAL FILTERS"),
            checkboxGroupInput("prepaid", "Choose Prepaid:", BOOLEANS, BOOLEANS),
            checkboxGroupInput("tou", "Choose Time-of-Use:", BOOLEANS, BOOLEANS),
            checkboxGroupInput("promotion", "Choose Promotion:", BOOLEANS, BOOLEANS),
            sliderInput("term_length_min", "Term Length:", min=0, max=36, value=0),
            sliderInput("term_length_max", "", min=0, max=36, value=36),
            sliderInput("renewable_min", "Renewable:", min=0, max=100, value=0),
            sliderInput("renewable_max", "", min=0, max=100, value=100),
            hr(),
            downloadButton("downloadData", "Download Data")
        ),
        
        mainPanel(
            tabsetPanel(
                tabPanel("Rankings",
                         h2("Rankings"),
                         hr(),
                         h3("SUMMARY"),
                         htmlOutput("rankingSummary"),
                         hr(),
                         h3("PLOT"),
                         p("Rankings of products at a given price range and associated variables. "),
                         ggvisOutput("rankings_plot"),
                         hr()
                ),
                tabPanel("Market",
                         h2("Market"),
                         hr(),
                         h3("HISTOGRAM"),
                         p("Histogram of products at a given price range and binwidth, highlighting selected REPs in the market."),
                         ggvisOutput("market_histogram"),
                         div(class="row offset1", uiOutput("market_histogram_slider")),
                         hr(),
                         h3("SCATTER PLOT"),
                         p("Scatterplot of products at a given price range, highlighting selected REPs in the market."),
                         ggvisOutput("market_scatterplot"),
                         hr()
                ),
                tabPanel("Data",
                         h2("Data"),
                         hr(),
                         h3("SEARCH TABLE"),
                         p("This section provides a searcheable datatable similar to that found on",
                           a(href="http://www.powertochoose.org", target="_blank", "www.powertochoose.org")),
                         dataTableOutput("datatable"),
                         hr()
                )
            )
        )
    )
))