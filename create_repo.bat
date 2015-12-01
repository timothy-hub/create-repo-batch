@ECHO OFF

SET username=
SET mytoken=

for /f "tokens=1,* delims= " %%a in ("%*") do set DESCRIPTION=%%b

IF [%1]==[] (
	ECHO Usage: create_repo ^<name^> ^<description^>^*
	GOTO:EOF
) ELSE IF [%2]==[] (
	GOTO:without_description
)

:with_description
	curl -u %username%:%mytoken% https://api.github.com/user/repos -d "{\"name\":\"%1\",\"description\":\"%DESCRIPTION%\"}"
	GOTO:git_commands

:without_description
	curl -u %username%:%mytoken% https://api.github.com/user/repos -d "{\"name\":\"%1\"}"

:git_commands
	git init
	git add -i
	git commit -a -m "First commit"
	git remote add origin git@github.com:%username%/%1.git
	git push origin master

