# ==============================================================================
# COMPREHENSIVE EXAMPLES
# ==============================================================================

library(terra)

# Example 1: Basic usage with automatic breaks
# ----------------------------------------------
DEM <- rast(system.file("ex/elev.tif", package = "terra"))
contours_auto <- create_contours(DEM, n.breaks = 10)
plot(DEM)
plot(st_geometry(contours_auto), add = TRUE, col = "white")

# Example 2: Specific break values
# ---------------------------------
contours_manual <- create_contours(
  raster_obj = DEM,
  breaks = seq(140, 550, by = 50)
)
plot_contours(contours_manual, DEM)


# Example 3: With bounding box (numeric vector)
# ----------------------------------------------
bbox <- c(xmin = 5.75, ymin = 49.5, xmax = 6.0, ymax = 49.75)

contours_bbox <- create_contours(
  raster_obj = DEM,
  n.breaks = 15,
  bbox = bbox
)

# Example 4: With bounding box from sf object
# --------------------------------------------
library(sf)
study_area <- st_as_sfc(st_bbox(c(xmin = 5.75, ymin = 49.5, 
                                  xmax = 6.0, ymax = 49.75), 
                                crs = st_crs(DEM)))
contours_sf_bbox <- create_contours(DEM, n.breaks = 12, bbox = study_area)


# Example 5: Specify min/max values
# ----------------------------------
contours_range <- create_contours(
  raster_obj = DEM,
  n.breaks = 8,
  min_value = 200,
  max_value = 500
)

# Example 6: Non-pretty breaks (exact intervals)
# -----------------------------------------------
contours_exact <- create_contours(
  raster_obj = DEM,
  n.breaks = 10,
  pretty_breaks = FALSE
)

# Example 7: Different output formats
# ------------------------------------
contours_sf <- create_contours(DEM, n.breaks = 10, return_format = "sf")
contours_terra <- create_contours(DEM, n.breaks = 10, return_format = "terra")
contours_sp <- create_contours(DEM, n.breaks = 10, return_format = "sp")

# Example 8: Complete workflow with visualization
# ------------------------------------------------
library(ggplot2)

# Create contours
contours <- create_contours(
  raster_obj = DEM,
  breaks = seq(100, 550, by = 50)
)

# Plot with ggplot2
ggplot() +
  geom_sf(data = contours, aes(color = level)) +
  scale_color_viridis_c() +
  theme_minimal() +
  labs(title = "Elevation Contours",
       color = "Elevation (m)")

# Example 9: Working with large rasters and bbox
# ------------------------------------------------
# Crop to area of interest first for efficiency
bbox_aoi <- c(xmin = 5.8, ymin = 49.55, xmax = 5.95, ymax = 49.7)
contours_aoi <- create_contours(
  raster_obj = DEM,
  n.breaks = 20,
  bbox = bbox_aoi,
  pretty_breaks = TRUE
)

plot_contours(contours_aoi, add_labels = TRUE, label_interval = 3)


