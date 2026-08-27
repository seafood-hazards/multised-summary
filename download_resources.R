options(timeout = 600)

# ── Summary CSVs ───────────────────────────────────────────────────────────
# Tidy tables written by analyze_data("refined", module = "summary") in
# multised-engine. Downloaded once from this repo's LATEST release; a local copy
# (e.g. copied straight from the pipeline output) is reused if present.
#
# Everything comes from the latest release, which does not fall back: EVERY
# release must carry every asset or the next render 404s. Use
# _scripts/publish-release.sh, which uploads them in one command. Set DB_RELEASE
# to pin an older release when reproducing a build.
#
# The list is NOT kept here. _scripts/release-assets.txt is the single source of
# truth, and publish-release.sh reads the same file, so uploader and downloader
# cannot drift apart.
repo <- "seafood-hazards/multised-summary"
tag  <- Sys.getenv("DB_RELEASE", "latest")
release <- if (identical(tag, "latest")) {
  sprintf("https://github.com/%s/releases/latest/download", repo)
} else {
  sprintf("https://github.com/%s/releases/download/%s", repo, tag)
}

manifest <- "_scripts/release-assets.txt"
if (!file.exists(manifest)) {
  stop("missing ", manifest, ": run the pre-render from the repository root")
}
csvs <- readLines(manifest)
csvs <- trimws(csvs)
csvs <- csvs[nzchar(csvs) & !startsWith(csvs, "#")]
csvs <- csvs[endsWith(csvs, ".csv")]
if (!length(csvs)) stop("no CSV assets listed in ", manifest)

csv_dir <- "data/summary"
dir.create(csv_dir, recursive = TRUE, showWarnings = FALSE)

for (f in csvs) {
  dest <- file.path(csv_dir, f)
  if (!file.exists(dest)) {
    download.file(file.path(release, f), dest, mode = "wb")
    message(f, " downloaded.")
  } else {
    message("Using existing ", dest)
  }
}
