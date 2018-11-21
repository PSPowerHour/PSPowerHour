@{
  CommandHistoryMaxLogSizeMB = 10
  Name = 'PoshBot'
  LogCommandHistory = $True
  PluginRepository = @('PSGallery')
  CommandPrefix = '!'
  AlternateCommandPrefixSeperators = @(':',',',';')
  LogLevel = 'Debug'
  PluginConfiguration = @{
    'PoshBot.PSPowerHour' = @{
      GoogleApiShortenerApiKey = $env:GOOGLE_API_SHORTENER_API_KEY
    }
  }
  DisallowDMs = $False
  ApprovalConfiguration = @{
    # ExpireMinutes = 30
    # Commands = @(
    #   @{
    #     Expression = 'PoshBot.PSPowerHour:*'
    #     Groups = @('admin', 'release')
    #     PeerApproval = $true
    #   }
    # )
  }
  MaxLogsToKeep = 5
  PluginDirectory = './plugins'
  FormatEnumerationLimitOverride = -1
  ConfigurationDirectory = '.'
  LogDirectory = './logs'
  AlternateCommandPrefixes = @('hal', 'bender')
  MuteUnknownCommand = $False
  AddCommandReactions = $True
  CommandHistoryMaxLogsToKeep = 5
  ChannelRules = @(
    @{
      IncludeCommands = @('*')
      Channel = '*'
      ExcludeCommands = @()
    }
  )
  MaxLogSizeMB = 10
  BotAdmins = @('<YOUR-EMAIL-ADDRESS>')
  ModuleManifestsToLoad = @()
  SendCommandResponseToPrivate = @()
  MiddlewareConfiguration = @{}
}
