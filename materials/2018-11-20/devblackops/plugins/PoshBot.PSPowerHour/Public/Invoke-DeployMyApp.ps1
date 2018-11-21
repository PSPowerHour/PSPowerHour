function Invoke-DeployMyApp {
    <#
    .SYNOPSIS
        Deploys MyApp to an environment
    .EXAMPLE
        !deploy-myapp --environment prod
    #>
    [PoshBot.BotCommand(
        CommandName = 'Deploy-MyApp'
    )]
    [cmdletbinding()]
    param(
        [validateSet('prod', 'staging', 'dev')]
        [string]$Environment = 'dev'
    )

    $msg = @"
Solving for (x)............[OK]
Compiling compilers........[OK]
Inverting matrices.........[OK]
Scheduling hipsters........[OK]
Finding Nemo...............[OK]
Calculating Pi.............[OK]
Reticulating splines.......[OK]
Ok Boss. Deployment to [$Environment] underway. Detailed status is here https://deploy.mydomain.tld/id=234593
"@
    New-PoshbotTextResponse -Text $msg -AsCode
}
