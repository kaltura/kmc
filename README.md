# kmc
Kaltura Management Console (aka KMC). For the login project see: https://github.com/kaltura/kmc-login

## Compiling locales:
1. Make sure your Flex SDK3.6 has all required locales (use copyLocale to create missing ones, then copy the framework resource bundles from a more advanced SDK)
Kaltura internal - you can find an up-to-date SDK here: Public\R&D\Front End\flex sdks
2. Use the ant/compileLocale.xml task to compile a specific locale (set LANGUAGE to the required locale code)

## creating a release build:
Use the ant task ant/compile.xml 
Make sure KMC_VERSION is set to the same value as the VERSION var set in KMC.mxml.
Run the task. It should compile all locale files, then compile the different modules, and end with compiling the KED panels.
It will then pack all required files into a folder named as version number.

### failing to run the ant task: java.lang.OutOfMemoryError: PermGen space
1. in flash builder installation folder, edit flashbuilder.ini and flashbuilderC.ini. in both, set the following:
-XX:MaxPermSize=512m
-XX:PermSize=256m
restart FlashBuilder.

2. in flash builder, right click compile.xml, select run as >ant build.. (the one with the dots,that opens the settings window).
in JRE tab, select "Run in the same JRE as the workspace".


