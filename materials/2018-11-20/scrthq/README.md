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
* .NET Core 2.1 SDK
* Optional: The `AWSPowerShell.NetCore` module for PowerShell Core

## Key points

* Windows PowerShell is **not** supported
* The Lambda event and context are stored as PSObjects in predefined variables

## Links

* [Setting up a PowerShell Development Environment for AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/lambda-powershell-setup-dev-environment.html)
* [PowerShell programming model for AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/powershell-programming-model.html)
* Example event payloads can be found in the [event sources section of the AWS Lambda documentation](https://docs.aws.amazon.com/lambda/latest/dg/eventsources.html)
