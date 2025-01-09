library(shinydashboard)
library(plotly)
library(lubridate)


dataset_if36 <- read.csv("dataset_if36.csv")
dashboardPage(
  dashboardHeader(title = "visualisations"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("visualisation question 2", icon=icon("th"), tabName = "question2"),
      menuItem("visualisation quesion 6", icon = icon("th"), tabName = "question6"),
      menuItem("visualisation question 8", icon=icon("th"), tabName = "question8"),
      menuItem("visualisation Question 9", icon = icon("th"), tabName = "question9"),
      menuItem("visualisation question 12", icon=icon("th"), tabName = "question12"),
      sliderInput("annee", "année de sortie", 1918, 2023, 2009)
    )
  ),
  dashboardBody(

    tabItems(
      tabItem(tabName="Dashboard",
              fluidRow(
                valueBox("box fixe", 32),
                valueBoxOutput("averageheight"),
                valueBoxOutput("medianmass"),

                infoBox("individus", 87),
                infoBox("dimensions", 13)
              )),

      tabItem(tabName="question2",
              h3("Relation entre le nombre de vues sur youtube et le nombre de streams sur spotify"),
              fluidRow(
                box(title = "", width = 12,
                    plotlyOutput("graphique1"))),
              fluidRow(

                box(title="", width = 12,
                    plotlyOutput("graphique2"))
              ),
              h3("évolution du nombre de vues et du nombre de stream au cours des années"),
              fluidRow(
                box(title="", width = 12,
                    plotlyOutput("graphique3"))
              )
      ),

      tabItem(tabName="question6",
              fluidRow(
                box(title = "LASD", width = 12,
                    plotlyOutput("graphique_q6"))),

      ),

      tabItem(tabName="question8",
              fluidRow(
                box(title = "", width = 4,
                    plotlyOutput("graphique_q8_view")),
                box(title = "", width = 4,
                    plotlyOutput("graphique_q8_like")),
                box(title = "", width = 4,
                    plotlyOutput("graphique_q8_comment"))),

      ),

      tabItem(tabName = "question9",
              fluidRow(
                box(
                  title = "Music Analysis Dashboard",
                  width = 12,
                  selectInput("selected_years", "Select Years:",
                              choices = sort(unique(year(as.Date(dataset_if36$date, "%Y-%m-%d")))),
                              multiple = TRUE),
                  checkboxGroupInput("album_type", "Select Album Type:",
                                     choices = unique(dataset_if36$Album_type),
                                     selected = unique(dataset_if36$Album_type)),
                  radioButtons("y_var", "Select Y-axis Variable:",
                               choices = list("Streams" = "Streams", "Views" = "Views")),
                  plotOutput("scatterPlot")
                )
              )
      ),

      tabItem(tabName="question12",
              fluidRow(
                h3("l'évolution de la durée globale des différentes chasons "),
                box(title = "le premier graphique", width = 12,
                    plotlyOutput("graphique_q12")))

      )

    )

  ),
)
