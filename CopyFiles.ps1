<#
.SYNOPSIS
    Copy Files
.DESCRIPTION
	This simple Powershell Script will copy one or several files to a new directory. 
	It also will copy a full directory to a specific path.
.NOTES
	Author: Alejandro Veloz
	- Find a way to optimize this code. It works, but it can be written in a better way. 
#>

<#Function that returns true or false if the file exists in the specific path#>
function Check_Exist{
	#parameters:
	#param($destinationPath,$filePath)

	#Get the file name so we can confirm it exists.
	$pathName = Split-Path -Path $path -Leaf
	
	#Create the new file path
	$newPath = $destinationPath + "\" + $pathName
	
	#Test path and check if file exists:
	return Test-Path $newPath
}
#Explains the user how to use the script.
Write-Host "You can type 'Documents' or 'Desktop' for quick folder creation, otherwise make sure to enter the exact path"

#Ask user if they would like to copy one file, several files in a folder or all the files in the folder
$fileOrFolder = Read-Host "Please specify if you would like to copy a file, different files or a folder (file / files / folder)"

# Ask user for Folder name
#$name = Read-Host "Type the name of the folder you would like to move"

	if(($fileOrFolder -eq "file") -or ($fileOrFolder -eq "File")){
		#Note to self: I may call a function, instead of doing it here
		#Ask user where the file is located
		$path = Read-Host "Please specify full path of your file"

		#ASk the user where is the file going to be copied (Full Path)
		$destinationPath = Read-Host "Please provide full destination path (Where do you want this file copied?)" 

		#Copy file and show a message if it was successful
		Copy-Item -path $path -Destination $destinationPath

		#Variable that receives a boolean value if the file exists in that path.
		$fileExists = Check_Exist($destinationPath, $path)

			#Conditional to verify file was successfully copied in this path. 
			if ($fileExists){
				Write-Host "Your file has been copied successfully"
			}else{
				Write-Host "There was an error when trying to copy your file. Please check and try again later."
			}

	}elseif (($fileOrFolder -eq "files") -or ($fileOrFolder -eq "Files")){
		#Ask the user for the files location:
		$filesPath = Read-Host "Specify folder path, where your files are located"

		#Ask user for destination path:
		$destinationFolder = Read-Host "Please provide the destination folder path"

		#ask user to select files using out-grid
		$selectedFiles = Get-ChildItem -Path $filesPath | Out-GridView -Title "Select Files To Copy" -OutputMode Multiple

		if ($selectedFiles){
			#Work with the files and move it to a destination:
			foreach($file in $selectedFiles){
				$destinationPath = Join-Path -Path $destinationFolder -ChildPath $file.Name
				Copy-Item -Path $file.FullName -Destination $destinationPath -Force
				Write-Host "File $($file.Name) copied to $($destinationPath)"
			}

			#show message to user stating the script worked:
			Write-Host "Files were copied successfully."
		}else{
			Write-Host "Files were not selected. Script is being cancelled."
		}
	}else{
		#Ask user where the directory is located
		$path = Read-Host "Please specify full path of your directory"

		#ASk the user where is the file going to be copied (Full Path)
		$destinationPath = Read-Host "Please provide full destination path (Where do you want this directory copied?)" 

		#Make sure the user understands the whole directory including files will be copied. 
		$answer = Read-Host "this is going to copy every file within this directory, are you sure you would like to continue? (Y) / (N) "

			if(($answer -eq "y") -or ($answer -eq "Y")){
				Copy-Item -Path $path -Destination $destinationPath -Recurse
				$directoryExists = Check_Exist($destinationPath, $path)

					#Conditional to verify file was successfully copied in this path. 
					if ($directoryExists){
						Write-Host "Your Directory has been copied successfully"
					}else{
						Write-Host "There was an error when trying to copy your directory. Please check and try again later."
					}
			}
	}
