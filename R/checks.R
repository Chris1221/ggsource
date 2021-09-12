#' A simple check for exiftool
#'
#' @description Ideally this is not breaking, i.e. does not cause an error immediately. The behaviour of ggsave should default to ggplot2::ggsave if exiftool is not available, because we don't want to disturb the workflow unncessasarily.
#' @export
check_exiftool <- function(toolname = "exiftool"){
  status = system(toolname, intern = F, ignore.stdout = T, ignore.stderr = T)

  if(status != 0){
    stop(glue("{toolname} is not available on your system, so I can't do anything extra right now.  Please install it from https://exiftool.org/.\n\n If you were trying to save a plot, it will still be saved."))
  } else{
    return(TRUE)
  }
}
