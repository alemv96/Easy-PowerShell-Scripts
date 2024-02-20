<#
.SYNOPSIS
    Folder Creation Program
.DESCRIPTION
	This simple Powershell Script will ask the user for a path and it will
    create a folder in that path.
.NOTES
	Author: Alejandro Veloz
#>
Write-Host "You can type 'Documents' or 'Desktop' for quick folder creation, otherwise make sure to enter the exact path"

<# Ask user for Folder name#>
$name = Read-Host "Type the name of your new folder"

<#Ask user for the path where folder will be created#>
$path = Read-Host "Where would you like to create this folder?" 

<#Flag successfully created#>
$flag = 0

    if (($path -eq "Desktop") -or ($path -eq "desktop")){
        New-Item -ItemType "directory" -Path "C:\Users\aleMV\OneDrive\Desktop" -Name $name
        $flag = 1
    }elseif (($path -eq "Documents") -or ($path -eq "documents")) {
        New-Item -ItemType "Documents" -Path "C:\Users\aleMV\OneDrive\Documents" -Name $name
        $flag = 1
    }else{
        New-Item -ItemType "directory" -Path $path -Name $name
        $flag = 1
    }

    if ($flag -eq 1){
        Write-Host "Your folder has been created successfully"
    }else { Write-Host "There was an error when creating your folder, please check."}

    