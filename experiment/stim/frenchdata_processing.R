#### take French data and add "french_emotion__"

# ------------------------------------------------------------------
# Rename .wav files in final_stim according to embedded code letters
# ------------------------------------------------------------------

# 1. Set your folder path (use forward slashes on Windows in R)
dir_path <- "C:/Users/yuka/Desktop/linguist245B_project/experiment/stim/final_stim"

# 2. Get a list of all .wav files in that folder
wav_files <- list.files(dir_path, pattern = "\\.wav$", full.names = TRUE)

# 3. A helper that returns the correct emotion prefix for each filename
emotion_prefix <- function(name) {
  if (grepl("C", name, fixed = TRUE)) {
    "angry__"
  } else if (grepl("N", name, fixed = TRUE)) {
    "neutral__"
  } else if (grepl("P", name, fixed = TRUE)) {
    "fear__"
  } else if (grepl("S", name, fixed = TRUE)) {
    "surprise__"
  } else if (grepl("T", name, fixed = TRUE)) {
    "sad__"
  } else {
    ""        # leave blank if no code letter is found
  }
}

# 4. Loop through each file and rename it
for (old_path in wav_files) {
  base <- basename(old_path)                # just the filename
  prefix <- emotion_prefix(base)            # pick the right emotion
  new_base <- paste0("french_", prefix, base)  # build new filename
  new_path <- file.path(dir_path, new_base) # full path for new name
  file.rename(old_path, new_path)           # rename in-place
}

# (Optional) print a summary of what changed
cat("Renaming complete. Files now start with 'french_<emotion>__'.\n")
