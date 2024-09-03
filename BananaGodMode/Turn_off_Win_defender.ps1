Add-Type -AssemblyName System.Windows.Forms

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Windows Defender Manager"
$form.Size = New-Object System.Drawing.Size(450,350)
$form.StartPosition = "CenterScreen"

# Add a paint event to create a gradient background
$form.Add_Paint({
    $graphics = $_.Graphics
    $rect = New-Object System.Drawing.Rectangle(0, 0, $form.Width, $form.Height)
    
    $color1 = [System.Drawing.Color]::FromArgb(255, 102, 178)   # Pink
    $color2 = [System.Drawing.Color]::FromArgb(51, 153, 255)    # Blue
    $color3 = [System.Drawing.Color]::FromArgb(102, 255, 178)   # Green
    
    $brush1 = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect, $color1, $color2, 45)
    $brush2 = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect, $color2, $color3, 135)
    
    $graphics.FillRectangle($brush1, $rect)
    $graphics.FillRectangle($brush2, $rect)
})

# Set font
$font = New-Object System.Drawing.Font("Segoe UI",10,[System.Drawing.FontStyle]::Regular)

# Create a header label
$header = New-Object System.Windows.Forms.Label
$header.Text = "Select the Windows Defender features to disable:"
$header.Font = New-Object System.Drawing.Font("Segoe UI",12,[System.Drawing.FontStyle]::Bold)
$header.Size = New-Object System.Drawing.Size(400,40)
$header.Location = New-Object System.Drawing.Point(25,20)
$header.ForeColor = [System.Drawing.Color]::Black

# Create checkboxes
$checkboxRealtime = New-Object System.Windows.Forms.CheckBox
$checkboxRealtime.Text = "Disable Real-time protection"
$checkboxRealtime.Location = New-Object System.Drawing.Point(40,80)
$checkboxRealtime.Font = $font
$checkboxRealtime.BackColor = [System.Drawing.Color]::Transparent
$checkboxRealtime.ForeColor = [System.Drawing.Color]::White
$checkboxRealtime.AutoSize = $true

$checkboxCloud = New-Object System.Windows.Forms.CheckBox
$checkboxCloud.Text = "Disable Cloud-delivered protection"
$checkboxCloud.Location = New-Object System.Drawing.Point(40,120)
$checkboxCloud.Font = $font
$checkboxCloud.BackColor = [System.Drawing.Color]::Transparent
$checkboxCloud.ForeColor = [System.Drawing.Color]::White
$checkboxCloud.AutoSize = $true

$checkboxSampleSubmission = New-Object System.Windows.Forms.CheckBox
$checkboxSampleSubmission.Text = "Disable Automatic sample submission"
$checkboxSampleSubmission.Location = New-Object System.Drawing.Point(40,160)
$checkboxSampleSubmission.Font = $font
$checkboxSampleSubmission.BackColor = [System.Drawing.Color]::Transparent
$checkboxSampleSubmission.ForeColor = [System.Drawing.Color]::White
$checkboxSampleSubmission.AutoSize = $true

$checkboxTamperProtection = New-Object System.Windows.Forms.CheckBox
$checkboxTamperProtection.Text = "Disable Tamper protection (manual)"
$checkboxTamperProtection.Location = New-Object System.Drawing.Point(40,200)
$checkboxTamperProtection.Font = $font
$checkboxTamperProtection.BackColor = [System.Drawing.Color]::Transparent
$checkboxTamperProtection.ForeColor = [System.Drawing.Color]::White
$checkboxTamperProtection.AutoSize = $true

# Create the "Apply Settings" button
$buttonApply = New-Object System.Windows.Forms.Button
$buttonApply.Text = "Apply Settings"
$buttonApply.Font = New-Object System.Drawing.Font("Segoe UI",10,[System.Drawing.FontStyle]::Bold)
$buttonApply.Size = New-Object System.Drawing.Size(150,40)
$buttonApply.Location = New-Object System.Drawing.Point(50,250)
$buttonApply.BackColor = [System.Drawing.Color]::FromArgb(60,120,200)
$buttonApply.ForeColor = [System.Drawing.Color]::White
$buttonApply.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$buttonApply.FlatAppearance.BorderSize = 0

# Create the "About" button
$buttonAbout = New-Object System.Windows.Forms.Button
$buttonAbout.Text = "About"
$buttonAbout.Font = New-Object System.Drawing.Font("Segoe UI",10,[System.Drawing.FontStyle]::Bold)
$buttonAbout.Size = New-Object System.Drawing.Size(100,40)
$buttonAbout.Location = New-Object System.Drawing.Point(240,250)
$buttonAbout.BackColor = [System.Drawing.Color]::FromArgb(70,150,100)
$buttonAbout.ForeColor = [System.Drawing.Color]::White
$buttonAbout.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$buttonAbout.FlatAppearance.BorderSize = 0

# Define button click event for "Apply Settings"
$buttonApply.Add_Click({
    $msg = "The following settings have been applied:`n"
    if ($checkboxRealtime.Checked) {
        Write-Host "Disabling Real-time protection..."
        Set-MpPreference -DisableRealtimeMonitoring $true
        $msg += "- Real-time protection disabled`n"
    }
    if ($checkboxCloud.Checked) {
        Write-Host "Disabling Cloud-delivered protection..."
        Set-MpPreference -MAPSReporting 0
        $msg += "- Cloud-delivered protection disabled`n"
    }
    if ($checkboxSampleSubmission.Checked) {
        Write-Host "Disabling Automatic sample submission..."
        Set-MpPreference -SubmitSamplesConsent 2
        $msg += "- Automatic sample submission disabled`n"
    }
    if ($checkboxTamperProtection.Checked) {
        Write-Host "Tamper protection requires manual adjustment."
        $msg += "- Tamper protection needs manual adjustment`n"
    }
    [System.Windows.Forms.MessageBox]::Show($msg, "Settings Applied", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

# Define button click event for "About"
$buttonAbout.Add_Click({
    [System.Windows.Forms.MessageBox]::Show("Author: Robert Alupului Mihail`nVersion: 1.2.3", "About", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

# Add controls to the form
$form.Controls.Add($header)
$form.Controls.Add($checkboxRealtime)
$form.Controls.Add($checkboxCloud)
$form.Controls.Add($checkboxSampleSubmission)
$form.Controls.Add($checkboxTamperProtection)
$form.Controls.Add($buttonApply)
$form.Controls.Add($buttonAbout)

# Show the form
$form.ShowDialog()
