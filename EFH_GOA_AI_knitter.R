# read in packages

library(tidyverse)
library(raster)
library(sf)
library(rbgm)
library(viridis)
library(rnaturalearth)
library(kableExtra)

select <- dplyr::select

# Set the spatial context.
# read in the bgm 
atlantis_bgm <- read_bgm("data/GOA_WGS84_V4_final.bgm")
atlantis_sf <- atlantis_bgm %>% box_sf()

# read in the coastline
coast_ak <- ne_countries(country = "United States of America", scale = "medium") # pull country ouitlines from Natural Earth

# set paths for GOA and AI rasters
path_goa <- "data/GOA_2017"
path_ai <- "data/AI_2017"

# get species for GOA
all_dirs_goa <- list.dirs(path = path_goa, full.names = FALSE, recursive = FALSE)
# get species for AI
all_dirs_ai <- list.dirs(path = path_ai, full.names = FALSE, recursive = FALSE)
# get intersect
all_dirs <- intersect(all_dirs_goa, all_dirs_ai)

# loop

for(i in 1:length(all_dirs)) {
  this_file <- all_dirs[i]
  
  goa_raster <- paste(path_goa, this_file, "CPUEpredict.grd", sep = "/")
  ai_raster <- paste(path_ai, this_file, "CPUEpredict.grd", sep = "/")
  
  rmarkdown::render(
    'EFH_GOA_AI_to_Atlantis.Rmd', output_file = paste(paste("knitted_outputs/GOA_and_AI/", this_file, sep = "/" ), '.html')
  )
}