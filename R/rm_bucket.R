#' Remove a file from the workspace bucket
#' @param path the path to the file to be deleted
#' @examples 
#' \dontrun{
#' write.csv(c(1,2,3),"mydata.csv")
#' cp_to_bucket("mydata.csv","mydata.csv")
#' rm_bucket("mydata.csv")
#' 
#' # Remove file from arbitrary bucket
#' rm_bucket("gs://fc-secure-123/myfile.csv")
#' }
#' @export
rm_bucket <- function(path)
{
    bucket <- Sys.getenv("WORKSPACE_BUCKET")
    bucket_provided <- grepl("^gs://",path)
    if (!bucket_provided)
    {
        path <- stringr::str_glue("{bucket}/{path}")
    }
    system(stringr::str_glue("gsutil rm {path}"),intern=TRUE)
}