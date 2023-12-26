@echo off
setlocal enabledelayedexpansion

:: Configura la ruta del directorio actual
set "directorio_actual=%~dp0"

:: Configura el nombre del archivo de salida
set "archivo_salida=nombres.txt"

:menu
cls
echo Seleccione una opción:
echo 1. Sacar todos los nombres de los archivos .jpg
echo 2. Sacar solo los nombres de los archivos nuevos
echo 3. Salir

set /p opcion="Ingrese el número de la opción deseada: "

if "%opcion%"=="1" (
    goto :todos_los_nombres
) else if "%opcion%"=="2" (
    goto :nuevos_nombres
) else if "%opcion%"=="3" (
    exit
) else (
    echo Opción no válida. Intente de nuevo.
    timeout /nobreak /t 2 >nul
    goto :menu
)

:todos_los_nombres
:: Elimina el archivo de salida si ya existe
if exist "%directorio_actual%!archivo_salida!" del "%directorio_actual%!archivo_salida!"

:: Itera a través de todos los archivos .jpg en el directorio actual y guarda los nombres en el archivo de salida
for %%i in ("%directorio_actual%*.jpg") do (
    echo %%~nxi >> "%directorio_actual%!archivo_salida!"
)

echo "Proceso completado. Los nombres de los archivos .jpg se han guardado en %directorio_actual%!archivo_salida!"
pause
exit

:nuevos_nombres
:: Verifica si el archivo de salida existe
if not exist "%directorio_actual%!archivo_salida!" (
    echo El archivo %archivo_salida% no existe. Creando uno nuevo...
    echo. > "%directorio_actual%!archivo_salida!"
)

:: Itera a través de todos los archivos .jpg en el directorio actual y guarda solo los nombres de los archivos nuevos en el archivo de salida
for %%i in ("%directorio_actual%*.jpg") do (
    set "archivo_existente=false"
    for /f "usebackq delims=" %%j in ("%directorio_actual%!archivo_salida!") do (
        if "%%~nxi"=="%%j" (
            set "archivo_existente=true"
            goto :archivo_existente
        )
    )
    :archivo_existente
    if !archivo_existente! == false (
        echo %%~nxi >> "%directorio_actual%!archivo_salida!"
    )
)

echo "Proceso completado. Los nombres de los archivos .jpg nuevos se han guardado en %directorio_actual%!archivo_salida!"
pause
exit
