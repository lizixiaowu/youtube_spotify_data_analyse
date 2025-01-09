library(shiny)
library(readr)
library(dplyr)
library(tidyr)
library(stringr)
library(tibble)
library(ggplot2)
library(gridExtra)
library(plotly)
library(lubridate)
library(scales)

# Load the dataset outside the server function
dataset_if36 <- read.csv("dataset_if36.csv")

df <- dataset_if36 %>%
  mutate(date_split = strsplit(date, split = "-"),
         annee = as.double(sapply(date_split, "[", 1)),
         mois = as.double(sapply(date_split, "[", 2))) %>%
  select(-date_split) %>%
  filter(!is.na(annee) & !is.na(Stream) & !is.na(Views)) %>%
  filter(is.finite(Stream) & is.finite(Views)) %>%
  filter(annee != 0)

df_sorted <- df %>%
  filter(annee != 0) %>%
  arrange(annee, mois)

############################ éléments question 2 ##################################
stream_views_annee <- df_sorted %>%
  group_by(annee) %>%
  summarise(stream = sum(Stream), view = sum(Views), .groups = 'drop')

# chanson avant 2008
stream_view_2008 <- df_sorted %>%
  select(Views, Stream, annee, mois) %>%
  filter(annee < 2008)

# chanson après 2008
stream_view_2009 <- df_sorted %>%
  select(Views, Stream, annee, mois) %>%
  filter(annee > 2008)

########################### éléments pour la question 6 ########################
numeric_columns <- c("Loudness", "Valence", "Speechiness", "Tempo", "Danceability", "Acousticness", "Instrumentalness", "Energy")

# Séparation des colonnes numériques et non numériques
numeric_data <- df_sorted[, numeric_columns]
non_numeric_columns <- setdiff(names(df_sorted), numeric_columns)
non_numeric_data <- df_sorted[, non_numeric_columns]

# Normalisation des colonnes numériques
scaled_numeric_data <- scale(numeric_data)

# Recombinaison des colonnes normalisées et non numériques
scaled_df <- data.frame(scaled_numeric_data, non_numeric_data)

###################### élément question 8 ###########################################
mean_stats <- scaled_df %>%
  group_by(annee, official_video) %>%
  summarise(
    mean_views = mean(Views, na.rm = TRUE),
    mean_likes = mean(Likes, na.rm = TRUE),
    mean_comments = mean(Comments, na.rm = TRUE),
    .groups = 'drop'
  ) %>%
  pivot_longer(cols = c(mean_views, mean_likes, mean_comments), names_to = "Metric", values_to = "Value")

plot_bar_charts <- function(data, metric) {
  p <- ggplot(data[data$Metric == metric, ], aes(x = Metric, y = Value, fill = as.factor(official_video))) +
    geom_bar(stat = "identity", position = "dodge", color = "white") +
    labs(fill = "Official", y = "Value", x = "Metric", title = metric) +
    theme_minimal() +
    scale_fill_manual(values = c("TRUE" = "blue", "FALSE" = "red"))

  ggplotly(p)
}

shinyServer(function(input, output) {

    # Output Menu question2, graphique 1
  output$graphique1 <- renderPlotly({
    ggplot_obj <- ggplotly(
      ggplot(stream_view_2008, aes(x = Stream, y = Views)) +
        geom_point(color = "blue") +
        geom_smooth() +
        scale_x_log10(labels = comma, breaks = trans_breaks("log10", function(x) 10^x)) +
        scale_y_log10(labels = comma, breaks = trans_breaks("log10", function(x) 10^x)) +
        labs(title = "Relation between Stream and Views before 2008") +
        theme(plot.title = element_text(size = 8.5))
    )
    ggplot_obj
  })

  # Output Menu question2, graphique 2
  output$graphique2 <- renderPlotly({
    ggplot_obj <- ggplotly(ggplot(stream_view_2009, aes(x = Stream, y = Views)) +
                             geom_point(color = "blue") +
                             geom_smooth() +
                             scale_x_log10(labels = comma, breaks = trans_breaks("log10", function(x) 10^x)) +
                             scale_y_log10(labels = comma, breaks = trans_breaks("log10", function(x) 10^x)) +
                             labs(title = "Relation between Views and Stream from 2008") +
                             theme(plot.title = element_text(size = 8.5)))
    ggplot_obj
  })

  output$graphique3 <- renderPlotly({
    ggplot_obj <- ggplotly(ggplot(stream_views_annee) +
                             geom_line(aes(x = annee, y = stream), color = "blue") +
                             geom_line(aes(x = annee, y = view), color = "red") +
                             scale_color_manual(values = c("Stream" = "blue", "View" = "red")) +
                             scale_x_continuous(breaks = seq(1913, 2023, by = 10)))
    ggplot_obj
  })

  ########################## question6 visualisation ##########################
  output$graphique_q6 <- renderPlotly({
    df_2010 <- scaled_df %>%
      filter(annee == input$annee)

    max_attr <- apply(df_2010[, c("Danceability", "Loudness", "Speechiness", "Acousticness")], 1, which.max)
    attributes <- c("Danceability", "Loudness", "Speechiness", "Acousticness")
    max_attr_labels <- attributes[max_attr]

    count_data <- as.data.frame(table(max_attr_labels))
    colnames(count_data) <- c("Attribute", "Count")

    colors <- c("Danceability" = "red", "Loudness" = "blue", "Speechiness" = "green", "Acousticness" = "purple")

    plot_ly(count_data, labels = ~Attribute, values = ~Count, type = 'pie',
            marker = list(colors = colors)) %>%
      layout(title = paste('Répartition des attributs de chanson en', input$annee))
  })

  #################### visualisations question 8 ###############################
  output$graphique_q8_view <- renderPlotly({
    mean_stats_year <- mean_stats %>%
      filter(annee == input$annee)
    plot_bar_charts(mean_stats_year, "mean_views")
  })

  output$graphique_q8_like <- renderPlotly({
    mean_stats_year <- mean_stats %>%
      filter(annee == input$annee)
    plot_bar_charts(mean_stats_year, "mean_likes")
  })

  output$graphique_q8_comment <- renderPlotly({
    mean_stats_year <- mean_stats %>%
      filter(annee == input$annee)
    plot_bar_charts(mean_stats_year, "mean_comments")
  })

  ########################## visualisation question 9 #########################
  filtered_data <- reactive({
    dataset_if36 %>%
      filter(year(as.Date(date, "%Y-%m-%d")) %in% input$selected_years,
             Album_type %in% input$album_type)
  })

  artist_yearly <- reactive({
    filtered_data() %>%
      mutate(year = year(as.Date(date, "%Y-%m-%d"))) %>%
      group_by(Artist, year, Album_type) %>%
      summarise(Release_Frequency = n(),
                Total_Streams = sum(Stream, na.rm = TRUE),
                Total_Views = sum(Views, na.rm = TRUE),
                .groups = 'drop')
  })

  artist_stats <- reactive({
    artist_yearly() %>%
      group_by(Artist, Album_type) %>%
      summarise(Avg_Frequency = mean(Release_Frequency),
                Avg_Streams = mean(Total_Streams),
                Avg_Views = mean(Total_Views),
                .groups = 'drop')
  })

  output$scatterPlot <- renderPlot({
    y_var <- input$y_var

    ggplot(artist_stats(), aes(x = Avg_Frequency, y = !!sym(paste0("Avg_", y_var)), color = Album_type)) +
      geom_point(alpha = 0.7, size = 2) +
      scale_color_manual(values = c("album" = "red", "single" = "blue")) +
      labs(title = paste("La relation entre Average Yearly Release Frequency et Average Yearly", y_var),
           x = "Average Yearly Release Frequency",
           y = paste("Average Yearly", y_var)) +
      theme_minimal()
  })

  ###################################visualisation question 12##########################
  output$graphique_q12 <- renderPlotly({
    df_duree <- scaled_df %>%
      select(Uri, Duration_ms, annee, Views)%>%
      mutate(Duration_ms=Duration_ms/1000/60)%>%
      filter(annee==input$annee, Duration_ms<10)

    plt=ggplot(data=df_duree)+aes(x=Duration_ms)+
      geom_histogram(fill= "blue", alpha = 0.7, bins = 50)
    ggplotly(plt)
  })


})
