$talk = [pscustomobject]@{
    Name      = 'Fun with Fonts: Displaying file and folder icons in your terminal'
    Presenter = [pscustomobject]@{
        Name    = 'Brandon Olin'
        Job     = 'SRE @ Stack Overflow'
        Twitter = '@devblackops'
        Blog    = 'https://devblackops.io'
        Awards  = 'MVP - Cloud and Datacenter Management'
    }
    ProjectUri    = 'https://github.com/devblackops/Terminal-Icons'
    PSGalleryUri  = 'https://www.powershellgallery.com/packages/Terminal-Icons/0.1.1'
    NerdFonts     = 'http://nerdfonts.com/'
    NerdFontsRepo = 'https://github.com/ryanoasis/nerd-fonts'

    # Gist showing how to get Nerd Fonts working in the default console
    FontGist = 'https://gist.github.com/markwragg/6301bfcd56ce86c3de2bd7e2f09a8839'
}

# Normal output
Get-ChildItem

Install-Module Terminal-Icons -Repository PSGallery
Import-Module Terminal-Icons

ls
ls | fl

# Commands
Get-Command -Module Terminal-Icons

# Get the current theme
Get-TerminalIconsTheme
Get-Content ~/AppData/Roaming/powershell/Community/Terminal-Icons/Configuration.psd1

# Add a color theme
Get-TerminalIconsColorTheme
Add-TerminalIconsColorTheme -Path ./MyColorTheme.psd1 -Verbose -Force
Get-TerminalIconsColorTheme
Set-TerminalIconsColorTheme -Name MyColorTheme
ls

# Add an icon theme
Get-TerminalIconsIconTheme
Add-TerminalIconsIconTheme -Path ./MyIconTheme.psd1 -Verbose -Force
Get-TerminalIconsIconTheme
Set-TerminalIconsIconTheme -Name MyIconTheme
ls ../../..

# Inline formatting
Get-Item ./demo.ps1 | Format-TerminalIcons

# Demo all theme icons and colors
Show-TerminalIconsTheme

# Reset
'devblackops' | Set-TerminalIconsColorTheme
'devblackops' | Set-TerminalIconsIconTheme
ls ../../..
Show-TerminalIconsTheme