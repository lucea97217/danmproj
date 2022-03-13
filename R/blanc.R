
#' Fonction génératrice des cases vides. Elle prend en entrée notre sudoku puis génère
#' aléatoirement des "trous" à l'aide de la créations de "blocks" temporaires. On fixe une moyenne de cases vide et un nombre maximum de cases vides
#' par défaut de façon à ce que le sudoku reste bien solvable mais il peut ces données sont modifiables.
#' @param sudo notre sudoku
#' @param freq.mean nombre moyen de blancs
#' @param freq.max pour le nombre max de blancs
#' @return Matrice
#'
blanc <- function(sudo, freq.mean=1.25, freq.max=2) {
  sgrid <- sudo$sgrid       # valeurs manquantes à la grille
  mgrid <- igrid <- sgrid*0


  blocks <- sudo$blocks
  #freq étant le nombre d'emplacements manquants d'un carré d'une grille particulier
  #après avoir pris en compte tous les carrés qui se chevauchent

  # Ici nous créons un "sudoku" temporaire
  while (mean(igrid)<freq.mean) {
    tigrid <- igrid # grilles témporaire
    tmgrid <- mgrid

    provisional <- c(sample(1:9,1), sample(1:9,1))

    tmgrid[provisional[1],provisional[2]] <- 1
    tsgrid <- sgrid*(1-tmgrid)

    for (i in 1:9) for (ii in 1:9) {
      tset <- NULL
      for (iii in 1:length(blocks)) {
        tblock <- blocks[[iii]] # BLock temporaire
        type <- tblock[i,ii]
        values <- c(tsgrid[tblock==type])
        tset <- unique(c(tset, values))
      }
      tigrid[i,ii] <- 9-sum(tset!=0)
    }

    if (max(tigrid)<=freq.max) {
      igrid <- tigrid
      mgrid <- tmgrid
    }
  }
  sudo$mgrid <- mgrid
  sudo$igrid <- igrid

  return(sudo)
}
