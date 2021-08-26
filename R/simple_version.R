# Requires exiftool

#' Save a PDF plot along with the name of the file used to create it.
#' @param filename Destination to save the plot. Must be a PDF.
#' @param plot GGplot object to save.
#' @param ... Other arguments which are passed directly to ggplot2::ggsave
#'
#' @importFrom ggplot2 ggsave
#' @importFrom rstudioapi getSourceEditorContext
#' @importFrom glue glue
#' @export
ggsave <- function(filename, plot, ...){
  ggplot2::ggsave(filename, plot, ...)

  if(rstudioapi::isAvailable()){
    path = rstudioapi::getSourceEditorContext()$path
    path_to_config = system.file("extdata", "pcsave.cfg", package = "ggsource", mustWork = T)
    system(glue("exiftool -config {path_to_config} -ScriptPath={path} {filename}"))
  } else{
    print("It looks like you aren't using RStudio.\n\n I've saved your plot, but haven't included the filename in it. See the documentation")
  }

}

#' Recover the source code used to create a plot.
#'
#' @param filename Path to PDF plot generated with ggsource::ggsave.
#' @importFrom glue glue
#' @importFrom rstudioapi isAvailable navigateToFile
#' @importFrom magrittr %>%
#'
#' @return Either opens the file in Rstudio or prints the path.A
#' @export
ggsource <- function(filename) {
  path = system(glue("exiftool -ScriptPath {filename}"), intern = T) %>%
    strsplit(" +") %>%
    unlist %>%
    tail(n = 1)

  if(rstudioapi::isAvailable()){
    rstudioapi::navigateToFile(path)
  } else{
    print(glue("Your plot was created from {path}"))
  }
}
