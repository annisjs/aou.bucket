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
#' }
cp_from_bucket <- function(from,to)
{
  bucket <- Sys.getenv("WORKSPACE_BUCKET")
  system(stringr::str_glue("gsutil cp {bucket}/{from} {to}"),intern=TRUE)
}