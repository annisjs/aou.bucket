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
read_bucket <- function(file) {
    col_types <- NULL
    #Check if the bucket is provided. If not, append.
    bucket_provided <- grepl("^gs://",file)
    if (!bucket_provided)
    {
        bucket <- Sys.getenv("WORKSPACE_BUCKET")
        file <- stringr::str_glue("{bucket}/{file}")
    }
    files <- system2('gcloud storage', args = c('ls', file), stdout = TRUE, stderr = TRUE)
    f <- basename(files)
    system(paste0(c("gcloud storage -m cp ",files,"."),collapse=" "),intern=T)
    dat_list <- lapply(f,data.table::fread)
    lapply(f,file.remove)
    out <- data.table::rbindlist(dat_list)
    return(out)
}