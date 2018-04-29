library(stringr)
install.packages("rpart")
library(rpart)
install.packages("rpart.plot")
library(rpart.plot)


total = 0
for(d in c(".java", ".rb", ".c", ".cpp", ".cs", ".m", ".js", ".py"))
{
  total = total + nrow(file_data[endsWith(file_data$path, c),])
  cat( paste(c, nrow(file_data[endsWith(file_data$path, c),]), "\n", sep=" "))
}
print(total)


testTable = data.frame("a")
testTable$X.a. = NULL
createTable()
testModel()

createTable <- function(){
  comments = c("#COMMENT", "//COMMENT", "/*COMMENT", "/**COMMENT", "'''")
  #varDec = c("TYPE NAME = VAL", "NAME = VAL")
  arrayLength = c("NAME.length", "len(NAME)")
  printStmts = c("print(EXPR)", "System.out.print(EXPR);", "std::cout << EXPR;", "Console.WriteLine(EXPR);", "print EXPR;",
                 "console.log(EXPR);",  "puts EXPR", "printf(EXPR)")
  forLoops = c("for(TYPE NAME = VAL; BOOLEXPR; NAMECHANGE)")
  importStmt = c("import WORD")
  functions = c("def NAME(PARAMS):", "def NAME(PARAMS)", "TYPE NAME (PARAMS) {", "ACCESS TYPE NAME (PARAMS) {",
                "- (TYPE) NAME", "function NAME()")
  class = c("class NAME(PARAMS):", "import PATH;")
  usedFeatures = c(comments, arrayLength, printStmts, functions, class, importStmt, "language")
  testTable[usedFeatures] <<- NA
  langs = c("python", "java", "C", "C++", "C#", "objective-c", "javascript", "ruby")
  la = 1 # java, ruby, c, c++, c#, objective-c, javascript, python
  for(lang in c(".py", ".java", ".c", ".cpp", ".cs", ".m", ".js", ".rb"))
  {
    b = file_data[endsWith(file_data$path, lang),]
    for(i in 1:nrow(b)){
      a = b[i,]$content
      testTable[nrow(testTable)+1,] <<- c(findComments(a), findLength(a), findPrint(a), findFunction(a), findClass(a), findImport(a), 
                        langs[la])
    }
    la = la + 1
  }
  testTable <<- testTable[-1,]
}
#model creation
testModel <- function()
{
  model = rpart(language ~ ., data = testTable)
  rpart.plot(model)
  sum(predict(model, newdata = testTable, type = "class") == testTable$language)/nrow(testTable)
}

findComments <- function(s)
{
  comment1 = str_match(s, "#\\s*\\w+")
  com = c(!is.na(comment1))
  comment2 = str_match(s, "//\\s*\\w+")
  com = c(com, !is.na(comment2))
  comment3 = str_match(s, "/[*]\\s*\\w+")
  com = c(com, !is.na(comment3))
  comment4 = str_match(s, "/[*][*]\\s*\\w+")
  com = c(com, !is.na(comment4))
  comment5 = str_match(s, "'''")
  com = c(com, !is.na(comment5))
  com
}

findLength <- function(s)
{
  length1 = grepl("\\w+[.]length", s)
  com = c(length1)
  length2 = grepl("len\\(\\w+\\)", s)
  com = c(com, length2)
  com
}


#.write
findPrint <- function(s)
{
  print1 = grepl("print\\(.+)", s)
  com = c(print1)
  print2 = grepl("System.out.println(.*)", s)
  com = c(com, print2)
  print3 = grepl("puts .+", s)
  com = c(com, print3)
  print4 = grepl("printf\\(.+\\)", s)
  com = c(com, print4)
  print5 = grepl("std::cout << .+", s)
  com = c(com, print5)
  print6 = grepl("Console.WriteLine\\(.*);", s)
  com = c(com, print6)
  print7 = grepl("NSLog\\(.*\\);", s)
  com = c(com, print7)
  print8 = grepl("\\w+\\.write\\(.*\\);", s)
  com = c(com, print8)
  com
}

findFunction <- function(s)
{
  func1 = grepl("def \\w+\\s*\\(.*\\):", s)
  com = c(func1)
  func2 = grepl("def \\w+\\s*\\(.*\\)", s)
  com = c(com, func2)
  func3 = grepl("\\w+ \\w+\\s*\\(.*\\).*\\{", s)
  com = c(com, func3)
  func4 = grepl("(public|private|protected) (static)? \\w+ \\w+\\s*\\(.*\\).*\\{", s)
  com = c(com, func4)
  func5 = grepl("-\\s*\\w+:", s)
  com = c(com, func5)
  func6 = grepl("function \\w+\\(", s)
  com = c(com, func6)
  com
}

findClass <- function(s)
{
  func1 = grepl("class \\w+\\s*\\(.*\\):", s)
  com = c(func1)
  #func2 = grepl("def \\w+\\s*\\(.*\\)", s)
  #com = c(com, func2)
  com
}

findImport <- function(s){
  func1 = grepl("(from \\w+)? import \\w+", s)
  com = c(func1)
  func2 = grepl("import .+\\s*;", s)
  com = c(com, func2)
  com
}