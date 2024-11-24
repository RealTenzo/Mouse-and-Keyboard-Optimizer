@echo off
:: Ensure administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo =====================================================
    echo This script requires administrative privileges to run.
    echo Please right-click this file and select "Run as Administrator."
    echo =====================================================
    pause
    exit
)

title Mouse And Keyboard Optimizer - Made by Tenzo
color 0a

:menu
cls
echo =====================================================
echo              Mouse And Keyboard Optimizer               
echo                     Made by Tenzo                    
echo =====================================================
echo [1] Apply All Optimizations (Recommended for Gaming)
echo -----------------------------------------------------
echo [2] Disable Mouse Acceleration (Zero Acceleration)
echo [3] Set Default Pointer Speed
echo [4] Disable Cursor Shadow
echo [5] Smooth Scroll Settings
echo -----------------------------------------------------
echo [6] Enable High-Performance Power Plan
echo [7] Set Zero Response Time (Mouse and Keyboard)
echo [8] Optimize System for Gaming (Background Tweaks)
echo [9] Reduce DPC Latency for Input Lag Reduction
echo -----------------------------------------------------
echo [10] Game-Specific Optimization Instructions
echo [11] Restore Default Settings (Undo All Tweaks)
echo -----------------------------------------------------
echo [12] About
echo [0] Exit
echo =====================================================
set /p choice="Select an option (0-12): "

if "%choice%"=="1" goto all
if "%choice%"=="2" goto disable_acceleration
if "%choice%"=="3" goto pointer_speed
if "%choice%"=="4" goto disable_shadow
if "%choice%"=="5" goto smooth_scroll
if "%choice%"=="6" goto power_plan
if "%choice%"=="7" goto zero_response
if "%choice%"=="8" goto optimize_system
if "%choice%"=="9" goto dpc_latency
if "%choice%"=="10" goto game_instructions
if "%choice%"=="11" goto restore_defaults
if "%choice%"=="12" goto about
if "%choice%"=="0" exit
goto invalid

:all
cls
echo Applying all optimizations...
call :disable_acceleration
call :pointer_speed
call :disable_shadow
call :smooth_scroll
call :power_plan
call :zero_response
call :optimize_system
call :dpc_latency
echo =====================================================
echo All optimizations applied successfully! Restart your PC for best results.
pause
goto menu

:disable_acceleration
echo Disabling Mouse Acceleration (Zero Acceleration Mode)...
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul
echo Mouse Acceleration Disabled!
goto menu

:pointer_speed
echo Setting Pointer Speed to Default (10)...
reg add "HKCU\Control Panel\Mouse" /v MouseSensitivity /t REG_SZ /d 10 /f >nul
echo Pointer Speed Set to Default!
goto menu

:disable_shadow
echo Disabling Cursor Shadow for smoother visuals...
reg add "HKCU\Control Panel\Desktop" /v CursorShadow /t REG_SZ /d 0 /f >nul
echo Cursor Shadow Disabled!
goto menu

:smooth_scroll
echo Setting Smooth Scroll Settings...
reg add "HKCU\Control Panel\Desktop" /v WheelScrollLines /t REG_SZ /d 3 /f >nul
echo Smooth Scroll Settings Applied!
goto menu

:power_plan
echo Setting High-Performance Power Plan for reduced input lag...
powercfg -setactive SCHEME_MIN >nul
echo High-Performance Power Plan Enabled!
goto menu

:zero_response
echo Setting Zero Response Time for Mouse and Keyboard...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HidUsb\Parameters" /v FlipFlopWheel /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Control Panel\Keyboard" /v KeyboardDelay /t REG_SZ /d 0 /f >nul
reg add "HKCU\Control Panel\Keyboard" /v KeyboardSpeed /t REG_SZ /d 31 /f >nul
echo Zero Response Time Settings Applied!
goto menu

:optimize_system
echo Optimizing system for gaming...
:: Disable Xbox Game Bar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul
:: Disable unneeded background services
sc config SysMain start= disabled >nul 2>&1
sc config DiagTrack start= disabled >nul 2>&1
echo System Optimized for Gaming!
goto menu

:dpc_latency
echo Reducing DPC Latency for lower input lag...
:: Disable dynamic tick (reduces latency)
bcdedit /set useplatformtick yes >nul
:: Enable high-resolution timer
bcdedit /set disabledynamictick yes >nul
:: Set system timer resolution
powercfg -attributes SUB_PROCESSOR 75b0ae3f-bce0-45a7-8c89-c9611c25e100 -ATTRIB_HIDE >nul
echo DPC Latency Optimization Applied!
goto menu

:game_instructions
cls
echo =====================================================
echo                 Game-Specific Instructions           
echo =====================================================
echo 1. Enable "Raw Input" or "Direct Input" in your game 
echo    settings to bypass any OS-level acceleration.
echo 2. Use a DPI between 400 and 1600 based on preference.
echo 3. Adjust in-game sensitivity to suit your playstyle.
echo 4. Test polling rate at 1000 Hz for smoother tracking.
echo 5. Check your mouse software to disable acceleration.
echo 6. Restart your PC after applying these optimizations.
echo =====================================================
pause
goto menu

:restore_defaults
cls
echo Restoring default settings...
:: Restore mouse acceleration
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 1 /f >nul
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 6 /f >nul
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 10 /f >nul
:: Restore keyboard delay and speed
reg add "HKCU\Control Panel\Keyboard" /v KeyboardDelay /t REG_SZ /d 1 /f >nul
reg add "HKCU\Control Panel\Keyboard" /v KeyboardSpeed /t REG_SZ /d 31 /f >nul
:: Re-enable background services
sc config SysMain start= auto >nul 2>&1
sc config DiagTrack start= auto >nul 2>&1
:: Re-enable dynamic tick
bcdedit /deletevalue useplatformtick >nul
bcdedit /deletevalue disabledynamictick >nul
echo Default Settings Restored!
pause
goto menu

:about
cls
echo =====================================================
echo              Mouse And Keyboard Optimizer               
echo                     Made by Tenzo                    
echo =====================================================
echo This script optimizes your mouse, keyboard, and system
echo for gaming by ensuring minimal input lag, reduced DPC 
echo latency, and better performance. Use it to achieve the 
echo ultimate gaming experience.                          
echo =====================================================
pause
goto menu

:invalid
echo Invalid choice. Please select a valid option.
pause
goto menu
