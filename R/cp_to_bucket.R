#' Copy a file to the bucket
#' @param from the file in your local workspace to be copied
#' @param to the bucket destination
#' @examples 
#' \dontrun{
#' write.csv(c(1,2,3),"mydata.csv")
#' cp_to_bucket("mydata.csv","mydata.csv")
#' dat <- read_bucket("mydata.csv")
#' 
#' # Copy to an arbitrary bucket
#' cp_to_bucket("myfile.csv","gs://fc-secure-123/myfile.csv")
#' }
#' @export
cp_to_bucket <- function(from,to)
{
    bucket <- Sys.getenv("WORKSPACE_BUCKET")
    bucket_provided <- grepl("^gs://",to)
    if (!bucket_provided)
    {
        to <- stringr::str_glue("{bucket}/{to}")
    }
    system(stringr::str_glue("gsutil cp {from} {to}"),intern=TRUE)
}