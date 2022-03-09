
#' Fonction génératrice des cases vides
#' @param sudo notre sudoku
#' @param inference.mean nombre moyen de blancs
#' @param inference.max pour le nombre max de blancs
#' @return Matrice

sudo.gaps <- function(sudo, inference.mean=1.25, inference.max=2) {
  sgrid <- sudo$sgrid       # valeurs manquantes à la grille
  mgrid <- igrid <- sgrid*0
  # inference being the number of missing slots that
  # a particular square has after taking into account
  # all overlapping squares

  blocks <- sudo$blocks

  while (mean(igrid)<inference.mean) {
    tigrid <- igrid # temporary igrid
    tmgrid <- mgrid # temporary mgrid

    provisional <- c(sample(1:9,1), sample(1:9,1))

    tmgrid[provisional[1],provisional[2]] <- 1
    tsgrid <- sgrid*(1-tmgrid) # temporary sgrid

    for (i in 1:9) for (ii in 1:9) {
      tset <- NULL
      for (iii in 1:length(blocks)) {
        tblock <- blocks[[iii]] # Temporary block
        type <- tblock[i,ii]    # Identify type of current cell
        values <- c(tsgrid[tblock==type]) # Grab values from other cells
        tset <- unique(c(tset, values)) # combine
      }
      tigrid[i,ii] <- 9-sum(tset!=0)
    }

    if (max(tigrid)<=inference.max) {
      igrid <- tigrid
      mgrid <- tmgrid
    }
  }
  sudo$mgrid <- mgrid
  sudo$igrid <- igrid

  return(sudo)
}
