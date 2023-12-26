@echo off
setlocal enabledelayedexpansion

:: Configura la ruta del directorio actual
set "directorio_actual=%~dp0"

:: Configura el nombre del archivo de salida
set "archivo_salida=nombres.txt"

:: Elimina el archivo de salida si ya existe
if exist "%directorio_actual%!archivo_salida!" del "%directorio_actual%!archivo_salida!"

:: Itera a través de todos los archivos .jpg en el directorio actual y guarda los nombres en el archivo de salida
for %%i in ("%directorio_actual%*.jpg") do (
    echo %%~nxi >> "%directorio_actual%!archivo_salida!"
)

echo "Proceso completado. Los nombres de los archivos .jpg se han guardado en %directorio_actual%!archivo_salida!"
pause
