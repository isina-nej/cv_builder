:: Batch script to add required Flutter packages to pubspec.yaml
@echo off
setlocal

:: List of required packages
set packages=provider shared_preferences file_picker pdf docx_template path_provider open_file intl

echo Adding Flutter packages...

:: Loop through each package and add it using flutter pub add
for %%p in (%packages%) do (
    echo Adding %%p...
    call flutter pub add %%p
    if errorlevel 1 (
        echo Error adding %%p
    ) else (
        echo Successfully added %%p
    )
)

echo All packages added successfully.
pause