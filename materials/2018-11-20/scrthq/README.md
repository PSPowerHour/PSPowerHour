# PSPowerHour - 2018-11-20

* **Name**: Nate Ferrell
* **Title**: Getting Started with PowerShell Core in AWS Lambda
* **Abstract**: Tips, tricks & gotchas with working PowerShell Core in AWS Lambda
* **Twitter**: [@scrthq](https://twitter.com/scrthq)
* **SlackID**: @scrthq
* **Blog**: https://ferrell.io/

***

## Prerequisites

* PowerShell Core
* The `AWSLambdaPSCore` module for PowerShell Core
* [.NET Core 2.1 SDK](https://www.microsoft.com/net/download)
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/installing.html) (needed here for packaging and deploying the CloudFormation stack containing our Lambda and other relevant resources)
* Optional: The `AWSPowerShell.NetCore` module for PowerShell Core

## Key points

* Windows PowerShell is **not** supported, only PowerShell Core.
* Logging to CloudWatch is as simple as using any of the standard `Write-*` CmdLets.
* When executing in Lambda the following variables will be predefined:
  * `$LambdaInput` - A PSObject that contains the Lambda function input data.
  * `$LambdaContext` - An Amazon.Lambda.Core.ILambdaContext object that contains information about the currently running Lambda environment.
* The last item in the PowerShell pipeline will be returned as the result of the Lambda function.
* To include PowerShell modules with your Lambda function, like the AWSPowerShell.NetCore module, add a "#Requires" statement indicating module name and version at the top of your script:
  * `#Requires -Modules @{ModuleName='AWSPowerShell.NetCore';ModuleVersion='3.3.343.0'}`
* Need a reminder later? Most of the above points are available at the head of each template included with the `AWSLambdaPSCore` module.

## Walkthrough

1. Launch the Basic template with `New-AWSPowerShellLambda`:
    ```powershell
    New-AWSPowerShellLambda -Template 'Basic' -Directory '.' -ScriptName 'HelloWorld'
    ```
2. Add your code to the newly generated script file:
    ```powershell
    Write-Host (ConvertTo-Json -InputObject $LambdaInput -Compress -Depth 5)
    Write-Verbose (ConvertTo-Json -InputObject $LambdaContext -Compress -Depth 5) -Verbose
    $result = "Hello from PowerShell Core Lambda, $($LambdaInput.path.split('/')[-1])!"
    @{
        statusCode = 200
        body = $result
        headers = @{
            'Content-Type' = 'text/plain'
        }
    }
    ```
3. Create your Lambda deployment package using `New-AWSPowerShellLambdaPackage`:
    ```powershell
    New-AWSPowerShellLambdaPackage -ScriptPath 'HelloWorld.ps1' -OutputPackage 'HelloWorld.zip'
    ```
4. Upload the package to S3 and resolve the final CloudFormation template using `aws cloudformation package`:
    ```powershell
    aws cloudformation package --template-file cfn.yml --s3-bucket scrthq-helloworld --output-template-file updated.yml
    ```
5. Deploy the resolved CloudFormation template using `aws cloudformation deploy`:
    ```powershell
    aws cloudformation deploy --template-file updated.yml --stack-name HelloPSWorld --capabilities CAPABILITY_IAM
    ```
6. Test out your new PowerShell Core API:
    ```powershell
    # Grab the REST API Uri from the stack outputs
    $output = (Get-CFNStack -StackName HelloPSWorld).Outputs[0].OutputValue
    # Contatenate our name to the Uri
    [Uri]$uri = $output + 'PSPowerHour'
    # Make a GET request to the
    Invoke-RestMethod -Uri $uri
    ```

## Links

* [Setting up a PowerShell Development Environment for AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/lambda-powershell-setup-dev-environment.html)
* [PowerShell programming model for AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/powershell-programming-model.html)
* Example event payloads can be found in the [event sources section of the AWS Lambda documentation](https://docs.aws.amazon.com/lambda/latest/dg/eventsources.html)
