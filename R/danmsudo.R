#' Fonction génératrice de sudoku
#' @param seed aléa création sudoku
#' @param attempt compteur
#' @param ultimate pour accentuer la teinte foncée de certaines cases
#' @param iterate On regarde si notre sudoku est solvable
#' @return Matrice

danmsudo <- function(seed=NULL, attempt=1, ultimate=F, iterate=T){

  blocks <- list() # Creation d'une liste de base pour mettre en place le sudoku

  #Initilatisation sudoku
  blocks$rows <- matrix(rep(1:9, times=9), nrow=9,ncol=9)
  blocks$cols <- matrix(rep(1:9, each=9), nrow=9,ncol=9)

  # Identification des cases de sudoku
  cas <- function(x) rep(rep(x,each=3),3)
  #Séparation des blocks de sudoku
  blocks$box  <-  matrix(c(cas(1:3), cas(4:6), cas(7:9)), nrow=9,ncol=9)

  #Ici on définit le fait qu'une carré ne peut pas avoir le même
  #élément qu'un des autres carrées occupant le même espace
  casudo <- function(x) rep(rep(x),3)

  #coloration case
  if (ultimate)
  {blocks$ultimate <- matrix(c(casudo(1:3), casudo(4:6), casudo(7:9)), nrow=9,ncol=9)}

  Fset <- 1:9 #Nombre allant de 1 à 9

  #Fonction supprimer un ensemble d'un autre ensemble
  ss <- function(set,less) set[!set%in%less]

  #si seed est non nul alors on pose la graine aléatoire
  if (!is.null(seed))
  {set.seed(seed)}
  fail <- F #Indicateur en cas d'échec

  sgrid <- matrix(NA,nrow=9,ncol=9)
  # Boucle grâce à laquelle on complètera chaque cellule
  for (i in 1:nrow(sgrid)) for (ii in 1:ncol(sgrid)) if (!fail) {
    tset <- Fset # Créations de variables temporaires pour compléter le sudoku
    for (iii in 1:length(blocks)) {
      tblock <- blocks[[iii]] # Block temporaire
      type <- tblock[i,ii]    # Identification de la cellule courante
      values <- c(sgrid[tblock==type]) # On observe les valeurs des autres cellules
      tset <- ss(tset, values) # On complète tset
    }
    if (length(tset)==0) fail=T # Si on manque de valeurs l'essai a échoué
    if (length(tset)>0) sgrid[i,ii] <- sample(rep(tset,2),1)

  }
  # On observe si notre algo trouve une solution
  # On pose un compteur
  if (fail) {
    if (iterate) {
      cat(paste("Attempt",attempt,"failed\n"))
      return(danmsudo(attempt=attempt+1, ultimate=ultimate, iterate=iterate))
    }
    if (!iterate) return("Fail")
  } else {
    returner <- list(sgrid=sgrid, blocks=blocks, ultimate=ultimate, attempt=attempt)
    class(returner) <- "sudoku"
    return(returner)
  }
}

