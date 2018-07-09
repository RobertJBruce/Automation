# Import required modules
Import-Module ActiveDirectory

# Prompt user for csv filepath
$filepath = Read-Host -Prompt "Please enter the path to your csv file"

# Import the file into a variable
$users = Import-Csv $filepath

# Loop through each row and gather info
ForEach($user in $users) {

    #Gather User info
    $fname = $user.'First Name'
    $lname = $user.'Last Name'
    $jtitle = $user.'Job Title'
    $dept = $user.Department
    $actpw = $user.AccountPassword
    $desc = $user.Description
    $orgunit = $user.'Organizational Unit'
    $samact = $user.samAccountName
    
    #Create new AD user for each user in the CSV file
    New-ADUser -Name "$fname $lname" -GivenName $fname -Surname $lname -DisplayName "$fname $lname" -UserPrincipalName "$fname.$lname" -Path $orgunit -AccountPassword $actpw -Description $desc -SamAccountName $samact
    
    # Echo output for each user
    echo "Account created for $fname $lname in $orgunit"
}