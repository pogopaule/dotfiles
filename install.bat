xcopy %CD%\vim %HOMEPATH%\vimfiles /s /i
copy %CD%\vimrc %HOMEPATH%\_vimrc
copy %CD%\gitignore_global %HOMEPATH%\.gitignore_global
copy %CD%\bash_profile %HOMEPATH%\.bash_profile
copy %CD%\agignore %HOMEPATH%\.agignore

npm install -g js-beautify

git submodule init
git submodule update
