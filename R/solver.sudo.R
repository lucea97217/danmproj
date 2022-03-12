#' Fonction resolution sudoku
#' @param sudo notre sudoku
#' @param ... appel à la fonction solver. voir help(solver)
#' @return Matrice

# Control the difficulty of the tables by setting the inference mean
# The higher the number the more spaces there will be.
# We can see that ultimate sudoku has a few more missing spaces for
# the mean inference because inference can be made using 4 dimensions rather
# than 3.

solver.sudoku <- function(sudo,...) {
  mgrid <- sudo[["mgrid"]]
  tigrid <- sgrid <- fgrid <- mgrid*0

  sgrid[!mgrid] <- sudo[["sgrid"]][!mgrid]

  blocks <- sudo[["blocks"]]



  solver(sgrid=sgrid, mgrid=mgrid, blocks=blocks, ultimate=sudo$ultimate, ...)
}
