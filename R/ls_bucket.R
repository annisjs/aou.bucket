#' List the files in a bucket directory
#' 
#' @param folder the name of the folder
#' @examples 
#' \dontrun{
#' ls_bucket() # Files in the current workspace directory
#' ls_bucket("notebooks") # Files in the "notebooks" workspace directory
#' ls_bucket("gs://fc-secure-1234") # Files in another workspace
#' }
#' @export
ls_bucket <- function(folder=NULL) {
    bucket <- Sys.getenv("WORKSPACE_BUCKET")
    if (is.null(folder))
    {
        path <- bucket
    } else {
        bucket_provided <- grepl("^gs://",folder)
        if (!bucket_provided)
        { 
            path <- stringr::str_glue("{bucket}/{folder}")
        } else {
            path <- folder
        }
    }
    system(stringr::str_glue("gsutil ls {path}"),intern=TRUE)  
}