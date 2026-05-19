#' Read bucket
#' 
#' @param file the file name
#' 
#' @return a data.table
#' 
#' @examples
#' \dontrun{
#' dat <- read_bucket("my_data.csv")
#' }
#' @export
read_bucket <- function(file, verbose = FALSE) {
    col_types <- NULL
    #Check if the bucket is provided. If not, append.
    bucket_provided <- grepl("^gs://",file)
    if (!bucket_provided)
    {
        bucket <- Sys.getenv("WORKSPACE_BUCKET")
        file <- stringr::str_glue("{bucket}/{file}")
    }
    files <- system2('gcloud', args = c('storage ls', file), stdout = TRUE, stderr = TRUE)
    f <- basename(files)
    tmp_dir <- file.path(system("echo $HOME", intern = T), "workspace")
    dir.create(tmp_dir, showWarnings = FALSE)
    if (length(files)>500){
        file_splits = split(files, ceiling(seq_along(files)/500))
        lapply(file_splits,function(file_split){system(paste0(c("gcloud storage cp ", file_split, tmp_dir),collapse=" "),intern=T)})
    }else{
        system(paste0(c("gcloud storage cp", files, tmp_dir), collapse = " "), intern = T)
    }
    f <- file.path(tmp_dir, f)
    if (verbose) pb <- txtProgressBar(min = 0, max = length(files), initial = 0, style = 3)
    dat_list <- NULL
    for (i in seq_along(f))
    {
        dat_list[[i]] <- data.table::fread(f[i])
        if (verbose) setTxtProgressBar(pb, i)
    }
    data.table::rbindlist(dat_list)
    lapply(f, file.remove)
    out <- data.table::rbindlist(dat_list)
    return(out)
}