#' @export
c.units <- function(..., recursive = FALSE) {
  args <- list(...)
  u = units(args[[1]])
  if (length(args) > 1)
    for (i in 2:length(args)) {
      if (!inherits(args[[i]], "units"))
        stop(paste("argument", i, "is not of class units"))
      if (!ud.are.convertible(units(args[[i]]), u))
        stop(paste("argument", i, 
                   "has units that are not convertible to that of the first argument"))
      units(args[[i]]) = u
    }
  x = unlist(args)
  as.units(x, u)
}


.as.units = function(x, value) {
  x = unclass(x)
  class(x) = "units"
  attr(x, "units") = value
  x
}

#' @export
diff.units = function(x, ...) { 
  u = units(x)
  # units(x) = u will not work here, as units(x) is NULL!
  .as.units(NextMethod(), u)
}