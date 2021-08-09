function Get-CFLogFilePath {
    <#
        .SYNOPSIS 
        Adds two numbers together as opposed to apart.

        .DESCRIPTION
        This cool function adds two numbers together.

        .PARAMETER $p_int1
        The first number of your choosing.

        .PARAMETER $p_int2
        The second number of your choosing.
        
        .INPUTS
        This function does not support piping.

        .OUTPUTS
        Returns the sum.

        .EXAMPLE
        Invoke-UdfAddNumber 5 10
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [hashtable]
        $flag,
        [Parameter(Mandatory=$false)]
        [string[]]
        $flagOrder = @(Skipped),
        [Parameter(Mandatory=$false)]
        [string]
        $prefix = "Script",
        [Parameter(Mandatory=$true)]
        [bool]
        $errorFlag
    )

    try {
        Write-Verbose "LogFileName function started"
        
        <#
        compname - Current local computer name where the script is executed.
        #>
        $compName = $env:COMPUTERNAME

        <# This object saves the file name path and path with colum headers Name and Path  #>
        $fileNamePathObject = New-Object -TypeName psobject

        if ($errorFlag) {
            $outputFilename = "$($prefix)_$($compName)_ERROR.txt"
            $logFilePath = $PSScriptRoot + $outputFilename
        }
        else{
            $outputFilename = "$($prefix)_$($compName)_SUCCESS.txt"
            $logFilePath = $PSScriptRoot + $outputFilename
        }
        
        if (!$flag) {
            foreach ($item in $flagOrder){
                if ($flag.ContainsKey($item)) {
                    $outputFilename += '_$item'
                }
            }
        }
        

        $fileNamePathObject | Add-Member -MemberType NoteProperty -Name Name -Value $outputFilename
        $fileNamePathObject | Add-Member -MemberType NoteProperty -Name Path -Value $logFilePath
        return $fileNamePathObject
    }
    catch {
        <#
        Exeption Handling - Catch block for the function LogFileName
        #>
        Write-Verbose 'Unhandled Error - Function Get-CFLogFilePath'
        Write-Verbose 'Type of Exception: $_.Exception.GetType.FullName'
        Write-Verbose 'Type of Inner Exception: $_.Exception.InnerException.GetType().FullName'
        Write-Verbose 'Target Object: $_.TargetObject'
        Write-Verbose 'Invocation Info: $_InvocationInfo.MyCommand.Name'
        Write-Verbose 'Error Details: $_.ErrorDetails.Message'
        Write-Verbose 'Invocation Message: $_.InvocationInfo.PositionMessage'
        Write-Verbose 'Category Info: $_.CategoryInfo.ToString()'
        Write-Verbose 'Fully Qualified Error ID: $_.FullyQualifiedErrorId'

        exit
    }

}