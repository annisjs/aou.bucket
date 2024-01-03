#' Copy a file to the bucket
#' @param from the file in your local workspace to be copied
#' @param to the bucket destination
#' @examples 
#' \dontrun{
#' write.csv(c(1,2,3),"mydata.csv")
#' cp_to_bucket("mydata.csv","mydata.csv")
#' dat <- read_bucket("mydata.csv")
#' }
#' @export
cp_to_bucket <- function(from,to)
{
  bucket <- Sys.getenv("WORKSPACE_BUCKET")
  system(stringr::str_glue("gsutil cp {from} {bucket}/{to}"),intern=TRUE)
}