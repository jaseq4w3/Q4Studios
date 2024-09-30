@echo off
title Q4.NET - by Jase_Dev - v2
chcp 65001 > nul

:: Define the log file for IP addresses
set "LOG_FILE=ip_log.txt"

:: Start directly into the menu
color 0a
:MENU
cls 
echo               [94m██████╗ ██╗  ██╗   ███╗   ██╗███████╗████████╗[0m
echo             [94m ██╔═══██╗██║  ██║   ████╗  ██║██╔════╝╚══██╔══╝[0m
echo              [97m██║   ██║███████║   ██╔██╗ ██║█████╗     ██║[0m   
echo              [97m██║▄▄ ██║╚════██║   ██║╚██╗██║██╔══╝     ██║[0m   
echo              [96m╚██████╔╝     ██║██╗██║ ╚████║███████╗   ██║[0m   
echo              [96m ╚══▀▀═╝      ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝[0m                
echo 1. List Files in Directory
echo 2. Delete a File or Folder
echo 3. Create a New Directory
echo 4. Show System Information
echo 5. Ping a Website
echo 6. List Running Processes
echo 7. Shutdown the Computer
echo 8. Restart the Computer
echo 9. Edit a Text File
echo 10. Search for Files, Folders, or Apps
echo 11. Number Guessing Game
echo 12. Log Active IP Addresses
echo 13. Exit
echo ----------------------------------------------
set /p choice=Choose an option:

if "%choice%"=="1" goto LIST_FILES
if "%choice%"=="2" goto DELETE_FILE_OR_FOLDER
if "%choice%"=="3" goto CREATE_DIR
if "%choice%"=="4" goto SYSTEM_INFO
if "%choice%"=="5" goto PING_WEBSITE
if "%choice%"=="6" goto LIST_PROCESSES
if "%choice%"=="7" goto SHUTDOWN
if "%choice%"=="8" goto RESTART
if "%choice%"=="9" goto EDIT_FILE
if "%choice%"=="10" goto SEARCH_ITEMS
if "%choice%"=="11" goto NUMBER_GUESSING_GAME
if "%choice%"=="12" goto LOG_IPS
if "%choice%"=="13" exit

echo Invalid choice, please select a valid option.
pause
goto MENU

:LIST_FILES
cls
echo Listing files in the current directory...
dir /b
pause
goto MENU

:DELETE_FILE_OR_FOLDER
cls
echo ----------------------------------------------
echo                Delete a File or Folder
echo ----------------------------------------------
echo 1. Delete a File
echo 2. Delete a Folder
echo 3. Return to Main Menu
echo ----------------------------------------------
set /p choice=Choose an option:

if "%choice%"=="1" goto DELETE_FILE
if "%choice%"=="2" goto DELETE_FOLDER
if "%choice%"=="3" goto MENU

echo Invalid choice, please select a valid option.
pause
goto DELETE_FILE_OR_FOLDER

:DELETE_FILE
cls
echo ----------------------------------------------
echo                Delete a File
echo ----------------------------------------------
set /p filename="Enter the filename to delete (including extension, e.g., file.txt): "
echo Attempting to delete: "%filename%"
echo.

:: Check if file exists
if exist "%filename%" (
    echo File exists. Attempting to delete...
    
    :: Attempt to delete the file
    del /f "%filename%"
    
    :: Check if the file was successfully deleted
    if not exist "%filename%" (
        echo File successfully deleted.
    ) else (
        echo Failed to delete the file.
    )
) else (
    echo File not found.
)

pause
goto DELETE_FILE_OR_FOLDER

:DELETE_FOLDER
cls
echo ----------------------------------------------
echo                Delete a Folder
echo ----------------------------------------------
set /p foldername="Enter the folder name to delete (including full path if needed): "
echo Attempting to delete: "%foldername%"
echo.

:: Check if folder exists
if exist "%foldername%" (
    echo Folder exists. Attempting to delete...
    
    :: Attempt to delete the folder
    rmdir /s /q "%foldername%"
    
    :: Check if the folder was successfully deleted
    if not exist "%foldername%" (
        echo Folder successfully deleted.
    ) else (
        echo Failed to delete the folder.
    )
) else (
    echo Folder not found.
)

pause
goto DELETE_FILE_OR_FOLDER

:CREATE_DIR
cls
echo Creating a new directory...
set /p dirname="Enter the directory name: "
mkdir "%dirname%"
echo Directory created.
pause
goto MENU

:SYSTEM_INFO
cls
echo System Information:
echo ---------------------
systeminfo
pause
goto MENU

:PING_WEBSITE
cls
echo Pinging a website...
set /p website="Enter the website URL (e.g., Roblox.com): "
ping "%website%"
pause
goto MENU

:LIST_PROCESSES
cls
echo Listing running processes...
tasklist
pause
goto MENU

:SHUTDOWN
cls
echo Shutting down the computer...
shutdown /s /t 0
goto MENU

:RESTART
cls
echo Restarting the computer...
shutdown /r /t 0
goto MENU

:EDIT_FILE
cls
echo Editing a text file...
set /p filepath="Enter the full path of the file to edit: "
notepad "%filepath%"
goto MENU

:SEARCH_ITEMS
cls
echo ----------------------------------------------
echo         Search for Files, Folders, or Apps
echo ----------------------------------------------
set /p searchterm="Enter search term (e.g., *.txt or *example*): "
echo Searching for: "%searchterm%"
echo.

:: Create a temporary file for results
set "resultsfile=search_results.txt"

:: Initialize results file
echo. > "%resultsfile%"

:: Perform the search for files
echo Searching for files...
dir /s /b %searchterm% >> "%resultsfile%"

:: Perform the search for folders
echo Searching for folders...
dir /s /b /ad %searchterm% >> "%resultsfile%"

:: Perform the search for executable applications
echo Searching for applications...
dir /s /b *.exe >> "%resultsfile%"

:: Check if there are results
set /a count=0
for /f "delims=" %%A in ('type "%resultsfile%"') do (
    set /a count+=1
)

if %count%==0 (
    echo No items found.
    del "%resultsfile%"
    pause
    goto MENU
)

:SEARCH_RESULTS
cls
echo ----------------------------------------------
echo                Search Results
echo ----------------------------------------------
echo 0. Return to main menu
set /a index=1
for /f "delims=" %%i in (%resultsfile%) do (
    echo !index!: %%i
    set /a index+=1
)

set /p itemchoice="Enter the number of the item to open or 0 to return: "
if "%itemchoice%"=="0" goto MENU

:: Validate the item choice
if %itemchoice% lss 1 (
    echo Invalid choice.
    pause
    goto SEARCH_RESULTS
)

:: Check if the choice is within range
if %itemchoice% gtr %count% (
    echo Choice out of range.
    pause
    goto SEARCH_RESULTS
)

:: Open the selected item
set "selecteditem="
for /f "tokens=%itemchoice%" %%i in (%resultsfile%) do set "selecteditem=%%i"

if defined selecteditem (
    echo Opening item: %selecteditem%
    start "" "%selecteditem%"
) else (
    echo Item not found.
)

del "%resultsfile%"
pause
goto MENU

:NUMBER_GUESSING_GAME
cls
echo ===============================================
echo           Welcome to the Number Guessing Game!
echo ===============================================
echo Guess a number between 1 and 50.
echo ===============================================
set /a "LOWER=1"
set /a "UPPER=50"
set /a "SECRET=%RANDOM% %% %UPPER% + %LOWER%"

:: Initialize attempt counter
set /a "ATTEMPTS=0"

:GUESS
set /a "ATTEMPTS+=1"
set /p "USER_GUESS=Enter your guess: "

:: Validate user input
if not "%USER_GUESS%"=="" (
    if "%USER_GUESS%" lss "%LOWER%" (
        echo Guess is too low. Try again.
        goto GUESS
    )
    if "%USER_GUESS%" gtr "%UPPER%" (
        echo Guess is too high. Try again.
        goto GUESS
    )

    if "%USER_GUESS%"=="%SECRET%" (
        echo Congratulations! You guessed the number in %ATTEMPTS% attempts.
        pause
        goto MENU
    ) else (
        if "%USER_GUESS%" lss "%SECRET%" (
            echo Too low. Try again.
        ) else (
            echo Too high. Try again.
        )
        goto GUESS
    )
) else (
    echo Invalid input. Please enter a number.
    goto GUESS
)

:LOG_IPS
cls
echo ===============================================
echo          Logging Active IP Addresses
echo ===============================================
echo Logging active IP connections...
echo ===============================================

:: Append current date and time to log file
echo %date% %time% >> "%LOG_FILE%"

:: Log IP addresses from netstat
netstat -n | findstr /R /C:"^ *[0-9]" >> "%LOG_FILE%"

echo IP addresses logged to "%LOG_FILE%".
pause
goto MENU
