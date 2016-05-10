@echo off
set SERVERPATH=http://localhost:4502/content/dam/companyName/migrated-assets
set ASSETSPATH="C:\Users\User Name\Documents\migrated"


cd %ASSETSPATH%
set assets=%cd%

@setlocal enableextensions enabledelayedexpansion

echo Creating folder structure
for /D /R %%d in (*) do (
	set old=%%d
	set A=!old:%assets%\=!
	set B=!old:\=/!
	set C=!A:\=/!
	echo curl -s -u admin:admin -X POST -i -Fjcr:primaryType=sling:Folder %SERVERPATH%!C!
)

echo Uploading assets
for /D /R %%d in (*) do (
	for /f %%f in ('dir /b /a-d-h-s "%%d"') do (
		set old=%%d
		set A=!old:%assets%\=!
		set B=!old:\=/!
		set C=!A:\=/!
		echo curl -s -u admin:admin -X POST -i -F "file=@!B!/%%f" %SERVERPATH%!C!.createasset.html
	)
)

pause