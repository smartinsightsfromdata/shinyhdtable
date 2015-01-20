options(shiny.trace = T)  # change to T for trace
require(shiny)
# require(plyr)
require(shinyhdtable)
options(shiny.reactlog=TRUE)
shinyServer(function(input, output, session) {
#   validate <- function(tbl){
#     updateTableStyle(session, "tbl", "valid", 
#                      which(as.numeric(tbl$num2) < 5), 1)
#     updateTableStyle(session, "tbl", "warning", 
#                      which(as.numeric(tbl$num2) >= 5 & 
#                              as.numeric(tbl$num2) < 9), 1)
#     updateTableStyle(session, "tbl", "invalid", 
#                      which(as.numeric(tbl$num2) >= 100), 1)    
#   }
  
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

# select = TRUE ,  value = 1:10
output$hdtable2 <- shinyhdtable::renderhdtable({

  if (is.null(input$hdtable2)){
    hdtable2 <- data.frame(  val = as.numeric(11:22) ,  value = 1:12 ,vals = 31:42, months= letters[1:12], select = TRUE  ) 
    return(hdtable2)
#     m1 <- matrix(rep(TRUE,12), nrow = 1)
#     dimnames(m1) <- list(NULL, month.abb[1:12])
#     m1 <- as.data.frame(m1)
#     return(m1)
   } else {
     df1 <- hdToDf(input$hdtable2)
     # print(df1)
      updateTableStyle(session, "hdtable2", "warning", which(as.numeric(df1$value) > 4), 2)
#      updateTableStyle(session, "hdtable2", "invalid", 2, 1)
  }
    }, readOnly = T)

}) 
