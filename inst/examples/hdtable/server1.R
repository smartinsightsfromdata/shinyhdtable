options(shiny.trace = T)  # change to T for trace
require(shiny)
require(shinyhdtable)

shinyServer(function(input, output, session) {
  validate <- function(tbl){
    updateTableStyle(session, "tbl", "valid", 
                     which(as.numeric(tbl$num2) < 5), 1)
    updateTableStyle(session, "tbl", "warning", 
                     which(as.numeric(tbl$num2) >= 5 & 
                             as.numeric(tbl$num2) < 9), 1)
    updateTableStyle(session, "tbl", "invalid", 
                     which(as.numeric(tbl$num2) >= 100), 1)    
  }
  
    # hotable
#     output$hdtable1 <- shinyhdtable::renderhdtable({
#          head(iris)
# 
# #       tbl <- data.frame(  select = TRUE ,  value = 1:10 ) 
# #       tbl
# 
# #       m1 <- matrix(rep(TRUE,12), nrow = 1)
# #       dimnames(m1) <- list(NULL, month.abb[1:12])
# #       m1 <- as.data.frame(m1)
# #       m1
#     }, readOnly = FALSE)

#
output$hdtable2 <- shinyhdtable::renderhdtable({
  if (is.null(input$hdtable2)){
    hdtable2 <- data.frame(  val = 11:20 ,  value = 1:10 ,vals = 31:40 ) 
    updateTableStyle(session, "hdtable2", "warning", which(as.numeric(hdtable2$value) > 4), 1)
        return(hdtable2)
#     m1 <- matrix(rep(TRUE,12), nrow = 1)
#     dimnames(m1) <- list(NULL, month.abb[1:12])
#     m1 <- as.data.frame(m1)
#     return(m1)
  } else {
    updateTableStyle(session, "hdtable2", "missing", 2, 1)
  }


    }, readOnly = FALSE)

}) 
