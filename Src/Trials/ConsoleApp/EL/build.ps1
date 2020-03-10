dotnet ef dbcontext scaffold "Server=localhost;Database=OpenCore;UID=sa;password=get@get1" Microsoft.EntityFrameworkCore.SqlServer -f  --use-database-names --output-dir ..\Models --context-dir Context
dotnet build
