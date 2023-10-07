
## Authors

Rights Owned By: Defenzelite Private Limited

- [@defenzelite](https://github.com/Defenzelite-HQ)
  The code and any related materials provided by zStarter are for company project purpose use only and may not be used, shared, cloned, or sold for any commercial or non-personal purposes without the express written consent of Defenzelite. Any unauthorized use, sharing, cloning, or selling of the code or related materials is strictly prohibited and may result in legal action.
  ## zFlutter Starter

A starter project to begin any new flutter project.

- It has the `GetX` package and some more custom made helpers and packages to help the dev to build their apps with ease.
- It uses the `MVC` pattern which is one of the best pattern among developers.

## Features

Here are some awesome features which you will get by default when scaffolding your project with this starting project.

- **MVCs Pattern**: We are using MVC pattern to manage whole project easily as it separates the Logic and UI and models. But i added new layer as Service which will help us communicate with APIs.
- **Modular Structure**: Most of the developers are the fan of Modular Structure as it gives the flexibility to use a module on any project we build.
- **Module Generator Tool**: I have built a simple module generator tool to help you generate any module with just a single command.
- **Mockable Services**: Sometimes we don't have any api to test and build our apps so we need to do some mockups for apps here we cover that as well.

- **Module Structure**: 
  - routes
    - router: In this section you will find an index of the pages that handle defined routes within a module.
    - route: In this section we are defining naming for router endpoints.
  - controller: controller is a collection of methods and functionalities within scoped
  - views: In this section we are designing layouts and showing static/dynamic information
  - models: This defines the data structure and datatypes used in given response 
  - services
    - service: This file helps us to configure usability of mock data or api data
    - mock: This file contains a hardcoded mockable data matches model structure
      - We are creating this hardcoded data inside dataset folder within same directory
    - api: This file contains a actual api connectivity with  backend that matches model structure

- **Assets Structure**:
  - audio: This contains all audio related extensions
  - icons: 
  - images:
  - placeholders: 
  - systems: This contains app mandatory assets like launcher icon, loading animation

## Getting Started

Clone zFlutter Starter Repo

```
Goto Git Desktop
File > Clone Repository
Make Sure Tab GitHub.com is selected
Find Your Repository & Select It
Set Proper Local Path
Hit Clone Button
```

Initial Project Setup

Change Project Name (Ask Team Lead if you are unaware)

```
Goto:
    \lib\config\Config.dart
        appName: {Name}
    \android\app\src\main\AndroidManifest.xml
        Change:   android:label="{Name}"
```

Change Package Name (Standard: com.{project_name}.{app/game})

```
Goto:
    \android\app\src\debug\AndroidManifest.xml
        Change: package
    \android\app\src\main\AndroidManifest.xml
        Change: package
    \android\app\src\profile\AndroidManifest.xml
        Change: package
    \android\app\build.gradle
        Change: applicationId
   \pubspec.yaml
        Change: name (Use Format Lower Case, _ For Spaces)
```

Launcher Icon Setup

This Command Line Generate Launcher Icon

```shell
 flutter pub run flutter_launcher_icons:main
```

```
Goto: https://romannurik.github.io/AndroidAssetStudio/icons-launcher.html
    Upload Image
    Adjust Shape
    Rename Name: "launcher_icon"
    Download Zip
Goto
    \android\app\src\main\res
    Extract Downloaded Zip
    Overwrite All
```

Api Config Setup

```bash
  Goto \lib\config\Config.dart
  Change End Points:
    apiBaseUrl: {url}
        //Ask from backend team to provide
```

## A guide to generating modules

### Make Module

This will generate all the files required for a `Module`.

```shell
flutter pub run modulr:generate {Module Name} 
    Use title case for Module Name 
        ex: flutter pub run modulr:generate Blog
        After generate we have to define module in lib/app/modules/Modules.dart
          ex: export 'ModuleDirectoryName/ModuleName.dart';
         Then, Define in lib/routes/Router.dart
          ex: ...moduleNameRoutes, (in camel case)
```

Generated Files:

- `BlogController.dart` controller file.
- `BlogPage.dart` view file.
- `BlogRouter.dart`
- `BlogRoutes.dart`
- `BlogService.dart` abstract service file.
- `MockBlogService.dart` mockable service file for test service.
- `AppBlogService.dart` main service file for Real API Service.
- `BlogModule.dart`

### Make Controller

This will generate the new controller (`CommentController.dart`) inside the `Blog` Module.

```shell
flutter pub run modulr:controller {Controller Name} --on={Module Name}
       Use title case for Controller Name & Module Name 
            ex: flutter pub run modulr:controller Comment --on=Blog
```

Generated Files:

- `CommentController.dart` controller file.

### Make Service

If any module doesn't have services already you can generate services for the module using this command.

```shell
flutter pub run modulr:service {Service Name } --on={Module Name}
    Use title case for Service Name & Module Name 
         ex: flutter pub run modulr:service Comment --on=Blog
```

**_Note: This will check for the services directory inside the provided module name. if it exists it wont generate any file and return void._**

Generated Files:

- `CommentService.dart` abstract service file.
- `MockCommentService.dart` mockable service file for test service.
- `AppCommentService.dart` main service file for Real API Service.

## Create a Play Store abb bundle & App Store ipa bundle for published app

### Generate Keystore File

Details about the client should be provided when you ask

```powershell
What is your first and last name?
  [Unknown]:  ---
What is the name of your organizational unit?
  [Unknown]:  ---
What is the name of your organization?
  [Unknown]:  ----
What is the name of your City or Locality?
  [Unknown]:  ----
What is the name of your State or Province?
  [Unknown]:  ----
What is the two-letter country code for this unit?
  [Unknown]:  IN
```

```bash
Goto:
\android\app\build.gradle
```

At the top of Android, comment out this method

```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
```

At the bottom of Android, comment out this method

```gradle
signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
```

Using this command, keystore file will be generated

```powershell
keytool -genkey -v -keystore D:/important_files/keystores/{App Name}/upload-keystore.jks -alias upload -keyalg RSA -keysize 2048 -validity 10000
```

Create a resource bundle file in the Android folder

```bash
File Name: key.properties
```

Key Properties Details

```properties
storePassword={Password}
keyPassword={Password}
keyAlias=upload
storeFile={File Path}
```

Command line for creating an abb bundle Android App

```bash
flutter build abb
```

Command line for creating an ipa bundle Ios App

```bash
flutter build ipa
```

### Native File Upload

Publish a bundle in the Play Store by uploading a native file.

This Path provide File Explorer

```bash
 Goto:
\build\app\intermediates\merged_native_libs\release\out\lib
```

This native File Zip upload google play store

## Firebase Intergation


### Add this Package in pubspec.yaml

- From your Flutter project directory, run the following command to install the plugin:
```
flutter pub add firebase_core
flutter pub add firebase_messaging
flutter pub add firebase_performance
flutter pub add firebase_crashlytics
flutter pub add flutter_local_notifications
flutter pub get
```
Add Plugin and Dependencies

```
Goto:
\android\app\build.gradle
```
* Add plugin:
```gradle
apply plugin: 'com.google.gms.google-services'
apply plugin: 'com.google.firebase.firebase-perf'
```
* Add Dependencies
```gradle
dependencies{
implementation platform('com.google.firebase:firebase-bom:31.1.1')
implementation 'com.google.firebase:firebase-analytics-ktx'
implementation 'com.google.firebase:firebase-perf-ktx'
}
```

Add Repositories and Dependencies
```
Goto: 
\android\build.gradle
```
* Add repositories
 ```
 repositories {
        mavenCentral()
    }
 ```
* Add Dependencies
 ```
  dependencies {
        classpath 'com.google.gms:google-services:4.3.13'
        classpath 'com.google.firebase:perf-plugin:1.4.2'
    }
 ```

```bash
Goto:
\lib\main.dart
```

### Firebase Messaging

comment out this line

```dart
 await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

   /// Initialize the Firebase Cloud Messaging controller
  Get.put(FCMController(), permanent: true);

```

### Firebase Crashlytics

comment out this line

```dart
runZonedGuarded<Future<void>>(() async {
/// Code write
}, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack,));

Get.put(FCMCrashlyticsController(), permanent: true);

```

### Firebase Intergation Command line

- This Command Line install firebase tools
```
npm install -g firebase-tools
```
- Install the FlutterFire CLI by running the following command from any directory:

```bash
   dart pub global activate flutterfire_cli
```

- Log into Firebase using your Google account by running the following command:

```bash
   firebase login
```

### Configure your apps to use Firebase

#### Initialize Firebase in your app

- From your Flutter project directory, run the following command to ensure that your Flutter app's Firebase configuration is up-to-date:

```bash
   flutterfire configure
```

- Import the Firebase core plugin and the configuration file you generated earlier:

```bash
    import 'package:firebase_core/firebase_core.dart';
    import 'firebase_options.dart';
```

- Initialize Firebase using the DefaultFirebaseOptions object exported by the configuration file:

```bash
  await Firebase.initializeApp(
 options: DefaultFirebaseOptions.currentPlatform,
);
```

## Support

- For support, email hq@defenzelite.com or join our Slack channel.

## Advice

As a developer, it's important to stay up to date with the latest technologies and best practices in your field. A good way to do this is to regularly read industry blogs, participate in online forums, and attend conferences and meetups. Additionally, don't be afraid to experiment and try new things, even if they may seem difficult at first. It's also important to practice good coding habits, such as commenting your code, using version control, and writing readable and maintainable code. Finally, don't be afraid to ask for help or collaborate with other developers, as you can learn a lot from others in the community.

