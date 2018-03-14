# Importing function's library for the GUI (Windosw Forms) and geomitric reference (Drawing) 

[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
## [System.Windows.Forms.Application]::EnableVisualStyles ## Utiliser le style Windows 7/10 (si la fenêtre se lance en style Win98)
 
 
function fen_accueil(){
 
# Creating GUI window with name and size

$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(640,480)
$form.Text = "Couteau suisse utilisateurs AD"

# Creating button "Rechercher"

$btnRechercher = New-Object System.Windows.Forms.Button
$btnRechercher.Name = "btnRechercher"
$btnRechercher.Text = "Search"
$btnRechercher.TabIndex = 1

# Creating button "Close"

$btnCloseF1 = New-Object System.Windows.Forms.Button
$btnCloseF1.Name = "$btnCloseF1"
$btnCloseF1.Text = "Close"
$btnCloseF1.TabIndex = 1

# Creating user input "textbox"

$textBoxF1 = New-Object “System.Windows.Forms.TextBox”

	##Defining default value for textBoxF1

$defaultValue = “”
$textBoxF1.Text = $defaultValue;

# Creating "Label"

$label_prezF1 = New-Object System.Windows.Forms.Label
$label_prezF1.Text = "Veuillez entrer le nom d'utilisateur recherché"

# Sizing

$textBoxF1.Size = New-Object System.Drawing.Size(200,200)
$btnRechercher.Size = New-Object System.Drawing.Size(70,23)
$btnCloseF1.Size = New-Object System.Drawing.Size(70,23)
$label_prezF1.Size = New-Object System.Drawing.Size(250,100)

# Positioning 

$textBoxF1.Location = New-Object System.Drawing.Point(150,10)
$btnRechercher.Location = New-Object System.Drawing.Point(225,400)
$btnCloseF1.Location = New-Object System.Drawing.Point(325,400)
$label_prezF1.Location = New-Object System.Drawing.Point(200,200)


# Event when we click on the button "Close"

$btnCloseF1.Add_Click(
{
	$form.Close();
})

# Event when we click on the button "Rechercher"

$btnRechercher.Add_Click(
{
$Error.clear()
$test1 = Get-aduser -identity $textBoxF1.Text  ## Looking for user SamAccount Name in the AD
$Nom_User = $textBoxF1.Text


if ($Error.Count -eq "0"){
	
	$GUI_Name = $test1.Name
	$GUI_SurName = $test1.SurName
	$GUI_SamAccountName = $test1.SamAccountName
	$GUI_UserPrincipalName = $test1.UserPrincipalName
	
	}


if($test1.ObjectClass -eq "user" -and [System.Windows.Forms.MessageBox]::Show("L'utilisateur '$Nom_User' existe, affichage des informations ..", "Information",[System.Windows.Forms.MessageBoxButtons]::OKCancel) -eq "OK"){
    
	fen_userknow
	
	}
	
		elseif ($Error.CategoryInfo.Category -like "ObjectNotFound" -and [System.Windows.Forms.MessageBox]::Show("L'utilisateur '$Nom_User' n'existe pas, voulez vous le créer?", "Information",[System.Windows.Forms.MessageBoxButtons]::YesNo) -eq "Yes"){
				
				$Error.Clear()
				fen_userunknow
				
				}
})


# Add components to the form

$form.Controls.Add($btnCloseF1)
$form.Controls.Add($label_prezF1)
$form.Controls.Add($btnRechercher)
$form.Controls.Add($textBoxF1)
$form.ShowDialog()
}

function fen_userknow(){
 
# Creating GUI window with name and size

$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(640,480)
$form.Text = "Affichage infos utilisateur"

# Creating button "Close"

$btnCloseF2 = New-Object System.Windows.Forms.Button
$btnCloseF2.Name = "$btnCloseF2"
$btnCloseF2.Text = "Close"
$btnCloseF2.TabIndex = 1

# Creating button "Change password"

$btnChgPwdF2 = New-Object System.Windows.Forms.Button
$btnChgPwdF2.Name = "$btnChgPwdF2"
$btnChgPwdF2.Text = "Change password"
$btnChgPwdF2.TabIndex = 1

# Creating "Label1"

$label_prezF2_1 = New-Object System.Windows.Forms.Label
$label_prezF2_1.Text = 
"
$GUI_Name

$GUI_SurName

$GUI_SamAccountName

$GUI_UserPrincipalName

"

# Sizing

$btnCloseF2.Size = New-Object System.Drawing.Size(70,23)
$btnChgPwdF2.Size = New-Object System.Drawing.Size(120,23)
$label_prezF2_1.Size = New-Object System.Drawing.Size(200,400)


# Positioning 

$btnCloseF2.Location = New-Object System.Drawing.Point(325,400)
$btnChgPwdF2.Location = New-Object System.Drawing.Point(200,400)
$label_prezF2_1.Location = New-Object System.Drawing.Point(20,20)



# Event when we click on the button "Close"

$btnCloseF2.Add_Click(
{
	$form.Close();
})

$btnChgPwdF2.Add_Click(
{
	fen_chgpwd
})

#if([System.Windows.Forms.MessageBox]::Show("Continue?", "Question",[System.Windows.Forms.MessageBoxButtons]::OKCancel) -eq "OK")
#{
#	Write-Host "OK!"
#}	




# Add components to the form

$form.Controls.Add($btnCloseF2)
$form.Controls.Add($btnChgPwdF2)
$form.Controls.Add($label_prezF2_1)
$form.ShowDialog()
}

function fen_userunknow(){
 
# Creating GUI window with name and size

$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(640,480)
$form.Text = "Creation nouvel utilisateur"

# Creating button "Close"

$btnCloseF3 = New-Object System.Windows.Forms.Button
$btnCloseF3.Name = "$btnCloseF2"
$btnCloseF3.Text = "Close"
$btnCloseF3.TabIndex = 1

# Creating button "Creer"

$btn_Create = New-Object System.Windows.Forms.Button
$btn_Create.Name = "btn_Create"
$btn_Create.Text = "Créer"
$btn_Create.TabIndex = 1

# Creating "Label1"

$label_prezF3_1 = New-Object System.Windows.Forms.Label
$label_prezF3_1.Text = 
"
Veuillez entrer les informations nécessaires à la création de l'utilisateur $Nom_User
"
# Creating "Label2"

$label_prezF3_2 = New-Object System.Windows.Forms.Label
$label_prezF3_2.Text = 
"
Prénom :
"
# Creating "Label3"

$label_prezF3_3 = New-Object System.Windows.Forms.Label
$label_prezF3_3.Text = 
"
Nom :
"

# Creating "Label4"

$label_prezF3_4 = New-Object System.Windows.Forms.Label
$label_prezF3_4.Text = 
"
Mail 'name@example.com' :
"

# Creating "Label5"

$label_prezF3_5 = New-Object System.Windows.Forms.Label
$label_prezF3_5.Text = 
"
Mot de passe : 

 Doit contenir 
   - 8 caractères
   - Au moins une majuscule
   - Des lettres
   - Des chiffres
   - Une ponctuation parmis : $ , . / \ @ # =

"

# Creating user input "textbox" READONLY

$textboxF3_RO = New-Object “System.Windows.Forms.TextBox”
$textboxF3_RO.ReadOnly = "True"

	##Defining default value for textBoxF3_1

$defaultValue = “$Nom_User”
$textboxF3_RO.Text = $defaultValue;

# Creating user input "textbox 1" PRENOM :

$textboxF3_1 = New-Object “System.Windows.Forms.TextBox”

	##Defining default value for textBoxF3_1

$defaultValue = “”
$textboxF3_1.Text = $defaultValue;

# Creating user input "textbox 2" NOM :

$textboxF3_2 = New-Object “System.Windows.Forms.TextBox”

	##Defining default value for textBoxF3_2

$defaultValue = “”
$textboxF3_2.Text = $defaultValue;

# Creating user input "textbox 3" MAIL :

$textboxF3_3 = New-Object “System.Windows.Forms.TextBox”

	##Defining default value for textBoxF3_3

$defaultValue = “”
$textboxF3_3.Text = $defaultValue;

# Creating Secure textbox for password PASSWORD :

$textboxF3_PASS = New-Object System.Windows.Forms.Textbox
$textboxF3_PASS.PasswordChar = '*'

#$secstr = $textboxF3_PASS.Text | ConvertTo-SecureString -AsPlaintText -Force

# Sizing

$textboxF3_RO.Size = New-Object System.Drawing.Size(200,200)
$textboxF3_1.Size = New-Object System.Drawing.Size(200,200)
$textboxF3_2.Size = New-Object System.Drawing.Size(200,200)
$textboxF3_3.Size = New-Object System.Drawing.Size(200,200)
$textboxF3_PASS.Size = New-Object System.Drawing.Size(200,200)
$btnCloseF3.Size = New-Object System.Drawing.Size(70,23)
$label_prezF3_1.Size = New-Object System.Drawing.Size(500,30)
$label_prezF3_2.Size = New-Object System.Drawing.Size(200,30)
$label_prezF3_3.Size = New-Object System.Drawing.Size(200,30)
$label_prezF3_4.Size = New-Object System.Drawing.Size(200,30)
$label_prezF3_5.Size = New-Object System.Drawing.Size(220,130)
$btn_Create.Size = New-Object System.Drawing.Size(70,23)

# Positioning 

$textboxF3_RO.Location = New-Object System.Drawing.Point(200,80)
$textboxF3_1.Location = New-Object System.Drawing.Point(300,120)
$textboxF3_2.Location = New-Object System.Drawing.Point(300,170)
$textboxF3_3.Location = New-Object System.Drawing.Point(300,220)
$textboxF3_PASS.Location = New-Object System.Drawing.Point(300,270)
$btnCloseF3.Location = New-Object System.Drawing.Point(325,400)
$label_prezF3_1.Location = New-Object System.Drawing.Point(10,10)
$label_prezF3_2.Location = New-Object System.Drawing.Point(50,120)
$label_prezF3_3.Location = New-Object System.Drawing.Point(50,170)
$label_prezF3_4.Location = New-Object System.Drawing.Point(50,220)
$label_prezF3_5.Location = New-Object System.Drawing.Point(50,270)
$btn_Create.Location = New-Object System.Drawing.Point(200,400)

# Event when we click on the button "Close"

$btn_Create.Add_Click(
{

Test-PasswordComplexity


 #       else{
 #			 New-ADuser -name $textboxF3_2.Text -SurName $textboxF3_1.Text -SamAccountName $Nom_User -AccountPassword $secstr -EmailAddress $textboxF3_3.Text
  #          $form.Close();
   #         }
})

$btnCloseF3.Add_Click(
{
	$form.Close();
})



	




# Adding components to the form

$form.Controls.Add($textboxF3_RO)
$form.Controls.Add($textboxF3_1)
$form.Controls.Add($textboxF3_2)
$form.Controls.Add($textboxF3_3)
$form.Controls.Add($textboxF3_PASS)
$form.Controls.Add($btnCloseF3)
$form.Controls.Add($label_prezF3_1)
$form.Controls.Add($label_prezF3_2)
$form.Controls.Add($label_prezF3_3)
$form.Controls.Add($label_prezF3_4)
$form.Controls.Add($label_prezF3_5)
$form.Controls.Add($btn_Create)

$form.ShowDialog()
}

function fen_chgpwd(){
 
# Creating GUI window with name and size

$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(640,480)
$form.Text = "Changing password of $Nom_User"

# Creating button "Change"

$btnChange_1 = New-Object System.Windows.Forms.Button
$btnChange_1.Name = "btnChange_1"
$btnChange_1.Text = "Change password"
$btnChange_1.TabIndex = 1

# Creating button "Close"

$btnCancel_1 = New-Object System.Windows.Forms.Button
$btnCancel_1.Name = "$btnCancel_1"
$btnCancel_1.Text = "Close"
$btnCancel_1.TabIndex = 1

# Creating user input "textbox" 1

$textBox_1 = New-Object “System.Windows.Forms.TextBox”
$textBox_1.PasswordChar = '*'

# Creating user input "textbox" 2

$textBox_2 = New-Object “System.Windows.Forms.TextBox”
$textBox_2.PasswordChar = '*'

# Creating "Label"

$label_prez_1 = New-Object System.Windows.Forms.Label
$label_prez_1.Text = "Veuillez saisir le nouveau mot de passe et confirmer"

# Sizing

$textBox_1.Size = New-Object System.Drawing.Size(200,200)
$textBox_2.Size = New-Object System.Drawing.Size(200,200)
$btnChange_1.Size = New-Object System.Drawing.Size(120,23)
$btnCancel_1.Size = New-Object System.Drawing.Size(70,23)
$label_prez_1.Size = New-Object System.Drawing.Size(250,100)

# Positioning 

$textBox_1.Location = New-Object System.Drawing.Point(225,200)
$textBox_2.Location = New-Object System.Drawing.Point(225,300)
$btnChange_1.Location = New-Object System.Drawing.Point(200,400)
$btnCancel_1.Location = New-Object System.Drawing.Point(325,400)
$label_prez_1.Location = New-Object System.Drawing.Point(200,125)


# Event when we click on the button "Close"

$btnCancel_1.Add_Click(
{
	$form.Close();
})

# Event when we click on the button "Rechercher"

$btnChange_1.Add_Click(
{
	if ( $textBox_1.Text -ne $textBox_2.Text ){
	
		if ( [System.Windows.Forms.MessageBox]::Show("Les mots de passe sont différents, veuillez reessayé", "Erreur critique",[System.Windows.Forms.MessageBoxButtons]::OK) -eq "OK"){
		
			}
		}
	
			elseif ( $textBox_1.Text -eq $textBox_2.Text -and [System.Windows.Forms.MessageBox]::Show("Êtes-vous sûr de vouloir modifier le mot de passe ?", "Information",[System.Windows.Forms.MessageBoxButtons]::OKCancel) -eq "OK"){
			
				$form.Close();
				#Set-ADAccountPassword -Identity $Nom_User -Reset -NewPassword $textbox_1.Text
			
			}	
		
	
})


# Add components to the form

$form.Controls.Add($btnChange_1)
$form.Controls.Add($btnCancel_1)
$form.Controls.Add($textBox_1)
$form.Controls.Add($textBox_2)
$form.Controls.Add($label_prez_1)
$form.ShowDialog()
}

function Test-PasswordComplexity { 

    $passcheck = $textboxF3_PASS.Text
    $passLength = 8 
    $pass = 0 
    
    #checks password length 
    :Checkpass Do { 
        If ($passcheck.Length -lt $passLength) { 
            Write-Host "Password is not long enough. Minimum password length is 8 characters" -f Red 
         
        } 
        Else { 
            $isGood = 0 
            #checks password for special characters 
            write-host "Check for special characters!" -f Yellow 
            If ($passcheck -match "$,./\@#=") {  
                write-host "Password contains special characters." -f Green 
                $isGood++  
            }  
            If ($passcheck -notmatch "$,./\@#=") {  
                write-host "Password does not contain any special character." -f Red  
            }  
            write-host "Verify that 0-9 is in the password!" -f Yellow 
            If ($passcheck -match "[0-9]") {  
                write-host "Password contains 0-9." -f Green 
                $isGood++  
            } 
            If ($passcheck -notmatch "[0-9]") {  
                write-host "Password does not contain 0-9." -f Red 
            } 
            write-host "Verify that a-z is in the password!" -f Yellow 
            If ($passcheck -match "[a-z]") {  
                write-host "Password contains a-z." -f Green 
                $isGood++  
            } 
            If ($passcheck -notmatch "[a-z]") {  
                write-host "Password contains not a-z." -f Red 
            } 
            write-host "Verify that A-Z is in the password!" -f Yellow 
            If ($passcheck -cmatch "[A-Z]") {  
                write-host "Password contains A-Z!" -f Green 
                $isGood++  
            } 
            If ($passcheck -cnotmatch "[A-Z]") {  
                write-host "Password does not contain A-Z." -f Red 
            } 
   
            If ($isGood -lt 3) { 
                Write-Host ""  
                Write-Host "The password does not meet the minimum complexity requirements. Network security is more important than convenience!" -f Red 
                 
            } 
            Else { 
                Write-Host "$passcheck, meets the minimum complexity requirements." -f Green 
                $pass++  
     
            } #end special character check 
        } #end if statement password length 
    } while ($pass -eq 1) #end Do loop 
} #end function


$Error.Clear()
fen_accueil









