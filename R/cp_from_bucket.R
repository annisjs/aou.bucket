#' Copy a file from the bucket to your local workspace
#' @param from the bucket file to be copied
#' @param to the destination on your local workspace
#' 
#' @export
#' @examples 
#' \dontrun{
#' write.csv(c(1,2,3),"mydata.csv")
#' cp_to_bucket("mydata.csv","mydata.csv")
#' file.remove("mydata.csv")
#' list.files() # mydata.csv is not listed
#' cp_from_bucket("mydata.csv",".")
#' list.files() # mydata.csv has been copied
#' 
#' # Copy from an arbitrary bucket
#' cp_from_bucket("gs://fc-secure-123/myfile.csv","myfile.csv") 
#' }
cp_from_bucket <- function(from,to)
{
    bucket <- Sys.getenv("WORKSPACE_BUCKET")
    bucket_provided <- grepl("^gs://",from)
    if (!bucket_provided)
    {
        from <- stringr::str_glue("{bucket}/{from}")
    }
    system(stringr::str_glue("gcloud storage cp {from} {to} --gzip-in-flight-all"),intern=TRUE)
}