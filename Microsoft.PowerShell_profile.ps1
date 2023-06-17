# Define a function to change to MATH-270-45
function Go-SDEV-345-81 {
    Set-Location -Path "D:\Documents\school\Champlain\SDEV-345-81\School-SDEV-345-81"
}
# Define a function to change to SCIE-180-45
function Go-SDEV-435-81 {
    Set-Location -Path "D:\Documents\school\Champlain\SDEV-435-81\School-SDEV-435-81"
}
# Define a function to change to Project-assignment
function Go-PROJECT {
    Set-Location -Path "D:\Documents\school\Champlain\SDEV-435-81\Project-assignment"
}
function Go-COMPILE-C++() {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$1
    )
    g++ -std=c++11 "$1.cpp" -o "$1"
}

function Git-Update {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$CommitMessage
    )

    git add .
    git commit -m $CommitMessage
    git push
}

function whereis-alias {
    Write-Output "The profile script is located at: C:\Users\$env:USERNAME\OneDrive\Documents\WindowsPowerShell"
}

# Define an alias for the Go-Documents function
New-Alias -Name sdev-algo -Value Go-SDEV-345-81

# Define an alias for the Go-Documents function
New-Alias -Name sdev-proj -Value Go-SDEV-435-81

# Define an alias for the Go-Documents function
New-Alias -Name project -Value Go-PROJECT

# Define an alias to compile C++ files with g++ and c++11
New-Alias -Name compile -Value Go-COMPILE-C++


# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
