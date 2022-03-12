#' Sous fonction de solver servant à afficher la solution finale
#' @param sudo notre sudoku
#' @param ... appel à la fonction solver. voir help(solver)
#' @return Matrice



solver.sudoku <- function(sudo,...) {
  mgrid <- sudo[["mgrid"]]
  tigrid <- sgrid <- fgrid <- mgrid*0

  sgrid[!mgrid] <- sudo[["sgrid"]][!mgrid]

  blocks <- sudo[["blocks"]]



  solver(sgrid=sgrid, mgrid=mgrid, blocks=blocks, ultimate=sudo$ultimate, ...)
}
