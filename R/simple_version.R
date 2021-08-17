# Requires exiftool

pcsave <- function(filename, plot, ...){
  ggsave(filename, plot, ...)
  #hash = system("git rev-parse HEAD", intern=TRUE)
  #top_level = system("git rev-parse --show-toplevel")
  #path_to_script = funr::get_script_path()
  #
  path = rstudioapi::getSourceEditorContext()$path
  path_to_config = "~/pcsave.cfg"
  system(glue("exiftool -config {path_to_config} -ScriptPath={path} {filename}"))
}

pcopen <- function(filename) {
  path = system(glue("exiftool -ScriptPath {filename}"), intern = T) %>%
    strsplit(" +") %>%
    unlist %>%
    tail(n = 1)

  rstudioapi::navigateToFile(path)
}
