#' List the files in a bucket directory
#' 
#' @param folder the name of the folder
#' @examples 
#' \dontrun{
#' ls_bucket() #files in the base workspace directory
#' ls_bucket("notebooks") #files in the "notebooks" workspace directory
#' }
#' @export
ls_bucket <- function(folder=NULL) {
  bucket <- Sys.getenv("WORKSPACE_BUCKET")
  if (is.null(folder))
  {
    system(str_glue("gsutil ls {bucket}"),intern=TRUE)
  } else {
    system(str_glue("gsutil ls {bucket}/{folder}"),intern=TRUE)
  }
}