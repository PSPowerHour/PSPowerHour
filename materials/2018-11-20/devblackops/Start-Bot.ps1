[cmdletbinding()]
param()

Import-Module PoshBot -RequiredVersion 0.11.3 -Force -Verbose:$false

# Get config
$config  = Get-PoshBotConfiguration ./config.psd1

# Add plugin config
$config.PluginConfiguration = @{
    'PoshBot.PSPowerHour' = @{
        GoogleApiShortenerApiKey = $env:GOOGLE_API_SHORTENER_API_KEY
    }
}

# Create chat backend
$config.BotAdmins = @('<YOUR-EMAIL-ADDRESS>')
$config.BackendConfiguration = @{
    Name                = 'Teams'
    BotName             = 'PoshBot'
    TeamId              = $env:POSHBOT_TEAMS_ID
    ServiceBusNamespace = '<YOUR-SERVICE-BUS-NAMESPACE>'
    QueueName           = 'messages'
    AccessKeyName       = 'receive'
    AccessKey           = $env:POSHBOT_TEAMS_SB_KEY | ConvertTo-SecureString -AsPlainText -Force
    Credential = [pscredential]::new(
        $env:POSHBOT_BF_APP_ID,
        ($env:POSHBOT_BF_PASSWORD | ConvertTo-SecureString -AsPlainText -Force)
    )
}
$backend = New-PoshBotTeamsBackend -Configuration $config.BackendConfiguration

# Create and start bot
$bot = New-PoshBotInstance -Backend $backend -Configuration $config -WarningAction SilentlyContinue
$bot | Start-PoshBot -WarningAction SilentlyContinue
