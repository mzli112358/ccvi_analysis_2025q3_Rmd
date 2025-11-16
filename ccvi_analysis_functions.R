# CCVI Analysis Utility Functions and Extended Analysis
# Climate-Conflict-Vulnerability Index 2025 Q3 Analysis
# Supporting R Script for Advanced Analytics

# Load required libraries
suppressPackageStartupMessages({
  library(tidyverse)
  library(data.table)
  library(arrow)
  library(sf)
  library(rnaturalearth)
  library(rnaturalearthdata)
  library(leaflet)
  library(plotly)
  library(DT)
  library(kableExtra)
  library(ggplot2)
  library(ggthemes)
  library(viridis)
  library(RColorBrewer)
  library(corrplot)
  library(psych)
  library(factoextra)
  library(cluster)
  library(tmap)
  library(countrycode)
})

# Set global options
options(scipen = 999, digits = 4, warn = -1)
theme_set(theme_minimal())

# Color palettes
ccvi_palette <- c("#1f77b4", "#ff7f0e", "#2ca02c", "#d62728", "#9467bd", "#8c564b", "#e377c2", "#7f7f7f", "#bcbd22", "#17becf")
risk_palette <- c("#2b8cbe", "#7bccc4", "#bae4bc", "#f0f9e8", "#fee0d2", "#fcbba1", "#fc9272", "#fb6a4a", "#de2d26", "#a50f15")

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

#' Load parquet files safely with error handling
#' @param file_path Path to parquet file
#' @return Data frame or NULL if error
load_parquet_safe <- function(file_path) {
  tryCatch({
    if (file.exists(file_path)) {
      return(as.data.frame(read_parquet(file_path)))
    } else {
      warning(paste("File not found:", file_path))
      return(NULL)
    }
  }, error = function(e) {
    warning(paste("Error loading file:", file_path, "-", e$message))
    return(NULL)
  })
}

#' Clean and standardize column names
#' @param df Input data frame
#' @return Data frame with cleaned column names
clean_column_names <- function(df) {
  names(df) <- gsub("[^a-zA-Z0-9_]", "_", names(df))
  names(df) <- gsub("_+", "_", names(df))
  names(df) <- gsub("^_+|_+$", "", names(df))
  names(df) <- tolower(names(df))
  return(df)
}

#' Categorize risk scores into meaningful levels
#' @param score Numeric risk score (0-1)
#' @param thresholds Breakpoints for categories
#' @return Factor with risk categories
categorize_risk <- function(score, thresholds = c(0.2, 0.4, 0.6, 0.8)) {
  cut(score, 
      breaks = c(0, thresholds, 1), 
      labels = c("Very Low", "Low", "Moderate", "High", "Very High"),
      include.lowest = TRUE)
}

#' Define geographic regions based on ISO3 codes
#' @param iso3 Vector of ISO3 country codes
#' @return Vector of region names
define_region <- function(iso3) {
  case_when(
    iso3 %in% c("USA", "CAN", "MEX", "GTM", "HND", "SLV", "NIC", "CRI", "PAN", "CUB", "JAM", "HTI", "DOM") ~ "North America & Caribbean",
    iso3 %in% c("BRA", "ARG", "CHL", "COL", "PER", "VEN", "ECU", "BOL", "PRY", "URY", "GUY", "SUR", "GUF") ~ "South America",
    iso3 %in% c("DEU", "FRA", "GBR", "ITA", "ESP", "POL", "NLD", "BEL", "GRC", "PRT", "AUT", "CHE", "SWE", "NOR", "DNK", "FIN", "IRL", "ISL", "LUX", "MCO", "AND", "SMR", "VAT", "LIE", "CZE", "SVK", "HUN", "SVN", "HRV", "BIH", "SRB", "MNE", "MKD", "ALB", "BGR", "ROU", "MDA", "UKR", "BLR", "EST", "LVA", "LTU", "RUS") ~ "Europe & Russia",
    iso3 %in% c("TUR", "CYP", "ISR", "PSE", "JOR", "LBN", "SYR", "IRQ", "IRN", "SAU", "KWT", "BHR", "QAT", "ARE", "OMN", "YEM") ~ "Middle East",
    iso3 %in% c("CHN", "JPN", "KOR", "IND", "PAK", "BGD", "LKA", "NPL", "BTN", "MDV", "AFG", "TJK", "TKM", "UZB", "KGZ", "KAZ") ~ "South & Central Asia",
    iso3 %in% c("THA", "VNM", "LAO", "KHM", "MMR", "MYS", "SGP", "BRN", "IDN", "TLS", "PHL") ~ "Southeast Asia",
    iso3 %in% c("EGY", "LBY", "TUN", "DZA", "MAR", "SDN", "ETH", "ERI", "DJI", "SOM", "KEN", "TZA", "UGA", "RWA", "BDI", "SSD") ~ "North & East Africa",
    iso3 %in% c("NGA", "GHA", "TGO", "BEN", "CIV", "LBR", "SLE", "GIN", "GNB", "SEN", "MLI", "BFA", "NER", "TCD", "CMR", "CAF", "GNQ", "GAB", "COG", "COD", "AGO", "ZMB", "ZWE", "BWA", "NAM", "SWZ", "LSO", "ZAF", "MDG", "MUS", "SYC", "COM", "MOZ", "MWI", "ZMB") ~ "West & Southern Africa",
    iso3 %in% c("AUS", "NZL", "PNG", "FJI", "NCL", "VUT", "SLB", "TON", "WSM", "KIR", "TUV", "NRU", "PLW", "FSM", "MHL") ~ "Oceania",
    TRUE ~ "Other"
  )
}

# =============================================================================
# ADVANCED ANALYSIS FUNCTIONS
# =============================================================================

#' Perform comprehensive risk hotspot analysis
#' @param data Input data frame with risk scores
#' @param threshold Risk score threshold for hotspot identification
#' @return List containing hotspot analysis results
analyze_risk_hotspots <- function(data, threshold = 0.7) {
  hotspots <- data %>% 
    filter(ccvi > threshold & !is.na(lat) & !is.na(lon)) %>% 
    mutate(
      hotspot_type = case_when(
        cli_risk > 0.7 & con_risk > 0.7 & vul_risk > 0.7 ~ "Triple Risk",
        cli_risk > 0.7 & con_risk > 0.7 ~ "Climate-Conflict",
        cli_risk > 0.7 & vul_risk > 0.7 ~ "Climate-Vulnerability", 
        con_risk > 0.7 & vul_risk > 0.7 ~ "Conflict-Vulnerability",
        cli_risk > 0.7 ~ "Climate Dominant",
        con_risk > 0.7 ~ "Conflict Dominant",
        vul_risk > 0.7 ~ "Vulnerability Dominant",
        TRUE ~ "Mixed Risk"
      )
    )
  
  hotspot_summary <- hotspots %>% 
    group_by(hotspot_type) %>% 
    summarise(
      n_hotspots = n(),
      mean_ccvi = mean(ccvi, na.rm = TRUE),
      mean_cli = mean(cli_risk, na.rm = TRUE),
      mean_con = mean(con_risk, na.rm = TRUE),
      mean_vul = mean(vul_risk, na.rm = TRUE),
      countries_affected = n_distinct(iso3),
      .groups = "drop"
    ) %>% 
    arrange(desc(n_hotspots))
  
  return(list(
    hotspots = hotspots,
    summary = hotspot_summary,
    total_hotspots = nrow(hotspots),
    countries_affected = n_distinct(hotspots$iso3)
  ))
}

#' Perform temporal trend analysis
#' @param data Historical data with time series
#' @param start_year Starting year for analysis
#' @return List containing trend analysis results
analyze_temporal_trends <- function(data, start_year = 2020) {
  temporal_data <- data %>% 
    filter(year >= start_year) %>% 
    group_by(year, quarter) %>% 
    summarise(
      global_mean_ccvi = mean(ccvi, na.rm = TRUE),
      global_mean_cli = mean(cli_risk, na.rm = TRUE),
      global_mean_con = mean(con_risk, na.rm = TRUE),
      global_mean_vul = mean(vul_risk, na.rm = TRUE),
      .groups = "drop"
    ) %>% 
    mutate(
      time_period = paste0(year, "-Q", quarter),
      date = as.Date(paste0(year, "-", (quarter * 3 - 2), "-01"))
    )
  
  # Calculate trend slopes
  ccvi_trend <- lm(global_mean_ccvi ~ as.numeric(date), data = temporal_data)
  cli_trend <- lm(global_mean_cli ~ as.numeric(date), data = temporal_data)
  con_trend <- lm(global_mean_con ~ as.numeric(date), data = temporal_data)
  vul_trend <- lm(global_mean_vul ~ as.numeric(date), data = temporal_data)
  
  return(list(
    temporal_data = temporal_data,
    ccvi_trend = ccvi_trend,
    cli_trend = cli_trend,
    con_trend = con_trend,
    vul_trend = vul_trend
  ))
}

#' Perform advanced clustering analysis
#' @param data Input data with risk scores
#' @param n_clusters Number of clusters to identify
#' @return List containing clustering results
perform_risk_clustering <- function(data, n_clusters = 5) {
  # Prepare data for clustering
  cluster_data <- data %>% 
    select(pgid, iso3, country, lat, lon, cli_risk, con_risk, vul_risk, ccvi) %>% 
    filter(complete.cases(.))
  
  # Perform k-means clustering
  set.seed(123)
  kmeans_result <- kmeans(cluster_data %>% select(cli_risk, con_risk, vul_risk), 
                       centers = n_clusters, nstart = 25)
  
  # Add cluster labels
  clustered_data <- cluster_data %>% 
    mutate(cluster = as.factor(kmeans_result$cluster))
  
  # Calculate cluster characteristics
  cluster_summary <- clustered_data %>% 
    group_by(cluster) %>% 
    summarise(
      n_cells = n(),
      mean_ccvi = mean(ccvi, na.rm = TRUE),
      mean_cli = mean(cli_risk, na.rm = TRUE),
      mean_con = mean(con_risk, na.rm = TRUE),
      mean_vul = mean(vul_risk, na.rm = TRUE),
      mean_lat = mean(lat, na.rm = TRUE),
      mean_lon = mean(lon, na.rm = TRUE),
      .groups = "drop"
    )
  
  return(list(
    clustered_data = clustered_data,
    cluster_summary = cluster_summary,
    kmeans_result = kmeans_result,
    cluster_centers = kmeans_result$centers
  ))
}

#' Generate comprehensive country profiles
#' @param data Input data frame
#' @param countries Vector of ISO3 country codes to analyze
#' @return List of country profiles
generate_country_profiles <- function(data, countries = NULL) {
  if (is.null(countries)) {
    countries <- unique(data$iso3)
  }
  
  profiles <- list()
  
  for (country in countries) {
    country_data <- data %>% filter(iso3 == country)
    
    if (nrow(country_data) > 0) {
      country_name <- unique(country_data$country)[1]
      
      profile <- list(
        iso3 = country,
        country_name = country_name,
        n_cells = nrow(country_data),
        risk_summary = country_data %>% 
          summarise(
            mean_ccvi = mean(ccvi, na.rm = TRUE),
            median_ccvi = median(ccvi, na.rm = TRUE),
            sd_ccvi = sd(ccvi, na.rm = TRUE),
            min_ccvi = min(ccvi, na.rm = TRUE),
            max_ccvi = max(ccvi, na.rm = TRUE),
            mean_cli = mean(cli_risk, na.rm = TRUE),
            mean_con = mean(con_risk, na.rm = TRUE),
            mean_vul = mean(vul_risk, na.rm = TRUE),
            high_risk_cells = sum(ccvi > 0.6, na.rm = TRUE),
            very_high_risk_cells = sum(ccvi > 0.8, na.rm = TRUE),
            .groups = "drop"
          ),
        risk_distribution = country_data %>% 
          count(ccvi_category) %>% 
          mutate(percentage = (n / sum(n)) * 100),
        geographic_extent = country_data %>% 
          summarise(
            lat_range = range(lat, na.rm = TRUE),
            lon_range = range(lon, na.rm = TRUE),
            center_lat = mean(lat, na.rm = TRUE),
            center_lon = mean(lon, na.rm = TRUE),
            .groups = "drop"
          )
      )
      
      profiles[[country]] <- profile
    }
  }
  
  return(profiles)
}

# =============================================================================
# VISUALIZATION FUNCTIONS
# =============================================================================

#' Create interactive risk map
#' @param data Input data with coordinates and risk scores
#' @param risk_column Column name for risk scores
#' @param title Map title
#' @return Leaflet map object
create_interactive_risk_map <- function(data, risk_column = "ccvi", title = "Risk Map") {
  valid_data <- data %>% filter(!is.na(lat) & !is.na(lon) & !is.na(!!sym(risk_column)))
  
  map <- leaflet(valid_data) %>%
    addTiles() %>%
    addCircleMarkers(
      lng = ~lon,
      lat = ~lat,
      radius = 2,
      color = ~colorNumeric(risk_palette, !!sym(risk_column))(!!sym(risk_column)),
      fillOpacity = 0.7,
      stroke = FALSE,
      popup = ~paste0(
        "Country: ", country, "<br>",
        "Risk Score: ", round(!!sym(risk_column), 3), "<br>",
        "Climate Risk: ", round(cli_risk, 3), "<br>",
        "Conflict Risk: ", round(con_risk, 3), "<br>",
        "Vulnerability Risk: ", round(vul_risk, 3), "<br>",
        "Lat: ", round(lat, 2), "<br>",
        "Lon: ", round(lon, 2)
      )
    ) %>%
    addLegend(
      position = "bottomright",
      pal = colorNumeric(risk_palette, domain = c(0, 1)),
      values = valid_data[[risk_column]],
      title = title,
      opacity = 1
    ) %>%
    setView(lng = 0, lat = 20, zoom = 2)
  
  return(map)
}

#' Create risk scatter plot matrix
#' @param data Input data with risk scores
#' @return Plotly scatter plot matrix
create_risk_scatter_matrix <- function(data) {
  valid_data <- data %>% filter(complete.cases(select(., cli_risk, con_risk, vul_risk, ccvi)))
  
  plot <- plot_ly(valid_data,
                  type = "splom",
                  dimensions = list(
                    list(values = ~cli_risk, label = "Climate Risk"),
                    list(values = ~con_risk, label = "Conflict Risk"),
                    list(values = ~vul_risk, label = "Vulnerability Risk"),
                    list(values = ~ccvi, label = "Overall CCVI")
                  ),
                  color = ~ccvi,
                  colors = risk_palette,
                  marker = list(size = 3, opacity = 0.6),
                  diagonal = list(visible = FALSE)) %>%
    layout(
      title = "Risk Score Correlation Matrix",
      hovermode = "closest"
    )
  
  return(plot)
}

#' Create temporal trend visualization
#' @param temporal_results Results from temporal trend analysis
#' @return ggplot object
create_temporal_trend_plot <- function(temporal_results) {
  temporal_data <- temporal_results$temporal_data
  
  plot <- temporal_data %>% 
    pivot_longer(cols = c(global_mean_ccvi, global_mean_cli, global_mean_con, global_mean_vul),
                 names_to = "metric", values_to = "value") %>% 
    mutate(metric = case_when(
      metric == "global_mean_ccvi" ~ "Overall CCVI",
      metric == "global_mean_cli" ~ "Climate Risk",
      metric == "global_mean_con" ~ "Conflict Risk",
      metric == "global_mean_vul" ~ "Vulnerability Risk"
    )) %>% 
    ggplot(aes(x = date, y = value, color = metric, group = metric)) +
    geom_line(size = 1.5) +
    geom_point(size = 2) +
    geom_smooth(method = "lm", se = TRUE, alpha = 0.2) +
    scale_color_manual(values = c("Overall CCVI" = "#1f77b4", "Climate Risk" = "#2ca02c", 
                                   "Conflict Risk" = "#ff7f0e", "Vulnerability Risk" = "#9467bd")) +
    labs(title = "Global Risk Trends with Linear Regression",
         subtitle = "Quarterly evolution of mean risk scores with trend lines",
         x = "Date",
         y = "Mean Risk Score") +
    theme_minimal() +
    theme(legend.position = "bottom")
  
  return(plot)
}

# =============================================================================
# REPORT GENERATION FUNCTIONS
# =============================================================================

#' Generate executive summary statistics
#' @param data Current risk data
#' @return Data frame with summary statistics
generate_executive_summary <- function(data) {
  summary_stats <- data %>% 
    summarise(
      n_cells = n(),
      mean_ccvi = mean(ccvi, na.rm = TRUE),
      median_ccvi = median(ccvi, na.rm = TRUE),
      sd_ccvi = sd(ccvi, na.rm = TRUE),
      min_ccvi = min(ccvi, na.rm = TRUE),
      max_ccvi = max(ccvi, na.rm = TRUE),
      
      mean_cli = mean(cli_risk, na.rm = TRUE),
      mean_con = mean(con_risk, na.rm = TRUE),
      mean_vul = mean(vul_risk, na.rm = TRUE),
      
      high_risk_cells = sum(ccvi > 0.6, na.rm = TRUE),
      very_high_risk_cells = sum(ccvi > 0.8, na.rm = TRUE),
      
      high_risk_percentage = (high_risk_cells / n_cells) * 100,
      very_high_risk_percentage = (very_high_risk_cells / n_cells) * 100,
      
      countries_analyzed = n_distinct(iso3),
      regions_analyzed = n_distinct(region)
    )
  
  return(summary_stats)
}

#' Generate country risk ranking
#' @param data Input data with country information
#' @param top_n Number of top countries to include
#' @return Data frame with country rankings
generate_country_ranking <- function(data, top_n = 20) {
  country_stats <- data %>% 
    group_by(iso3, country, region) %>% 
    summarise(
      n_cells = n(),
      mean_ccvi = mean(ccvi, na.rm = TRUE),
      mean_cli = mean(cli_risk, na.rm = TRUE),
      mean_con = mean(con_risk, na.rm = TRUE),
      mean_vul = mean(vul_risk, na.rm = TRUE),
      max_ccvi = max(ccvi, na.rm = TRUE),
      min_ccvi = min(ccvi, na.rm = TRUE),
      sd_ccvi = sd(ccvi, na.rm = TRUE),
      high_risk_cells = sum(ccvi > 0.6, na.rm = TRUE),
      very_high_risk_cells = sum(ccvi > 0.8, na.rm = TRUE),
      high_risk_percentage = (high_risk_cells / n_cells) * 100,
      very_high_risk_percentage = (very_high_risk_cells / n_cells) * 100,
      .groups = "drop"
    ) %>% 
    arrange(desc(mean_ccvi)) %>% 
    slice(1:top_n) %>% 
    mutate(rank = row_number())
  
  return(country_stats)
}

# =============================================================================
# DATA EXPORT FUNCTIONS
# =============================================================================

#' Export analysis results to various formats
#' @param results List containing analysis results
#' @param output_dir Output directory path
#' @param timestamp Timestamp for file naming
export_analysis_results <- function(results, output_dir = "ccvi_analysis_output", timestamp = format(Sys.time(), "%Y%m%d_%H%M%S")) {
  # Create output directory
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }
  
  # Export summary statistics
  if (!is.null(results$executive_summary)) {
    write.csv(results$executive_summary, 
              file.path(output_dir, paste0("executive_summary_", timestamp, ".csv")),
              row.names = FALSE)
  }
  
  # Export country rankings
  if (!is.null(results$country_ranking)) {
    write.csv(results$country_ranking, 
              file.path(output_dir, paste0("country_ranking_", timestamp, ".csv")),
              row.names = FALSE)
  }
  
  # Export hotspot analysis
  if (!is.null(results$hotspot_analysis$summary)) {
    write.csv(results$hotspot_analysis$summary, 
              file.path(output_dir, paste0("hotspot_summary_", timestamp, ".csv")),
              row.names = FALSE)
  }
  
  # Export cluster analysis
  if (!is.null(results$cluster_analysis$cluster_summary)) {
    write.csv(results$cluster_analysis$cluster_summary, 
              file.path(output_dir, paste0("cluster_summary_", timestamp, ".csv")),
              row.names = FALSE)
  }
  
  message(paste("Analysis results exported to:", output_dir))
}

# =============================================================================
# EXAMPLE USAGE AND WORKFLOW
# =============================================================================

#' Complete CCVI analysis workflow
#' @param data_path Path to CCVI data directory
#' @param output_dir Output directory for results
#' @param countries Specific countries to analyze (NULL for all)
#' @return List containing all analysis results
run_complete_ccvi_analysis <- function(data_path = "ccvi-full-2025-3", 
                                      output_dir = "ccvi_analysis_output",
                                      countries = NULL) {
  
  message("Starting comprehensive CCVI analysis...")
  
  # Load and prepare data
  message("Loading data...")
  ccvi_structure <- fread(file.path(data_path, "ccvi-structure.tsv"), encoding = "UTF-8")
  ccvi_sources <- fread(file.path(data_path, "ccvi-data-sources.tsv"), encoding = "UTF-8")
  
  base_grid <- load_parquet_safe(file.path(data_path, "base_grid.parquet"))
  exposure_layers <- load_parquet_safe(file.path(data_path, "exposure_layers.parquet"))
  ccvi_scores <- load_parquet_safe(file.path(data_path, "ccvi_scores.parquet"))
  data_recency <- load_parquet_safe(file.path(data_path, "data_recency.parquet"))
  vul_country_raw <- load_parquet_safe(file.path(data_path, "vul_country_raw.parquet"))
  
  # Clean column names
  base_grid <- clean_column_names(base_grid)
  exposure_layers <- clean_column_names(exposure_layers)
  ccvi_scores <- clean_column_names(ccvi_scores)
  data_recency <- clean_column_names(data_recency)
  vul_country_raw <- clean_column_names(vul_country_raw)
  
  # Get latest data
  latest_quarter <- ccvi_scores %>% 
    group_by(pgid) %>% 
    summarise(
      latest_year = max(year),
      latest_quarter = max(quarter[year == max(year)])
    ) %>% 
    slice(1)
  
  current_year <- latest_quarter$latest_year
  current_quarter <- latest_quarter$latest_quarter
  
  current_data <- ccvi_scores %>% 
    filter(year == current_year & quarter == current_quarter) %>%
    left_join(base_grid %>% select(pgid, iso3, lat, lon), by = "pgid")
  
  # Add country names and regions
  countries <- unique(current_data$iso3)
  country_names <- countrycode(countries, "iso3c", "country.name", warn = FALSE)
  country_mapping <- data.frame(iso3 = countries, country = country_names, stringsAsFactors = FALSE)
  
  current_data <- current_data %>% 
    left_join(country_mapping, by = "iso3") %>%
    mutate(region = define_region(iso3))
  
  # Add risk categories
  current_data <- current_data %>% 
    mutate(
      ccvi_category = categorize_risk(ccvi),
      cli_risk_category = categorize_risk(cli_risk),
      con_risk_category = categorize_risk(con_risk),
      vul_risk_category = categorize_risk(vul_risk)
    )
  
  message("Data preparation complete. Starting analysis...")
  
  # Perform comprehensive analysis
  results <- list()
  
  # Executive summary
  message("Generating executive summary...")
  results$executive_summary <- generate_executive_summary(current_data)
  
  # Country ranking
  message("Generating country rankings...")
  results$country_ranking <- generate_country_ranking(current_data)
  
  # Hotspot analysis
  message("Analyzing risk hotspots...")
  results$hotspot_analysis <- analyze_risk_hotspots(current_data)
  
  # Temporal trends (if historical data available)
  if (nrow(ccvi_scores) > nrow(current_data)) {
    message("Analyzing temporal trends...")
    results$temporal_analysis <- analyze_temporal_trends(ccvi_scores)
  }
  
  # Clustering analysis
  message("Performing clustering analysis...")
  results$cluster_analysis <- perform_risk_clustering(current_data)
  
  # Country profiles
  if (!is.null(countries)) {
    message("Generating country profiles...")
    results$country_profiles <- generate_country_profiles(current_data, countries)
  }
  
  # Export results
  message("Exporting results...")
  export_analysis_results(results, output_dir)
  
  message("Analysis complete!")
  return(results)
}

# =============================================================================
# END OF SCRIPT
# =============================================================================

# Usage example (uncomment to run):
# results <- run_complete_ccvi_analysis()
# print(results$executive_summary)
# View(results$country_ranking)