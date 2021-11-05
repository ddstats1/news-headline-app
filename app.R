
library(shiny)
library(tidyverse)
library(here)


# Read in headline data ---------------------------------------------------

# so far just 20-21 CNN -- will build a mock-up with this data

cnn <- read_csv(here("cnn-20-21.csv")) %>%
  mutate(dates = as.character(dates))

# functionality in app:
# - select a year range and search for a word/phrase to match on (can add fuzzy
# match functionality later)
# - search from all news sources, or just some (checklist, default all)


ui <- fluidPage(

  textInput("phrase", "Search for a word/phrase"),

  tableOutput("results")

)

server <- function(input, output, session) {

  selected <- reactive({

    cnn %>%
      filter(str_detect(headlines, input$phrase))

  })

  output$results <- renderTable(
    selected() %>% slice(1:10)
  )

}

shinyApp(ui, server)
