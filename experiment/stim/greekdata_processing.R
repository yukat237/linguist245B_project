#########GREEK

# ---------------- USER SETTINGS -------------------------------
base_path <- "C:/Users/yuka/Desktop/QP1/AESDD"
dest_path <- "C:/Users/yuka/Desktop/linguist245B_project/experiment/stim/final_stim"
file_ext  <- ".wav"   # change to ".flac" if needed
# ----------------------------------------------------------------

# Target filenames (without extension)
targets <- c(
  "h10 (1)","h10 (2)","h10 (3)","h10 (4)",
  "h12 (1)","h12 (2)","h12 (3)","h12 (4)",
  "h14 (1)","h14 (2)","h14 (3)","h14 (4)",
  "s10 (1)","s10 (2)","s10 (3)","s10 (4)",
  "s12 (1)","s12 (2)","s12 (3)","s12 (4)",
  "s14 (1)","s14 (2)","s14 (3)","s14 (4)",
  "a10 (1)","a10 (2)","a10 (3)","a10 (4)",
  "a12 (1)","a12 (2)","a12 (3)","a12 (4)",
  "a14 (1)","a14 (2)","a14 (3)","a14 (4)",
  "f10 (1)","f10 (2)","f10 (3)","f10 (4)",
  "f12 (1)","f12 (2)","f12 (3)","f12 (4)",
  "f14 (1)","f14 (2)","f14 (3)","f14 (4)"
)

# Map first letter -> sub-folder + emotion prefix
folder_map <- c(
  "h" = "happiness",
  "s" = "sadness",
  "a" = "anger",
  "f" = "fear"
)
prefix_map <- c(
  "h" = "happy__",
  "s" = "sad__",
  "a" = "angry__",
  "f" = "fear__"
)

# Make sure destination exists
dir.create(dest_path, showWarnings = FALSE, recursive = TRUE)

for (fname in targets) {
  first_letter <- tolower(substr(fname, 1, 1))
  sub_folder   <- folder_map[first_letter]
  emo_prefix   <- prefix_map[first_letter]
  
  if (is.na(sub_folder) || is.na(emo_prefix)) {
    warning("Unknown emotion code in filename: ", fname)
    next
  }
  
  src <- file.path(base_path, sub_folder, paste0(fname, file_ext))
  
  if (!file.exists(src)) {
    warning("File not found: ", src)
    next
  }
  
  new_name <- paste0("greek_", emo_prefix, fname, file_ext)
  dest     <- file.path(dest_path, new_name)
  
  ok <- file.copy(src, dest, overwrite = FALSE)
  if (!ok) warning("Failed to copy: ", fname)
}

cat("All done.\n")

