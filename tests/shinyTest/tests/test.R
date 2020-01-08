library(shinytest)

app <- ShinyDriver$new("..")
app$snapshotInit("test")
app$snapshot(filename = "start")

# wait for the process to close gracefully
# this allows covr to write out the coverage results
p <- app$.__enclos_env__$private$shinyProcess
p$interrupt()
p$wait()
