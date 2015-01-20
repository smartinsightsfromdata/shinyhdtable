
.onLoad <- function(libname, pkgname) {
    shiny::addResourcePath("shinyhdtable", system.file("www", package = "shinyhdtable"))
    shiny::includeCSS(system.file("/bundled-css.css", package="shinyhdtable"))
}
#
# initResourcePaths <- function() {
#     shiny::addResourcePath(prefix = 'shinyhdtable',
#   directoryPath = system.file('www', package='shinyhdtable'))
#   includeCSS(system.file("bundled-css.css", package="shinyhdtable"))
#   
# }
#
# .onAttach <- function(libname, pkgname) {
#     require(shiny)    
# } 
