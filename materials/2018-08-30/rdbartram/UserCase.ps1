using module .\BaseClass.psm1

Class User : BaseObject {
    [string] $Username

    [string] $Password

    User ([string]$username, [string]$password) : Base () {
        $this.Username = $username
        $this.Password = $password
    }
}

$Ryan = [User]::New("Ryan", "MySuperSecretPassword!")

$Ryan.Password

#region solution
Class SecureUser : BaseObject {
    [string] $Username

    hidden [securestring] $_Password

    [Set('{
        $this._Password = $args[0]
    }')]
    [securestring] $Password

    SecureUser ([string]$username, [securestring]$password) : Base () {
        $this.Username = $username
        $this._Password = $password
    }
}

$cred = Get-Credential
$Ryan = [SecureUser]::New($cred.UserName, $cred.Password)

$Ryan.Password

# sadly :'(
$Ryan._Password | ConvertFrom-SecureString

$Ryan.Password = ("teststring" | convertto-securestring -AsPlainText -Force)
#endregion
