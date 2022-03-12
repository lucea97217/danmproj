#' Fonction resolution sudoku
#' @param sgrid grille sudoku
#' @param mgrid .
#' @param noisily .
#' @param blocks .
#' @param smatch .
#' @param ultimate .
#' @return Matrice

solver <- function(sgrid, mgrid=NULL, noisily=F, blocks=list(), smatch=10, ultimate=F) {
  if (length(blocks)==0) { # If blocks is empty fill it
    blocks$rows <- matrix(rep(1:9, times=9), nrow=9,ncol=9)
    blocks$cols <- matrix(rep(1:9, each=9), nrow=9,ncol=9)
    cas <- function(x) rep(rep(x,each=3),3)
    blocks$box  <-  matrix(c(cas(1:3), cas(4:6), cas(7:9)), nrow=9,ncol=9)
  }

  if (all(is.null(mgrid))) {
    mgrid <- sgrid*0
    mgrid[(sgrid==0)|is.na(sgrid)] <- 1
  }

  fgrid <- sgrid*0

  sgrid0 <- sgrid
  mgrid0 <- mgrid

  s0steps <- 0 # Count the number of steps using strategy 0

  j <- 0
  while ((sum(mgrid)>0)&(j<smatch)) {
    j <- j+1

    for (i in 1:9) for (ii in 1:9) if (sgrid[i,ii]==0) {
      tset <- NULL # A temporary set to hold chosen values
      for (iii in 1:length(blocks)) if (mgrid[i,ii]) {
        tblock <- blocks[[iii]] # Temporary block
        type <- tblock[i,ii]    # Identify type of current cell
        values <- c(sgrid[tblock==type]) # Grab values from other cells
        tset <- unique(c(tset, values)) # combine
      }
      remainder <- (1:9)[!(1:9 %in% tset)]
      if (length(remainder)==1) {
        mgrid[i,ii] <- 0
        sgrid[i,ii] <- fgrid[i,ii] <- remainder
        if (noisily) print(paste("Round",j,"-sub out", i, ii, "with", fgrid[i,ii]))
        s0steps <- s0steps + 1
      }
    }}

  sudo <- list(sgrid=sgrid0, mgrid=mgrid0, s0steps=s0steps,
               fgrid=fgrid , ultimate=ultimate)
  class(sudo) <- "sudoku"
  return(sudo)
}
