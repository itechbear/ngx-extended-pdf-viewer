cd ..\itechbear-pdf.js
start /wait npm install gulp-cli
start /wait npm install
git checkout 2.13
start /wait .\node_modules\.bin\gulp minified
start /wait .\node_modules\.bin\gulp minified-legacy

cd ..\itechbear-ngx-extended-pdf-viewer
git checkout 12.0.1
start /wait npm install

SET PATH=%PATH%;C:\Windows\WinSxS\amd64_microsoft-windows-xcopy_31bf3856ad364e35_10.0.19041.1_none_18e6b82c93a9c5f6
xcopy ..\itechbear-pdf.js\build\minified\web\locale .\projects\ngx-extended-pdf-viewer\assets\locale\ /S/E/Y
xcopy ..\itechbear-pdf.js\build\minified\web\images\*.svg .\projects\ngx-extended-pdf-viewer\assets\imges\  /S/E/Y
xcopy ..\itechbear-pdf.js\build\minified\web\cmaps .\projects\ngx-extended-pdf-viewer\assets\cmaps\ /S/E/Y
xcopy ..\itechbear-pdf.js\build\minified\build\pdf.* .\projects\ngx-extended-pdf-viewer\assets\ /S/E/Y
xcopy ..\itechbear-pdf.js\build\minified\web\viewer.js* .\projects\ngx-extended-pdf-viewer\assets\ /S/E/Y
xcopy ..\itechbear-pdf.js\build\minified\web\viewer.min* .\projects\ngx-extended-pdf-viewer\assets\ /S/E/Y
xcopy ..\itechbear-pdf.js\build\minified-legacy\build\pdf* .\projects\ngx-extended-pdf-viewer\assets\ /S/E/Y
xcopy ..\itechbear-pdf.js\build\minified-legacy\web\viewer-* .\projects\ngx-extended-pdf-viewer\assets\ /S/E/Y

cd addBaseLanguages
node index.js assets
node add-additional-translations.js assets
cd ..
cd convertI18nFilesToJson
node index.js assets
cd ..

cd add-version-number-to-file-name
node run-outside-ngzone.js
node add-version-number.js
cd ..

start /wait npm run win-package

cd dist\ngx-extended-pdf-viewer
rmdir /s /q bleeding-edge
start npm publish
