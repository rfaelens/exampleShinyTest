# About
This package was created as an example for using `covr` together with `shinytest`
It also contains template instructions for both Docker and Travis CI.

# Explanation
Covr works by adding instrumentation to code. This instrumentation records whenever a line is executed.
When R exits, the instrumentation results are stored in a file. This file is afterwards read and converted into an HTML report (or uploaded to an external site).

When using covr in combination with shinytest, two problems arise:

1. Shinytest launches a separate process, which loads all code from scratch. Covr instrumentation is then lost.
2. Furthermore, Shiny terminates non-gracefully, not allowing covr to write out coverage results.

The solution to the first problem is to instrument code manually in the R Shiny process, as @jimhester (https://github.com/r-lib/covr/issues/277)[suggested]:
```
  registerShinyDebugHook <<- function(params) {
    covr:::replace(covr:::replacement(params$name, env = params$where))
  }
```
*This is not needed when the code is in an R package*. When using `covr::package_coverage`, the R package is installed in a temporary directory and instrumentation is added when the package is loaded. As long as this package version is used by the Shiny process (see `tests/testthat/test-shinyTest.R`), instrumentation is in place.
I have added some small extra code to ensure the package under test is always installed as a package. This is required because `shinytest` launches an external package; any code loaded by `devtools::load_all()` will not be available...

The second problem can be easily solved by terminating Shiny gracefully (see `tests/shinyTest/tests/test.R`).
```
p <- app$.__enclos_env__$private$shinyProcess
p$interrupt()
p$wait()
```

# Improvements
- In my view, a subprocess launched during testing should also have access to the code. Perhaps the subprocess should also use `devtools::load_all()`?
- It is easy to forget to gracefully close the Shiny process in `shinytest`
