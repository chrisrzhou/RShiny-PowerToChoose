# Shiny server code

shinyServer(function(input, output) {
    
    # Reactive resources
    resource.df = reactive({
        df_base$PRICE = df_base[, input$usage]  # track selected price usage column
        
        df = df_base %>%
            filter(PRICE <= 25,
                   TDU == input$tdu,
                   RATE_TYPE %in% input$rate_type,
                   PREPAID %in% input$prepaid,
                   TOU %in% input$tou,
                   PROMOTION %in% input$promotion,
                   TERM_LENGTH >= input$term_length_min,
                   TERM_LENGTH <= input$term_length_max,
                   RENEWABLE >= input$renewable_min,
                   RENEWABLE <= input$renewable_max) %>%
            mutate(RANK = min_rank(PRICE),
                   REP_COLOR = ifelse(REP == input$rep1, REP_COLOR_MAP[["REP1"]],
                                      ifelse(REP == input$rep2, REP_COLOR_MAP[["REP2"]],
                                             ifelse(REP == input$rep3, REP_COLOR_MAP[["REP3"]],
                                                    REP_COLOR_MAP[["REST"]])))) %>%
            arrange(RANK)
        return(df)
    })
    
    resource.header = reactive({
        header = sprintf("%s %s Market", input$tdu, input$usage)
        return(header)
    })
    
    # Server outputs
    output$datatable = renderDataTable({
        df = resource.df() %>%
            select(-c(EFL_URL, REP_COLOR))
        return(df)
    }, options = list(pageLength=10))
    
    output$downloadData = downloadHandler(
        filename = function() {
            sprintf("ptc_data_%s.csv", Sys.Date())
        },
        content = function(filename) {
            df = resource.df()
            write.csv(df, filename, row.names=FALSE)
        }
    )
    
    output$rankingSummary = renderUI({
        df = resource.df()
        df_best = df %>% filter(RANK == 1)
        df_top10 = df %>% filter(RANK <= 10)
        df_top30 = df %>% filter(RANK <= 30)
        summary = HTML(
            sprintf("
                    <b>BEST:</b> %sc/kWh <small><i>(%s)</i></small><br />
                    <b>TOP 10:</b> %sc/kWh<br />
                    <b>TOP 30:</b> %sc/kWh<br />
                    <b>MEAN:</b> %sc/kWh <small><i>(%s products)</i></small><br /><br />
                    <b>TOP 10 REPS:</b> <small>%s</small><br />
                    ",
                    min(df_best$PRICE), paste(df_best$PRODUCT, collapse=", "),
                    max(df_top10$PRICE),
                    max(df_top30$PRICE),
                    round(mean(df$PRICE), 1),  nrow(df %>% filter(PRICE < mean(PRICE))),
                    paste(df_top10$REP, collapse=", "))
        )
        return(summary)
    })
    
    
    # ggvis tooltip helper
    tooltip_helper = function(data) {
        sprintf("<b class='text-warning'><i>%s:</i></b><br />
                    <small>                    
                    <b>REP:</b> %s<br />
                    <b>RANK:</b> #%s<br />
                    <b>PRICE:</b> %sc/kWh<br />
                    <b>TERM:</b> %sM<br />
                    <b>PROMOTION:</b> %s<br />
                    </small>",
                resource.df()$PRODUCT[resource.df()$ID == data$ID],
                resource.df()$REP[resource.df()$ID == data$ID],
                resource.df()$RANK[resource.df()$ID == data$ID],
                resource.df()$PRICE[resource.df()$ID == data$ID],
                resource.df()$TERM_LENGTH[resource.df()$ID == data$ID],
                resource.df()$PROMOTION[resource.df()$ID == data$ID])
    }
    
    
    # ggvis outputs
    
    resource.df %>% 
        ggvis(x=~PRICE, y=~REP, size=~TERM_LENGTH, fill:=~REP_COLOR, stroke="lightsteelblue", key:=~ID) %>% 
        layer_points() %>%
        add_axis("x", subdivide=4) %>%
        add_axis("y", title="") %>%
        hide_legend("stroke") %>%
        add_tooltip(tooltip_helper, "hover") %>%
        bind_shiny("rankings_plot")
    
    resource.df %>% 
        ggvis(x=~PRICE, fill:=~REP_COLOR, stroke="lightsteelblue") %>% 
        group_by(REP_COLOR) %>%
        layer_histograms(width=input_slider(label="Binwidth", min=0.1, max=2, value=0.2, step=0.1)) %>% 
        add_axis("x", subdivide=4) %>%
        hide_legend("stroke") %>%
        add_tooltip(histogram_tooltip, "hover") %>%
        bind_shiny("market_histogram", "market_histogram_slider")
    
    resource.df %>% 
        ggvis(x=~PRICE, y=~TERM_LENGTH, size:=50, fill:=~REP_COLOR, stroke="lightsteelblue", key:=~ID) %>% 
        layer_points() %>% 
        add_axis("x", subdivide=4) %>%
        hide_legend("stroke") %>%
        add_tooltip(tooltip_helper, "hover") %>%
        bind_shiny("market_scatterplot")
    
})