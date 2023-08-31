## Deploying to App Store
Follow instructions from the official flutter [documentation](https://docs.flutter.dev/deployment/ios) and [this](https://www.youtube.com/watch?v=i3BEo-jxxRo&ab_channel=TechJarves) video optionally

## Deploying to Google Play
Following instructions from [this](https://www.youtube.com/watch?v=ieOdT-p603Y&ab_channel=ShohruhAK) tutorial by Shohruh AK, with written instructions [here](https://www.shohruhak.com/tech/how_to_publish_flutter_app_on_play_store_beginner_guide/) in conjunction with [this](https://docs.flutter.dev/deployment/android) official Flutter documentation

### Signing the App

* Start by installing Java JDK to allow access to the keytool command
* Ensure the PATH to the jdk bin folder where the keytool application is located is added to your environment variables
* Use PowerShell
* Follow instructions to generate a new key, and set a password for your key - the %userprofile% syntax should be replaced with the hardcoded path to your User folder
    * Remember not to upload key or key.properties files
```
  keytool -genkey -v -keystore c:\Users\<username>\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
* Your password is used whenever updates to the application are needed, because you want to use the upload key that was just generated
* Provide your first and last name, city, etc. (you can skip the organization name by pressing enter)</br></br>

* Create the key.properties file in the android folder - remember not to upload the key.properties file
* Then, in the build.gradle file, paste the keystore methods above the android{} block, but after the existing keystore information
  * This codeblock will cause the app to load the key.properties file created in the previous step (creates an input stream)
* Now, update the release block in the buildTypes block to use signingConfigs.release, and add the signingConfigs block above the buildTypes block
  * This configures our release version of the app and uses the key.properties to set the config
* At this point, run the application to check that there are no errors

### Shrinking Your Code with R8
* R8 is automatically enabled when building release versions of your app

### Publishing Your Application
* Following the official Flutter documentation, confirm the AndroidManifest.xml files and gradle build configurations (did not do this step for the practice run)
  * This includes information like the version number and the name of the application
* Run the flutter build appbundle command to create the release app bundle (located in build/app/outputs/bundle/release/app-release.aab)
* Then, navigate to the Play Console to create a new application
  * At around minute 16:00 of the video tutorial, AK walks through creating a release for internal testing
* At this point, you can create a new release using the Google Console to upload the build of the release (upload app-release.aab)
  * Skip to around 30:50 to for a walkthrough of creating a new release


## Resources
[https://stackoverflow.com/questions/19431788/keytool-is-not-recognized-as-an-internal-or-external-command](https://stackoverflow.com/questions/19431788/keytool-is-not-recognized-as-an-internal-or-external-command)</br>
[https://stackoverflow.com/questions/4830253/where-is-the-keytool-application](https://stackoverflow.com/questions/4830253/where-is-the-keytool-application)</br>
[https://stackoverflow.com/questions/71785652/keytool-error-java-io-filenotfoundexception-c-users-user-name-upload-keystore](https://stackoverflow.com/questions/71785652/keytool-error-java-io-filenotfoundexception-c-users-user-name-upload-keystore)</br>
[]()</br>
