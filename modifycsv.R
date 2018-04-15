install.packages("devtools")
install.packages("")
library("devtools")
devtools::install_github("r-lib/gh")
library(gh)

my_repos <- gh(.token = "", "/repos/:owner/:repo/contributors", owner = repos[1,1], repo = repos[1,2])
length(my_repos)
#vapply(my_repos, "[[", "", "name")

my_commits <- gh(.token = "a52c5f8f7fa691d198d8f66572326d96726dd269", "/repos/:owner/:repo/commits", owner = repos[1,1], repo = repos[1,2])

getAuthor <- function(owner, repo)
{
  tryCatch({
    my_commits <- gh(.token = "a52c5f8f7fa691d198d8f66572326d96726dd269", "/repos/:owner/:repo/commits", owner = owner, repo = repo)
    repos[start+i, 3] <<- length(my_commits)
    
  },
  error=function(cond) {
    return()
  })
  if(is.null(my_commits)){
  for(i in 1:length(my_commits))
  {
    repo_commits[nrow(repo_commits)+1,] <<- c(repo, my_commits[1][[1]][[2]][["author"]][["name"]], my_commits[1][[1]][[2]][["author"]][["date"]])
  }
  }
#
}
editCommitCSV <- function(start= 1, num=1000, numRows = null)
{
  if (is.null(rowNums)){
    rowNums = 0:num
    for(i in rowNums)
    {
      tryCatch({
        my_commits <- gh(.token = "", "/repos/:owner/:repo/commits", 
                         owner = repos[1,1], repo = repos[1,2])
        repos[start+i, 3] <<- length(my_commits)
        
      },
      error=function(cond) {
        repos[start+i, 3 <<- -1]
        
      })
    }
  }
  else {
    for (i in rowNums)
    {
      tryCatch({
        my_commits <- gh(.token = "", "/repos/:owner/:repo/commits", 
                       owner = repos[i,1], repo = repos[i,2], per_page = 100)
        repos[i, 3] <<- length(my_commits)
      },
      error=function(cond) {
        message(cond)
        #errors <<- errors + str(cond) + "\n"
        repos[i, 3] <<- -1
      })
    }  
  }
}

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

repo_commits = data.frame()
repo_commits$repo = character()
repo_commits$author = character()
repo_commits$timestamp = character()
repo_commits$repo = as.character(repo_commits$repo)
repo_commits$author = as.character(repo_commits$author)
repo_commits$timestamp = as.character(repo_commits$timestamp)

rows = function(tab) lapply(
  seq_len(nrow(tab)),
  function(i) unclass(tab[i,,drop=F])
)

for(a in rows(repos)){
  print(a$usernames)
  getAuthor(a$usernames, a$repos)
}