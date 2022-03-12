#' Fonction resolution sudoku.
#' @param sgrid grille sudoku
#' @param mgrid matrice génératrice des blancs
#' @param blocks bloques de sudoku sous forme de liste
#' @param ultimate Outil pour la fonction solver.sudo
#' @return Matrice

solver <- function(sgrid, mgrid=NULL, blocks=list(), ultimate=F) {
  if (length(blocks)==0) { # Si le block est déjà remplis on passe à un autre
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

  s0steps <- 0
  max <- 10
  j <- 0
  while ((sum(mgrid)>0)&(j<max)) {
    j <- j+1

    # Boucle pour essayer les valeurs choisies
    for (i in 1:9) for (ii in 1:9) if (sgrid[i,ii]==0) {
      tset <- NULL
      for (iii in 1:length(blocks)) if (mgrid[i,ii]) {
        tblock <- blocks[[iii]]
        type <- tblock[i,ii]
        values <- c(sgrid[tblock==type])
        tset <- unique(c(tset, values))
      }
      remainder <- (1:9)[!(1:9 %in% tset)]
      if (length(remainder)==1) {
        mgrid[i,ii] <- 0
        sgrid[i,ii] <- fgrid[i,ii] <- remainder
        s0steps <- s0steps + 1
      }
    }}

  sudo <- list(sgrid=sgrid0, mgrid=mgrid0, s0steps=s0steps,
               fgrid=fgrid , ultimate=ultimate)
  # On enregistre ces données pour les appeler dans la fonction solver.sudoku
  class(sudo) <- "sudoku"
  return(sudo)
}
