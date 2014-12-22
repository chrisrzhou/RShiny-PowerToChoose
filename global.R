# Shiny server code

# Load libraries
library(shiny)
library(dplyr)
library(ggvis)


# Helper functions
get_df = function() {
    # Get raw dataframe
    #
    # @return: raw dataframe returned by read.csv from provided url.
    
    url = "http://www.powertochoose.org/en-us/Plan/ExportToCsv"
    df = read.csv(url, header=TRUE, stringsAsFactors=FALSE)
    df = clean(df)
}

clean = function(df) {
    # Clean raw dataframe
    # Rename dataframe columns and define types.  Keep some columns
    #
    # @df: raw dataframe from raw_df()
    # @return: cleaned dataframe with some columns kept
    
    columns = c("ID", "TDU", "REP", "PRODUCT",
                "KWH500", "KWH1000", "KWH2000",
                "FEES", "PREPAID", "TOU",
                "FIXED", "RATE_TYPE", "RENEWABLE",
                "TERM_LENGTH", "CANCEL_FEE", "WEdBSITE",
                "TERMS", "TERMS_URL", "PROMOTION", "PROMOTION_DESCRIPTION",
                "EFL_URL", "ENROLL_URL", "PREPAID_URL", "ENROLL_PHONE")
    colnames(df) = columns  # rename columns
    
    df = df %>%  # mutate df using the amazing dplyr
        select(ID, TDU, REP, PRODUCT,
               KWH500, KWH1000, KWH2000,
               RATE_TYPE, TERM_LENGTH, RENEWABLE,
               PREPAID, TOU, PROMOTION, EFL_URL) %>%
        mutate(KWH500 = KWH500 * 100,
               KWH1000 = KWH1000 * 100,
               KWH2000 = KWH2000 * 100,
               PREPAID = as.logical(PREPAID),
               TOU = as.logical(TOU),
               PROMOTION = as.logical(PROMOTION))
    
    df = na.omit(df)  # Remove NA records
    return(df)
}

histogram_tooltip <- function(data) {
    if(is.null(data)) return(NULL)
    sprintf("Price: %s - %s c/kWh<br />Count: %s<br />",
            round(data$xmin, 1), round(data$xmax, 1), data$stack_upr - data$stack_lwr)
}


# Define global variables
df_base = get_df()
TDUS = unique(df_base$TDU)
REPS = unique(df_base$REP)
RATE_TYPES = unique(df_base$RATE_TYPE)
BOOLEANS = c(TRUE, FALSE)
USAGE = c("KWH500", "KWH1000", "KWH2000")
REP_COLOR_MAP = c(
    "REP1" = "crimson",
    "REP2" = "goldenrod",
    "REP3" = "darkseagreen",
    "REST" = "lightgray"
)