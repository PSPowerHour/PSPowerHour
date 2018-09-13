param(
    [string]$Url = 'https://www.powershellgallery.com',
    [string]$StatusCode = 200
)

Describe 'The app responds' -Tag 'App' {
    It "The website [$Url] should be responsive" {
        $response = Invoke-WebRequest -Uri $Url -UseBasicParsing
        $response.StatusCode | Should -Be $StatusCode
    }
}