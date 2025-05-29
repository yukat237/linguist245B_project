####making a copiable list of files for expeiment.html


# -----------------------------------------------------------------
# 1.  Folder that holds the finished audio
folder_path <- "C:/Users/yuka/Desktop/linguist245B_project/experiment/stim/final_stim_scaled"

# 2.  File types you want to list (add |flac if needed)
file_pattern <- "\\.(wav|mp3)$"        # case-insensitive

# -----------------------------------------------------------------
# Get just the file names (no full paths)
files <- list.files(folder_path,
                    pattern = file_pattern,
                    ignore.case = TRUE,
                    full.names = FALSE)

# If you need the files in a deterministic order, uncomment ↓
# files <- sort(files)

# -----------------------------------------------------------------
# Prefix each name with the web-server path you want inside HTML
js_paths <- sprintf('  "stim/final_stim_scaled/%s"', files)

# Assemble the JavaScript code block
js_code <- paste0(
  "let audioFiles = [\n",
  paste(js_paths, collapse = ",\n"),
  "\n];\n"
)

# -----------------------------------------------------------------
# Print to console
#cat(js_code)

# OPTIONAL (Windows only): copy directly to clipboard
writeClipboard(js_code)
