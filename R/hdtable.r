#' hdToDf
#' 
#' Converts the table data passed from the client-side into a data.frame
#' 
#' @param   The input hdtable_id value.
#' @import data.table
#' @export
hdToR <- function(b) {
    # if theres is no data
    if (length(b$data) == 0) 
        return() 
    
    col.names <- unlist(b$colHeaders)

    bb <- data.table::rbindlist(b$data)
    data.table::setnames(bb,colnames(bb), col.names)
    return(bb)
}


#' hdtable
#' 
#' Creates a hdtable (handsontable)
#' 
#' @param id The id used to refer to the table input$id or output$id
#' @importFrom shiny exprToFunction  
#' @export
hdtable <- function(id) {
    tagList(   
      singleton(tags$head(
#         initResourcePaths(),
        includeCSS(system.file("bundled-css.css", package="shinyhdtable")),
        tags$script(src = 'shinyhdtable/hdtable.js'),
        tags$script(src = 'shinyhdtable/jquery.handsontable.full.js'),
        tags$link(rel = 'stylesheet',
                  type = 'text/css',
                  href = 'shinyhdtable/jquery.handsontable.full.css')
      )),
#   tagList(        
#     singleton(tags$head(tags$link(href = "shinyhdtable/jquery.handsontable.full.css", rel = "stylesheet"))),
#     singleton(tags$head(tags$script(src = "shinyhdtable/jquery.handsontable.full.js"))),
#     singleton(tags$head(tags$script(src = "shinyhdtable/hdtable.js"))),
    div(id = id, class = "hdtable")
  )    
}
 
#' Renders the hdtable.
#' 
#' @param expr The computation that leads to an output
#' @param env The env in which 
#' @param quoted To be decided
#' @param options Loads of options
#' @param readOnly A vector of TRUE/FALSE values to indicate which of the 
#'   columns should be readonly.
#'   
#' @export
renderhdtable <- function(expr, env = parent.frame(), quoted = FALSE, 
    options = NULL, readOnly = TRUE) {
    func <- shiny::exprToFunction(expr, env, quoted)
    function() {

    df <- func()  #  data to render     
    if (length(df) == 0 || is.null(df) ||
    nrow(df) == 0) {  return() }  

    json <- list(colHeaders=as.character(character()),
                     columns=as.character(character()),                           
                     data=as.numeric(character()))
            
    types <- sapply(df, typeof)
    l <- length(types)
    if(length(readOnly)!=length(types)) {
     readOnly <- rep(readOnly,length.out = l)   
    }
        
    columns <- lapply(1:l, function(i) { 
      switch(types[i],
         integer=  { list(type ="numeric", format = "0,0.00", readOnly = readOnly[i]) },
         double=   { list(type ="numeric", format = "0,0.00", readOnly = readOnly[i]) },
         numeric=  { list(type ="numeric", format = "0,0.00", readOnly = readOnly[i]) },
         character={ list(type ="text",                       readOnly = readOnly[i]) },
         logical=  { list(type ="checkbox", readOnly = FALSE)},
         factor=   { list(type ="text",   readOnly = readOnly[i]) },
         Date=     { list(type ="date",   readOnly = readOnly[i]) },
                   { list(type ="numeric", format = "0,0.00", readOnly =  readOnly[i])}
         )

     })      
    
        json$colHeaders <- colnames(df)
        json$columns <- columns
        json$data <- df
        return(json)
    }
} 
