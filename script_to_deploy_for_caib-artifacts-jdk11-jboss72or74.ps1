# Script: publicar-caib-artifacts.ps1

$repoLocal = "C:\Users\anadal\.m2\repository\es\caib\maven\caib-artifacts-jdk11-jboss72or74"
$projecte = "C:\dades\dev\ProgramacioPortaFIB3\caib-artifacts\caib-artifacts-jdk11-jboss72or74"
$repoGithub = "C:\dades\github-governib-maven-repository\maven\es\caib\maven\caib-artifacts-jdk11-jboss72or74"
$snapshotDir = Join-Path $repoLocal "1.0.1-SNAPSHOT"

Write-Host "==> Esborrant artefacte local..."
if (Test-Path $repoLocal) {
    Remove-Item $repoLocal -Recurse -Force
}

Write-Host "==> Executant mvn clean install..."
Push-Location $projecte
mvn clean install
if ($LASTEXITCODE -ne 0) {
    Write-Error "Error executant Maven."
    Pop-Location
    exit 1
}
Pop-Location

Write-Host "==> Processant maven-metadata.xml principal..."
Rename-Item `
    "$repoLocal\maven-metadata-local.xml" `
    "maven-metadata.xml" `
    -Force

(Get-FileHash "$repoLocal\maven-metadata.xml" -Algorithm SHA1).Hash.ToLower() |
    Set-Content "$repoLocal\maven-metadata.xml.sha1" -NoNewline

Write-Host "==> Processant SNAPSHOT..."
Rename-Item `
    "$snapshotDir\maven-metadata-local.xml" `
    "maven-metadata.xml" `
    -Force

(Get-FileHash "$snapshotDir\maven-metadata.xml" -Algorithm SHA1).Hash.ToLower() |
    Set-Content "$snapshotDir\maven-metadata.xml.sha1" -NoNewline

(Get-FileHash "$snapshotDir\caib-artifacts-jdk11-jboss72or74-1.0.1-SNAPSHOT.pom" -Algorithm SHA1).Hash.ToLower() |
    Set-Content "$snapshotDir\caib-artifacts-jdk11-jboss72or74-1.0.1-SNAPSHOT.pom.sha1" -NoNewline

if (Test-Path "$snapshotDir\_remote.repositories") {
    Remove-Item "$snapshotDir\_remote.repositories" -Force
}

Write-Host "==> Copiant al repositori GitHub..."
if (Test-Path $repoGithub) {
    Remove-Item $repoGithub -Recurse -Force
}

Copy-Item $repoLocal $repoGithub -Recurse

Write-Host ""
Write-Host "PROCES FINALITZAT CORRECTAMENT" -ForegroundColor Green