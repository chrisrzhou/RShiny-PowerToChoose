shinyUI(fluidPage(
    tags$head(tags$link(rel="stylesheet", type="text/css", href="app.css")),
    
    titlePanel("Powertochoose Explorer"),
    
    sidebarLayout(
        sidebarPanel(
            p(class="text-small",
              a(href="http://chrisrzhou.datanaut.io/", target="_blank", "by chrisrzhou"),
              a(href="https://github.com/chrisrzhou/RShiny-PowerToChoose", target="_blank", icon("github")), " | ",
              a(href="http://bl.ocks.org/chrisrzhou", target="_blank", icon("cubes")), " | ",
              a(href="https://www.linkedin.com/in/chrisrzhou", target="_blank", icon("linkedin"))),
            hr(),
            p(class="text-small", "Data visualizations on market rankings of electricity products and prices in the ERCOT electricity market.  All data is derived from the actual PUC website: ",
              a(href="http://www.powertochoose.org", target="_blank", "www.powertochoose.org")),
            hr(),
            
            selectInput(inputId="tdu", label="Select TDU:", choices=choices$tdus, selected=choices$tdus[[1]]),
            selectInput(inputId="usage", label=" Select Usage:", choices=choices$usage, selected=choices$usage[[2]]),
            checkboxGroupInput(inputId="rate_type", label="Choose Rate Types:", choices=choices$rate_types, selected=choices$rate_types[[1]]),
            hr(),
            
            selectInput(inputId="rep1", label="REP 1:", choices=choices$reps, selected=choices$reps[[1]]),
            selectInput(inputId="rep2", label="REP 2:", choices=choices$reps, selected=choices$reps[[2]]),
            selectInput(inputId="rep3", label="REP 3:", choices=choices$reps, selected=choices$reps[[3]]),
            p(class="text-small", "(REP: Retail Electricity Provider)"),
            hr(),
            
            checkboxGroupInput(inputId="prepaid", label="Choose Prepaid:", choices=choices$booleans, selected=choices$booleans),
            checkboxGroupInput(inputId="tou", label="Choose Time-of-Use:", choices=choices$booleans, selected=choices$booleans),
            checkboxGroupInput(inputId="promotion", label="Choose Promotion:", choices=choices$booleans, selected=choices$booleans),
            sliderInput(inputId="term_lengths", label="Filter Term Length:", min=0, max=36, value=c(0, 36)),
            sliderInput(inputId="renewables", label="Filter Renewable:", min=0, max=100, value=c(0, 100)),
            hr(),
            
            downloadButton(outputId = "download_data", label="Download Data"),
            width=3
        ),
        
        mainPanel(
            tabsetPanel(
                tabPanel("Rankings",
                         h2("Rankings"),
                         p(class="text-small", "This section visualizes the rankings of Retail Electric Providers in ERCOT,
                           providing details on the specific energy plans and prices against the market.  
                           A summary section is provided to help determine quick insights on the key observations in the market."),
                         hr(),
                         
                         h3("Summary"),
                         htmlOutput("rankingSummary"),
                         hr(),
                         
                         h3("Rankings Plot"),
                         p(class="text-small", "Rankings of products at a given price range and associated variables. "),
                         ggvisOutput("rankings_plot"),
                         hr()
                ),
                tabPanel("Market",
                         h2("Market"),
                         p(class="text-small", "This section zooms in on the aggregate visualization of the given market (histogram and scatterplot).  
                           Interact with the selection widgets to redefine market definitions and conditions."),
                         hr(),
                         
                         h3("Market Histogram"),
                         p(class="text-small", "Histogram of products at a given price range and binwidth, highlighting selected REPs in the market."),
                         ggvisOutput("market_histogram"),
                         div(class="row offset1", uiOutput("market_histogram_slider")),
                         hr(),
                         
                         h3("Market scatterplot"),
                         p(class="text-small", "Scatterplot of products at a given price range, highlighting selected REPs in the market."),
                         ggvisOutput("market_scatterplot"),
                         hr()
                ),
                tabPanel("Data",
                         h2("Data"),
                         p(class="text-small", "This section provides a search datatable similar to that found on",
                           a(href="http://www.powertochoose.org", target="_blank", "www.powertochoose.org")),
                         hr(),
                         
                         h3("Datatable"),
                         dataTableOutput("datatable"),
                         hr()
                )
            ),
            width=9
        )
    )
))
