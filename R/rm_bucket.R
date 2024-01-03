#' Remove a file from the workspace bucket
#' @param path the path to the file to be deleted
#' @examples 
#' \dontrun{
#' write.csv(c(1,2,3),"mydata.csv")
#' cp_to_bucket("mydata.csv","mydata.csv")
#' rm_bucket("mydata.csv")
#' }
#' @export
rm_bucket <- function(path)
{
  bucket <- Sys.getenv("WORKSPACE_BUCKET")
  system(stringr::str_glue("gsutil rm {bucket}/{path}"),intern=TRUE)
}