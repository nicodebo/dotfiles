# Start colorout and setwidth when using R with vim
   if(interactive()){
       # Use text based web browser to navigate through R docs after help.start():
       if(Sys.getenv("NVIMR_TMPDIR") != ""){
       # Suggested libraries:
       library(colorout)
			 library(setwidth)
       options(browser = function(u) .C("nvimcom_msg_to_nvim",
                                            paste0('StartTxtBrowser("w3m", "', u, '")')))
			}
   }
# http://www.r-bloggers.com/fun-with-rprofile-and-customizing-r-startup/
# If stringsAsFactors hasn’t bitten you yet, it will.
#options(stringsAsFactors=FALSE)
 
options(max.print=200)

options(prompt="> ")
options(continue="... ")

# Change the default behavior of “q()” to quit immediately and not save workspace.
q <- function (save="no", ...) {
  quit(save=save, ...)
	}
# https://stackoverflow.com/questions/8475102/set-default-cran-mirror-permanent-in-r
options(repos=structure(c(CRAN="https://pbil.univ-lyon1.fr/CRAN/")))

# This snippet allows you to tab-complete package names for use in “library()” or “require()” calls. Credit for this one goes to @mikelove.
utils::rc.settings(ipck=TRUE)
