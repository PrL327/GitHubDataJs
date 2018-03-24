install.packages("devtools")
library("devtools")
devtools::install_github("r-lib/gh")
library(gh)

my_repos <- gh(.token = "", "/repos/:owner/:repo/contributors", owner = repos[1,1], repo = repos[1,2])
length(my_repos)
#vapply(my_repos, "[[", "", "name")

editCSV <- function(start=1, num = 1000, rowNums = NULL)
{
  if (is.null(rowNums))
  {
    rowNums = 0:num
    for (i in rowNums)
    {
      tryCatch({
        my_repos <- gh(.token = "", "/repos/:owner/:repo/contributors", 
                       owner = repos[start+i,1], repo = repos[start+i,2], per_page = 100)
        repos[start+i, 3] <<- length(my_repos)
      },
      error=function(cond) {
        #errors <<- errors + str(cond) + "\n"
        repos[start+i, 3] <<- -1
      })
      
    }
  }
  else
  {
    for (i in rowNums)
    {
      tryCatch({
        my_repos <- gh(.token = "", "/repos/:owner/:repo/contributors", 
                       owner = repos[i,1], repo = repos[i,2], per_page = 100)
        repos[i, 3] <<- length(my_repos)
      },
      error=function(cond) {
        message(cond)
        #errors <<- errors + str(cond) + "\n"
        repos[i, 3] <<- -1
      })
      
    }
  }
}
editCSV(1, 500, which(repos[3] == -1))
editCSV(min(which(repos[3] == 0)), 287)

hist(repos$contributors[repos$contributors > 0 & repos$contributors < 20], 20,
     col = rainbow(20), xlab = "Number of contributors", main = "Frequency of number of contributors")

repos = repos[repos$contributors > 0,]
in