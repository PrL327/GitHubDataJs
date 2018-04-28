
file_data2 = file_data[endsWith(file_data$path, ".java"),]
total = 0
for(c in c(".java", ".rb", ".c", ".cpp", ".cs", ".m", ".js", ".py"))
{
  total = total + nrow(file_data[endsWith(file_data$path, c),])
  cat( paste(c, nrow(file_data[endsWith(file_data$path, c),]), "\n", sep=" "))
}
print(total)