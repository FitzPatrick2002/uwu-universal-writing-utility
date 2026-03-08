function uwu($filePath){
>>  #TODO:
>>  # 1.(ok) Line numbers
>>  # 2.(ok) Delete specific line -> delete [12]
>>  # 3.(ok) Insert after line    -> insert [12] "Some content"
>>  # 4.(ok) Edit specific line   -> edit [12]
>>  # 5. Write helpers to make array operations easier -> separate module?
>>  # 6.(ok) Write help (like in nano but display on top)
>>  # 7. Text coloring based on syntax (cpp for now) (int, void, function(), ...)
>>      $userInput = "";
>>      while($True){
>>           #Print the file contents
>>           Clear-Host
>>           Write-Host "File content:"
>>           $line = 0
>>           $content = Get-Content $filePath
>>           $content | ForEach-Object{Write-Host ([String]$line + "> " + $_); $line++}
>>
>>           # Tutorial
>>           Write-Host "# ------------------------ COMMANDS ------------------------ #"
>>           Write-Host "# Commands: delete [x], insert [x] 'text', edit [x], exit"
>>
>>           #Store the user input
>>           $userInput = Read-Host
>>
>>           # Check the user command
>>           if($userInput.equals("exit")) {break}
>>           elseif($userInput.equals("clear")) {
>>                Clear-Content $filePath
>>           }
>>           elseif($userInput -match "delete \[(\d+)\]"){
>>                $content = $content[0..([int]$Matches.1 - 1) + ([int]$Matches.1 + 1)..$content.Length];
>>                $content | Out-File -FilePath $filePath
>>                # Write-Host "Deleted line number: " + [String]([int]$Matches.1 - 1);
>>                # Start-Sleep -Seconds 2.0
>>           }
>>           elseif($userInput -match "insert \[(\d+)\] (.+)"){
>>                $content = $content[0..([int]$Matches.1)], $Matches.2, $content[([int]$Matches.1 + 1)..($content.Length - 1)];
>>                $content | Out-File $filePath;
>>                # Start-Sleep -Seconds 0.5;
>>           }
>>           elseif($userInput -match "edit \[(\d+)\]"){
>>                  [void][System.Windows.Forms.SendKeys]::sendWait($content[([int]$Matches.1)]);
>>                  $userInput = Read-Host -Prompt "Edited line: ";
>>                  $content = $content[0..([int]$Matches.1 - 1)], $userInput, $content[([int]$Matches.1 + 1)..($content.Length - 1)];
>>                  $content | Out-File -FilePath $filePath
>>                  # Start-Sleep -Seconds 5.0
>>           }
>>           else{
>>                # Append the content to the file
>>                $userInput | Out-File -FilePath $filePath -Append
>>           }
>>      }
>>  }