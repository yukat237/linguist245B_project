
###########THAI

# ---------------- USER SETTINGS ---------------------------------
base_path      <- "C:/Users/yuka/Desktop/QP1/THAI_SER"
dest_path      <- "C:/Users/yuka/Desktop/linguist245B_project/experiment/stim/final_stim"

# Vector of target filenames (no .wav extension)
targets <- c(
  "s001_clip_actor002_script1_2_3b","s001_clip_actor002_script2_2_3b","s001_clip_actor002_script3_2_3b",
  "s002_clip_actor004_script1_2_3b","s002_clip_actor004_script2_2_3b","s002_clip_actor004_script3_2_3b",
  "s008_clip_actor016_script1_2_3b","s008_clip_actor016_script2_2_3b","s008_clip_actor016_script3_2_3b",
  "s013_clip_actor026_script1_2_3b","s013_clip_actor026_script2_2_3b","s013_clip_actor026_script3_2_3b",
  "s001_clip_actor002_script1_2_4b","s001_clip_actor002_script2_2_4b","s001_clip_actor002_script3_2_4b",
  "s002_clip_actor004_script1_2_4b","s002_clip_actor004_script2_2_4b","s002_clip_actor004_script3_2_4b",
  "s008_clip_actor016_script1_2_4b","s008_clip_actor016_script2_2_4b","s008_clip_actor016_script3_2_4b",
  "s013_clip_actor026_script1_2_4b","s013_clip_actor026_script2_2_4b","s013_clip_actor026_script3_2_4b",
  "s001_clip_actor002_script1_2_2b","s001_clip_actor002_script2_2_2b","s001_clip_actor002_script3_2_2b",
  "s002_clip_actor004_script1_2_2b","s002_clip_actor004_script2_2_2b","s002_clip_actor004_script3_2_2b",
  "s008_clip_actor016_script1_2_2b","s008_clip_actor016_script2_2_2b","s008_clip_actor016_script3_2_2b",
  "s013_clip_actor026_script1_2_2b","s013_clip_actor026_script2_2_2b","s013_clip_actor026_script3_2_2b",
  "s001_clip_actor002_script1_2_1b","s001_clip_actor002_script2_2_1b","s001_clip_actor002_script3_2_1b",
  "s002_clip_actor004_script1_2_1b","s002_clip_actor004_script2_2_1b","s002_clip_actor004_script3_2_1b",
  "s008_clip_actor016_script1_2_1b","s008_clip_actor016_script2_2_1b","s008_clip_actor016_script3_2_1b",
  "s013_clip_actor026_script1_2_1b","s013_clip_actor026_script2_2_1b","s013_clip_actor026_script3_2_1b"
)
# ----------------------------------------------------------------

# Map second-to-last character -> emotion prefix
emo_map <- c("1" = "neutral__", "2" = "angry__", "3" = "happy__", "4" = "sad__")

# Helper: return full source file path for a given short name --------
get_source_path <- function(fname) {
  studio_code <- substr(fname, 1, 4)            # e.g. "s013"
  num         <- as.integer(substr(studio_code, 2, 4))  # 13
  top_folder  <- if (num <= 10) "studio1-10" else "studio11-20"
  sub_folder  <- sprintf("studio%03d", num)      # "studio013"
  file.path(base_path, top_folder, sub_folder, "clip", paste0(fname, ".flac"))
}

# Process each target
for (fname in targets) {
  src <- get_source_path(fname)
  
  if (!file.exists(src)) {
    warning("File not found: ", src)
    next
  }
  
  # Determine emotion prefix
  key <- substr(fname, nchar(fname) - 1, nchar(fname) - 1)  # second-to-last char
  prefix <- emo_map[key]
  if (is.na(prefix)) {
    warning("Unknown emotion code in: ", fname)
    next
  }
  
  new_name <- paste0("thai_", prefix, fname, ".flac")
  dest     <- file.path(dest_path, new_name)
  
  # Create destination dir if needed, then copy
  dir.create(dest_path, showWarnings = FALSE, recursive = TRUE)
  ok <- file.copy(src, dest, overwrite = FALSE)
  if (!ok) warning("Failed to copy: ", fname)
}

cat("Done.\n")

