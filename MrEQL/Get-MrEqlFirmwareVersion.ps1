#Requires -Version 3.0
function Get-MrEqlFirmwareVersion {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,
                   ValueFromPipeline)]
        [string[]]$GroupAddress,
        
        [Parameter(Mandatory)]
        [System.Management.Automation.Credential()]$Credential 
    )

    BEGIN {
        Import-Module "$env:ProgramFiles\EqualLogic\bin\EqlPSTools.dll"
    }

    PROCESS {
        foreach ($Group in $GroupAddress) {
            Connect-EqlGroup -GroupAddress $Group -Credential $Credential | Out-Null

            Get-EqlMember -GroupAddress $Group |
            Select-Object MemberName, FirmwareVersion

            Disconnect-EqlGroup -GroupAddress $Group | Out-Null
        }
    }
}