# ==========================================================
# Sahil Sanjay Gawade
# 24102B2003
# BE CMPN B
# R Programming Lab
# Lab 3: Control Flow for Data Cleaning
# Lab 4: Advanced Missing Data Handling
# ==========================================================

# ==========================================================
# Lab 3: Control Flow for Data Cleaning
# ==========================================================

# Create sample heart dataset
set.seed(123)

heart_data <- data.frame(
  age = sample(30:70, 20, replace = TRUE),
  trestbps = sample(90:180, 20, replace = TRUE),
  chol = sample(150:300, 20, replace = TRUE)
)

# Introduce invalid values
heart_data$trestbps[c(3, 8)] <- c(-120, -90)     # Negative BP
heart_data$trestbps[c(5, 15)] <- c(320, 400)     # Extreme BP
heart_data$trestbps[c(10, 18)] <- NA             # Missing BP
heart_data$trestbps[12] <- 0                     # Zero BP

cat("Original Heart Data:\n")
print(heart_data)

# ----------------------------------------------------------
# BP Cleaning Function
# ----------------------------------------------------------

clean_bp <- function(bp) {
  if (is.na(bp)) {
    return(NA)
  } else if (bp <= 0) {   # changed from < 0
    return(NA)
  } else if (bp > 250) {
    return(250)
  } else {
    return(bp)
  }
}

# Apply cleaning function
heart_data$trestbps_clean <- sapply(heart_data$trestbps, clean_bp)

cat("\nCleaned BP Values:\n")
print(heart_data)

# ----------------------------------------------------------
# Error Handling using tryCatch()
# ----------------------------------------------------------

safe_mean_bp <- function(bp) {

  tryCatch({

    if (all(is.na(bp))) {
      stop("All BP values are missing.")
    }

    mean(bp, na.rm = TRUE)

  }, warning = function(w) {

    cat("Warning:", conditionMessage(w), "\n")
    return(NA)

  }, error = function(e) {

    cat("Error:", conditionMessage(e), "\n")
    return(NA)
  })
}

mean_bp <- safe_mean_bp(heart_data$trestbps_clean)

cat("\nMean BP:", mean_bp, "\n")

# ----------------------------------------------------------
# Safe Chol/BP Ratio
# ----------------------------------------------------------

safe_ratio <- function(chol, bp) {

  tryCatch({

    if (is.na(bp) || bp == 0) {
      stop("Invalid denominator (BP is zero or NA).")
    }

    chol / bp

  }, error = function(e) {

    cat("Ratio Error:", conditionMessage(e), "\n")
    return(NA)
  })
}

heart_data$chol_bp_ratio <- mapply(
  safe_ratio,
  heart_data$chol,
  heart_data$trestbps_clean
)

cat("\nChol/BP Ratio:\n")
print(heart_data$chol_bp_ratio)

# ----------------------------------------------------------
# Loop-based Cleaning
# ----------------------------------------------------------

loop_clean <- heart_data$trestbps

loop_time <- system.time({

  for (i in 1:length(loop_clean)) {

    # Skip missing values
    if (is.na(loop_clean[i])) {
      next
    }

    # Negative values become NA
    if (loop_clean[i] < 0) {
      loop_clean[i] <- NA
      next   # move to next iteration
    }

    # Values greater than 250 are capped
    if (loop_clean[i] > 250) {
      loop_clean[i] <- 250
    }
  }
})

cat("Loop Cleaned BP:\n")
print(loop_clean)

cat("Loop Time:\n")
print(loop_time)

# ----------------------------------------------------------
# Vectorized Cleaning
# ----------------------------------------------------------

vector_clean <- heart_data$trestbps

vector_time <- system.time({

  vector_clean[vector_clean < 0] <- NA
  vector_clean[vector_clean > 250] <- 250
})

cat("\nLoop Time:\n")
print(loop_time)

cat("\nVectorized Time:\n")
print(vector_time)

# ----------------------------------------------------------
# Validation
# ----------------------------------------------------------

cat("\nValidation Results\n")

cat("Missing BP:", sum(is.na(vector_clean)), "\n")
cat("Minimum BP:", min(vector_clean, na.rm = TRUE), "\n")
cat("Maximum BP:", max(vector_clean, na.rm = TRUE), "\n")
cat("Mean BP:", mean(vector_clean, na.rm = TRUE), "\n")
cat("Median BP:", median(vector_clean, na.rm = TRUE), "\n")

cat("Negative BP Remaining:", any(vector_clean < 0, na.rm = TRUE), "\n")
cat("BP >250 Remaining:", any(vector_clean > 250, na.rm = TRUE), "\n")

# Save cleaned heart dataset
write.csv(
  heart_data,
  "cleaned_heart_data.csv",
  row.names = FALSE
)

# ==========================================================
# LAB 4: ADVANCED MISSING DATA HANDLING
# ==========================================================

adult_data <- data.frame(
  age = c(25, 40, 35, 999, NA, 50, 28, NaN),
  workclass = c("Private", "", "Govt", "Private", "", "Self", "Govt", "Private"),
  hours = c(40, 50, NA, 45, 60, NaN, 38, 42)
)

cat("\nOriginal Adult Data:\n")
print(adult_data)

# ----------------------------------------------------------
# Missing Data Detection
# ----------------------------------------------------------

cat("\nNA Count:\n")
print(colSums(is.na(adult_data)))

cat("\nNaN Detection:\n")
print(sapply(adult_data, function(x) sum(is.nan(x))))

obj <- NULL
cat("\nIs NULL Object:", is.null(obj), "\n")

cat("\nBlank Strings in Workclass:\n")
print(sum(adult_data$workclass == ""))

cat("\nImpossible Age Values:\n")
print(sum(adult_data$age == 999, na.rm = TRUE))

# ----------------------------------------------------------
# Cleaning
# ----------------------------------------------------------

adult_data$age[adult_data$age == 999] <- NA

adult_data$workclass[adult_data$workclass == ""] <- "Unknown"

# ----------------------------------------------------------
# Median Imputation Function
# ----------------------------------------------------------

median_impute <- function(x) {

  med <- median(x, na.rm = TRUE)

  x[is.na(x)] <- med

  return(x)
}

adult_data$age <- median_impute(adult_data$age)
adult_data$hours <- median_impute(adult_data$hours)

adult_data <- adult_data[!is.nan(adult_data$hours), ]

# ----------------------------------------------------------
# Complete Cases
# ----------------------------------------------------------

complete_rows <- complete.cases(adult_data)

cat("\nComplete Cases:\n")
print(complete_rows)

# ----------------------------------------------------------
# Missing Summary
# ----------------------------------------------------------

cat("\nMissing Values After Cleaning:\n")
print(colSums(is.na(adult_data)))

# ----------------------------------------------------------
# Validation
# ----------------------------------------------------------

cat("\nValidation Summary\n")

cat("Age Summary:\n")
print(summary(adult_data$age))

cat("\nHours Summary:\n")
print(summary(adult_data$hours))

cat("\nWorkclass:\n")
print(table(adult_data$workclass))

# Save cleaned adult dataset
write.csv(
  adult_data,
  "cleaned_adult_data.csv",
  row.names = FALSE
)

# ==========================================================
# Conclusion
# ==========================================================

cat("\n====================================\n")
cat("Conclusion\n")
cat("====================================\n")

cat("1. BP cleaning function successfully handled invalid values.\n")
cat("2. tryCatch prevented program termination during errors.\n")
cat("3. Vectorized operations were faster than loops.\n")
cat("4. Missing values were detected and imputed correctly.\n")
cat("5. Cleaned datasets were validated and exported.\n")