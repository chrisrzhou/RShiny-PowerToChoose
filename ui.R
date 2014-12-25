shinyUI(fluidPage(
    tags$head(tags$link(rel="stylesheet", type="text/css", href="app.css")),
    
    titlePanel("Powertochoose Datavis"),
    
    sidebarLayout(
        sidebarPanel(
            p(class="text-small", "by chrisrzhou",
              a(href="https://github.com/chrisrzhou", target="_blank", icon("github")),
              a(href="http://bl.ocks.org/chrisrzhou", target="_blank", icon("th")),
              a(href="https://www.linkedin.com/in/chrisrzhou", target="_blank", icon("linkedin"))),
            hr(),
            p(class="text-small", "Data visualizations on market rankings of electricity products and prices in the ERCOT electricity market.  All data is derived from the actual PUC website: ",
              a(href="http://www.powertochoose.org", target="_blank", "www.powertochoose.org")),
            hr(),
            
            h3("Market Filters"),
            selectInput(inputId="tdu", label="Select TDU:", choices=choices$tdus, selected=choices$tdus[[1]]),
            selectInput(inputId="usage", label="Select Usage:", choices=choices$usage, selected=choices$usage[[2]]),
            checkboxGroupInput(inputId="rate_type", label="Choose Rate Types:", choices=choices$rate_types, selected=choices$rate_types[[1]]),
            hr(),
            
            h3("REP Filters"),
            selectInput(inputId="rep1", label="Select REP 1:", choices=choices$reps, selected=choices$reps[[1]]),
            selectInput(inputId="rep2", label="Select REP 2:", choices=choices$reps, selected=choices$reps[[2]]),
            selectInput(inputId="rep3", label="Select REP 3:", choices=choices$reps, selected=choices$reps[[3]]),
            p("(REP: Retail Electricity Provider)"),
            hr(),
            
            h3("Additional Filters"),
            checkboxGroupInput(inputId="prepaid", label="Choose Prepaid:", choices=choices$booleans, selected=choices$booleans),
            checkboxGroupInput(inputId="tou", label="Choose Time-of-Use:", choices=choices$booleans, selected=choices$booleans),
            checkboxGroupInput(inputId="promotion", label="Choose Promotion:", choices=choices$booleans, selected=choices$booleans),
            sliderInput(inputId="term_length_min", label="Term Length:", min=0, max=36, value=0),
            sliderInput(inputId="term_length_max", label="", min=0, max=36, value=36),
            sliderInput(inputId="renewable_min", label="Renewable:", min=0, max=100, value=0),
            sliderInput(inputId="renewable_max", label="", min=0, max=100, value=100),
            hr(),
            
            downloadButton(outputId = "download_data", label="Download Data"),
            width=3
        ),
        
        mainPanel(
            tabsetPanel(
                tabPanel("Rankings",
                         h2("Rankings"),
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
                         hr(),
                         
                         h3("Datatable"),
                         p(class="text-small", "This section provides a search datatable similar to that found on",
                           a(href="http://www.powertochoose.org", target="_blank", "www.powertochoose.org")),
                         dataTableOutput("datatable"),
                         hr()
                )
            ),
            width=9
        )
    )
))