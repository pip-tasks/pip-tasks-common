function New-FtpFolder
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string] $Uri,
        [Parameter(Mandatory=$false, Position=1)]
        [string] $Username,
        [Parameter(Mandatory=$false, Position=2)]
        [string] $Password,
        [Parameter(Mandatory=$true, Position=3)]
        [string] $FtpFolder
    )
    begin {}
    process
    {
        if ($FtpFolder -ne '' -and -not $FtpFolder.StartsWith('/'))
        {
            $FtpFolder = '/' + $FtpFolder
        }

        $req = [System.Net.FtpWebRequest]::Create($Uri + $FtpFolder);
        $req.Method = [System.Net.WebRequestMethods+Ftp]::MakeDirectory
        #$req.UseBinary = $true
        #$req.UsePassive = $true
        #$req.KeepAlive = $true

        if ($Username -ne $null -and $Username -ne '')
        {
            $req.Credentials = New-Object System.Net.NetworkCredential($Username, $Password)
        }

        try 
        {
            $res = $req.GetResponse()
            $s = $res.GetResponseStream()
            $s.Close()
            $res.Close()

            Write-Host "Created $FtpFolder"

            Write-Output $true
        }
        catch [System.Net.WebException]
        {
            $res = $_.Exception.Response
            $c = $res.StatusCode
            $s = $res.GetResponseStream()
            $s.Close()
            $res.Close()

            Write-Host "Failed to create $FtpFolder - $c"

            Write-Output $false
        }
    }
}


function Write-FtpFile
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string] $Uri,
        [Parameter(Mandatory=$false, Position=1)]
        [string] $Username,
        [Parameter(Mandatory=$false, Position=2)]
        [string] $Password,
        [Parameter(Mandatory=$true, Position=3)]
        [string] $FtpFile,
        [Parameter(Mandatory=$true, Position=4)]
        [string] $Path
    )
    begin {}
    process
    {
        if ($FtpFile -ne '' -and -not $FtpFile.StartsWith('/'))
        {
            $FtpFile = '/' + $FtpFile
        }

        Write-Host "Uploading $FtpFile"

        $req = [System.Net.FtpWebRequest]::Create($Uri + $FtpFile);
        $req.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
        $req.UseBinary = $true
        $req.UsePassive = $true
        $req.KeepAlive = $true

        if ($Username -ne $null -and $Username -ne '')
        {
            $req.Credentials = New-Object System.Net.NetworkCredential($Username, $Password)
        }

        $f = (Get-Item -Path $Path).FullName
        $s1 = [System.IO.File]::OpenRead($f)
        $s2 = $req.GetRequestStream()

        $s1.CopyTo($s2)

        $s2.Close()
        $s1.Close()
                                    
        $res = $req.GetResponse()
        $res.Close()
    }
}




function Publish-FtpFolder
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string] $Uri,
        [Parameter(Mandatory=$false, Position=1)]
        [string] $Username,
        [Parameter(Mandatory=$false, Position=2)]
        [string] $Password,
        [Parameter(Mandatory=$false, Position=3)]
        [string] $FtpFolder = '',
        [Parameter(Mandatory=$true, Position=4)]
        [hashtable] $Overrides = @{},
        [Parameter(Mandatory=$true, Position=5)]
        [string] $Path = '.'
    )
    begin {}
    process
    {
        # Define destination folder and create it
        if ($FtpFolder -ne '' -and -not $FtpFolder.StartsWith('/'))
        {
            $FtpFolder = '/' + $FtpFolder
        }

        # Create mapping between local and ftp files
        $fileMap = @{}
        $rootDir = Get-Item -Path $Path
        $files = Get-ChildItem -Path $Path -File -Recurse
        foreach ($file in $files)
        {
            $fileName = $file.FullName.Substring($rootDir.FullName.Length + 1)
            $fileName = $fileName.Replace("\", "/")
            $fileOverride = $Overrides[$fileName]
            if ($fileOverride -ne $null) { $fileName = $fileOverride }
            $fileName = $FtpFolder + "/" + $fileName

            $fileMap[$fileName] = $file.FullName
        }

        # Create file directories
        $ftpFolders = @{}
        foreach ($ftpFile in $fileMap.Keys)
        {
            $tokens = $ftpFile.Split('/', [System.StringSplitOptions]::RemoveEmptyEntries)
            $n = 0
            $ftpFolder = ''
            while ($n -lt $tokens.Length - 1)
            {
                $ftpFolder += '/' + $tokens[$n]
                if (-not $ftpFolders.ContainsKey($FtpFolder))
                {
                    $ftpFolders[$FtpFolder] = $true
                    $null = New-FtpFolder -Uri $Uri -Username $Username -Password $Password -FtpFolder $FtpFolder
                }
                $n++
            }
        }
        
        return

        # Upload files
        #foreach ($ftpFile in $fileMap.Keys)
        #{
        #    $Path = $fileMap[$ftpFile]
        #    Write-FtpFile -Uri $Uri -Username $Username -Password $Password -FtpFile $ftpFile -Path $Path
        #}

        $client = New-Object System.Net.WebClient
        if ($Username -ne $null -and $Username -ne '')
        {
            $client.Credentials = New-Object System.Net.NetworkCredential($Username, $Password)
        }

        foreach ($ftpFile in $fileMap.Keys)
        {
            $Path = $fileMap[$ftpFile]

            Write-Host "Uploading $ftpFile"
            #$client.UploadFile($Uri + $ftpFile, $Path)
        }

        $client.Dispose()
    }
    end {}
}


$s =     @{
        Server = 'devfacade';
        Uri = 'ftp://waws-prod-sn1-75f48638.ftp.p.azurewebsites.windows.net';
        Username = 'facadewebapi\olshep';
        Password = 'sheplers12!';
        SourcePath = './Source/Facade.WebApi/bin';
        DestinationPath = '/site/wwwroot/bin';
        FileOverrides = @{
            'zh-Hant/System.Spatial.resources.dll' = 'config.js'
        }
    }