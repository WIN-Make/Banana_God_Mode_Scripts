Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Windows God Mode Folder Creator"
$form.Size = New-Object System.Drawing.Size(450,300)
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
$header.Text = "Click the button to create a God Mode folder on your desktop:"
$header.Font = New-Object System.Drawing.Font("Segoe UI",12,[System.Drawing.FontStyle]::Bold)
$header.Size = New-Object System.Drawing.Size(400,40)
$header.Location = New-Object System.Drawing.Point(25,20)
$header.ForeColor = [System.Drawing.Color]::Black

# Create the "Create Folder" button
$buttonCreate = New-Object System.Windows.Forms.Button
$buttonCreate.Text = "Create Folder"
$buttonCreate.Font = New-Object System.Drawing.Font("Segoe UI",10,[System.Drawing.FontStyle]::Bold)
$buttonCreate.Size = New-Object System.Drawing.Size(150,40)
$buttonCreate.Location = New-Object System.Drawing.Point(50,200)
$buttonCreate.BackColor = [System.Drawing.Color]::FromArgb(60,120,200)
$buttonCreate.ForeColor = [System.Drawing.Color]::White
$buttonCreate.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$buttonCreate.FlatAppearance.BorderSize = 0

# Create the "About" button
$buttonAbout = New-Object System.Windows.Forms.Button
$buttonAbout.Text = "About"
$buttonAbout.Font = New-Object System.Drawing.Font("Segoe UI",10,[System.Drawing.FontStyle]::Bold)
$buttonAbout.Size = New-Object System.Drawing.Size(100,40)
$buttonAbout.Location = New-Object System.Drawing.Point(240,200)
$buttonAbout.BackColor = [System.Drawing.Color]::FromArgb(70,150,100)
$buttonAbout.ForeColor = [System.Drawing.Color]::White
$buttonAbout.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$buttonAbout.FlatAppearance.BorderSize = 0

# Define button click event for "Create Folder"
$buttonCreate.Add_Click({
    $desktopPath = [System.Environment]::GetFolderPath('Desktop')
    $godModeFolderPath = Join-Path $desktopPath "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}"
    
    if (-not (Test-Path $godModeFolderPath)) {
        New-Item -Path $godModeFolderPath -ItemType Directory | Out-Null
        [System.Windows.Forms.MessageBox]::Show("God Mode folder created on your desktop.", "Folder Created", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    } else {
        [System.Windows.Forms.MessageBox]::Show("God Mode folder already exists on your desktop.", "Folder Exists", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
    }
})

# Define button click event for "About"
$buttonAbout.Add_Click({
    [System.Windows.Forms.MessageBox]::Show("Author: Robert Alupului Mihail`nVersion: 1.2.3", "About", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

# Add controls to the form
$form.Controls.Add($header)
$form.Controls.Add($buttonCreate)
$form.Controls.Add($buttonAbout)

# Show the form
$form.ShowDialog()
