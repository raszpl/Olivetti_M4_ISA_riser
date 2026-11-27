@echo off
::for /f "delims=" %%i in ('date /T') do set DATE=%%i
::for /f "delims=" %%i in ('time /T') do set DATE=%DATE%%%i
:: https://www.kicad.org/download/
set "KICAD_CLI=C:\Program Files\KiCad\10.0\bin\kicad-cli.exe"
:: https://imagemagick.org/download/
set "magick=C:\Program Files\ImageMagick-7.1.1-Q8\magick.exe"
:: https://github.com/fhanau/Efficient-Compression-Tool/releases
set "ect=C:\Program Files\ImageMagick-7.1.1-Q8\ect.exe"
:: project name same as directory
for %%I in ("%~dp0.") do set "ProjectName=%%~nxI"

"%KICAD_CLI%" sch export pdf "%~dp0%ProjectName%.kicad_sch" -o "%~dp0%ProjectName%.pdf"

"%magick%" -density 180 "%~dp0%ProjectName%.pdf" -colors 32 "%~dp0%ProjectName%.png"

"%KICAD_CLI%" pcb render "%~dp0%ProjectName%.kicad_pcb" --perspective --quality high --zoom 2.1 -o "%~dp0%ProjectName% render.png" -w 1920
"%KICAD_CLI%" pcb render "%~dp0%ProjectName%.kicad_pcb" --perspective --quality high --zoom 2.1 -o "%~dp0%ProjectName% render b.png" -w 1920 --side bottom

"%magick%" "%~dp0%ProjectName% render.png" -colors 256 "%~dp0%ProjectName% render.png"
"%magick%" "%~dp0%ProjectName% render.png" -resize 700 -colors 256 "%~dp0%ProjectName% render c.png"
"%magick%" "%~dp0%ProjectName% render b.png" -colors 256 "%~dp0%ProjectName% render b.png"
"%magick%" "%~dp0%ProjectName% render b.png" -resize 700 -colors 256 "%~dp0%ProjectName% render b c.png"

"%ect%" .
