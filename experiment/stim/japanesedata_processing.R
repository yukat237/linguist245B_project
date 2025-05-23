#############jp 

# ---------------- USER SETTINGS ---------------------------------
base_path <- "C:/Users/yuka/Desktop/QP1/jvnv_ver1/jvnv_v1"
dest_path <- "C:/Users/yuka/Desktop/linguist245B_project/experiment/stim/jp_raw"
file_ext  <- ".wav"     # change to ".flac" if needed
# ----------------------------------------------------------------

# Target filenames (without extension)
targets <- c(
  # --- happy ----------------------------------------------------
  "F1_happy_regular_01","F1_happy_regular_02","F1_happy_regular_03",
  "F2_happy_regular_01","F2_happy_regular_02","F2_happy_regular_03",
  "M1_happy_regular_01","M1_happy_regular_02","M1_happy_regular_03",
  "M2_happy_regular_01","M2_happy_regular_02","M2_happy_regular_03",
  # --- sad ------------------------------------------------------
  "F1_sad_regular_01","F1_sad_regular_02","F1_sad_regular_03",
  "F2_sad_regular_01","F2_sad_regular_02","F2_sad_regular_03",
  "M1_sad_regular_01","M1_sad_regular_02","M1_sad_regular_03",
  "M2_sad_regular_01","M2_sad_regular_02","M2_sad_regular_03",
  # --- anger ----------------------------------------------------
  "F1_anger_regular_01","F1_anger_regular_02","F1_anger_regular_03",
  "F2_anger_regular_01","F2_anger_regular_02","F2_anger_regular_03",
  "M1_anger_regular_01","M1_anger_regular_02","M1_anger_regular_03",
  "M2_anger_regular_01","M2_anger_regular_02","M2_anger_regular_03",
  # --- fear -----------------------------------------------------
  "F1_fear_regular_01","F1_fear_regular_02","F1_fear_regular_03",
  "F2_fear_regular_01","F2_fear_regular_02","F2_fear_regular_03",
  "M1_fear_regular_01","M1_fear_regular_02","M1_fear_regular_03",
  "M2_fear_regular_01","M2_fear_regular_02","M2_fear_regular_03",
  # --- surprise -------------------------------------------------
  "F1_surprise_regular_01","F1_surprise_regular_02","F1_surprise_regular_03",
  "F2_surprise_regular_01","F2_surprise_regular_02","F2_surprise_regular_03",
  "M1_surprise_regular_01","M1_surprise_regular_02","M1_surprise_regular_03",
  "M2_surprise_regular_01","M2_surprise_regular_02","M2_surprise_regular_03"
)

# Maps emotion keyword -> prefix to add
prefix_map <- c(
  "happy"    = "happy__",
  "sad"      = "sad__",
  "anger"    = "angry__",
  "fear"     = "fear__",
  "surprise" = "surprise__"
)

# Make sure destination directory exists
dir.create(dest_path, showWarnings = FALSE, recursive = TRUE)

for (fname in targets) {
  # Split the filename into parts: speaker_emotion_regular_xx
  parts    <- strsplit(fname, "_")[[1]]
  speaker  <- parts[1]     # F1, F2, M1, M2
  emotion  <- parts[2]     # happy, sad, anger, fear, surprise
  
  if (!emotion %in% names(prefix_map)) {
    warning("Unknown emotion in filename: ", fname)
    next
  }
  
  src <- file.path(base_path, speaker, emotion, "regular",
                   paste0(fname, file_ext))
  
  if (!file.exists(src)) {
    warning("File not found: ", src)
    next
  }
  
  new_name <- paste0("japanese_", prefix_map[emotion], fname, file_ext)
  dest     <- file.path(dest_path, new_name)
  
  ok <- file.copy(src, dest, overwrite = FALSE)
  if (!ok) warning("Failed to copy: ", fname)
}

cat("Done.\n")
