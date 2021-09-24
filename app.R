library(shiny)
library(DT)
library(tidyverse)
library(plotly)
library(here)
library(ggplot2)

tidy_fuels <- read_csv(here("data", "cooking.csv"))


fuels<-tidy_fuels%>%
  mutate(new_cooking=noquote(format(cooking, digits=2, nsmall=2)),
         new_gdp_per_capita=noquote(format(gdp_per_capita, digits=2, nsmall=2)),
         population=formatC(tidy_fuels$total_population, format="d", big.mark=","))%>%
  select(-c(cooking:total_population))


countryset<-tidy_fuels%>%
  distinct(country) %>%
  arrange(country) %>%
  pull(country)


ui <- fluidPage(
  title = "Indoor Air Pollution",
  tabsetPanel(
    tabPanel("chart",
      icon = icon("line-chart"),
      fluidRow(
        column(
          2,
          checkboxInput("linear_scale",
            "Linearize x-axis",
            value = FALSE
          )
        ),
        column(
          6,
          offset = 1,
          # also possible to use plotly here
          selectizeInput("countries", "Select Countries",
                         multiple = TRUE,
                         label="Which country do you want to analyze:",
                         choices=countryset
          ),
        ),
        column(
          2,
          offset = 1,
          checkboxInput("small_countries",
            "Hide countries < 1 million",
            value =NULL
          )
        )
      ),
      plotlyOutput("chart", width = "100%"),
      sliderInput("year",
        "Year",
        min = 2000,
        max = 2016,
        value = 2016,
        sep = "",
        width = "100%"
      )
    ),
    tabPanel("table", dataTableOutput("table"), icon = icon("table")),
    tabPanel("about", icon = icon("question"), uiOutput("tab"))
  )
)




server <- function(input, output, session) ({


  newdata <- reactive(
    if(input$small_countries){
      tidy_fuels%>%
         group_by(continent)%>%
        filter(year==input$year)%>%
        filter(total_population > 1000000)
    }else{
      tidy_fuels%>%
        group_by(continent)%>%
        filter(year==input$year)
      })

  # selection<- reactiveValues(countries=NULL)
  #
  # observeEvent(input$countries,{
  #   selection$countries<-input$countries
  #   })

  data<-reactive(
  if(length(input$countries)==0){
    newdata()
  }else{
    newdata()%>%
      filter(country %in% input$countries)
    }
  )

  # data <- reactive({
  #   req(input$countries)
  #   newdata()%>%
  #        filter(country %in% input$countries)
  # })

  output$chart<- renderPlotly({

# plotly::highlight(selectize = TRUE)
    p<- ggplot(data = highlight_key(newdata(), ~country),
              aes(x=gdp_per_capita,
                  y=cooking,
                  label=country,
                  color=continent))+
      geom_point()+
      scale_size_continuous(trans = "log10") +
      scale_y_continuous(labels = scales::label_percent(scale = 1)) +
      geom_point(data = data(),
                 aes(x=gdp_per_capita,
                     y=cooking,
                     size=100))+
      labs(x = "GDP per captia",
           y = "Access to clean fuels and technologies for cooking",
           color = "continent",
           title = "Access to clean fuels for cooking vs. GDP per capita",
           size=" ")


    if(input$linear_scale){
      p2<- ggplotly(p, tooltip = c("country","cooking","gdp_per_capita","total_ population"))

      p3<-p2 %>%
        config(displaylogo = FALSE,
               modeBarButtonsToRemove = c("zoomIn2d", "zoomOut2d", "zoom2d", "pan2d"))


      highlight(p3, dynamic = TRUE,  on = "plotly_hover")
    }

    else{
      p4<- ggplotly(p + scale_x_log10(c(1000, 2000, 5000, 10000, 20000, 50000, 100000),
                                     labels = ~scales::dollar(., accuracy=1))+
                      labs(x = "GDP"),
                    tooltip = c("country","cooking","gdp_per_capita","total_ population"))


      p5<-p4 %>%
        config(displaylogo = FALSE,
               modeBarButtonsToRemove = c("zoomIn2d", "zoomOut2d", "zoom2d", "pan2d"))


      p5

    }
})




  data1<- reactive(
    if(input$small_countries){
      fuels%>%
        group_by(year)%>%
        arrange(-year)%>%
        filter(population > 1000000)

    }else{
      fuels%>%
       arrange(-year)
    })




  data2<-reactive(
    if(length(input$countries)==0){
      data1()
       }else{
      data1()%>%
        filter(country %in% input$countries)%>%
        arrange(-year)
    })

  output$table <- renderDataTable({

    DT::datatable(
                  data2(),
                  options = list(
                    lengthMenu = c(5, 30, 50), pageLength = 10))%>%
      formatStyle(columns = c("continent", "country","code","year"), `text-align` = 'left') %>%
      formatStyle(columns = c("population", "new_cooking","new_gdp_per_capita"), `text-align` = 'right')
  })

  ur1<-a("github", href="https://github.com/SiyiLi41")
  ur2<-a("source", href="https://ourworldindata.org/grapher/access-to-clean-fuels-for-cooking-vs-gdp-per-capita")
  output$tab<-renderUI({
    tagList("URL link of github:",ur1,
            br(),br(),br(),
            "URL link of sources:",ur2)
  })



})

runApp(shinyApp(ui, server))
