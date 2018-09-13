param(
    $FreeRamMbytesThreshold = 500
)

describe 'Memory' -Tag Memory {

    it "MB Free should be greater than $FreeRamMbytesThreshold" {
        $freeRam = (Get-CimInstance -Query 'SELECT FreePhysicalMemory FROM Win32_OperatingSystem' |
            Select-Object -ExpandProperty FreePhysicalMemory) / 1KB
        $freeRam | Should -BeGreaterThan $FreeRamMbytesThreshold
    }

}