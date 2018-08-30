using module .\MyClass.psm1

# create class instance
$NewInstance = [MyClass]::New()

# show hidden property isn't available
$NewInstance | Get-Member

# Setting readable isn't possible
$NewInstance.readable = "New Value"

# Setting writeable is possible
$NewInstance.writeable = "New Value "

# Getting Writeable isn't possible
$NewInstance.writeable

# Getting Readable is possible

$NewInstance.readable

# Trim worked
$NewInstance.readable | Should -be "New Value"

# Be careful, hidden isn't very well hidden

$NewInstance._Internal

$NewInstance._Internal = "test value "

# Trim didn't work
$NewInstance.Readable | Should -be  "test value"
