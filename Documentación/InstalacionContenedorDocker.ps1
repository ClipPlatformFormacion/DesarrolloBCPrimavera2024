#Install-Module -Name BcContainerHelper -Force

$artifactURL = Get-BCArtifactUrl -country es -select Latest -type Sandbox

New-BcContainer -accept_eula -auth UserPassword -artifactUrl $artifactURL -containerName BC24CU1ES -useBestContainerOS -updateHosts -includeTestToolkit -includeTestLibrariesOnly