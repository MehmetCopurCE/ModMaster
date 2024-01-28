# ModMaster

<img src="assets/icons/app_icon.png" width="250">

ModMaster is a Flutter-based mobile application that performs data reading and writing operations from devices using the Modbus TCP/IP protocol.


![Flutter](https://img.shields.io/badge/flutter-%2302569B?style=plastic&logo=flutter&logoColor=white) <img src="https://img.shields.io/badge/api-21+-red?style=plastic&logo=android" alt="language"> <img src="https://img.shields.io/badge/architecture-mvvm-yellow?style=plastic" alt="language">

## Contents

- [About the project](#about-the-project)
- [What is Modbus TCP Client ?](#what-is-modbus-tcp-client-)
- [App Images](#app-images)
- [Used Packages](#used-packages)
- [Requirements](#requirements)
- [Setup](#setup)
- [License](#license)
- [Contact With Me](#contact-with-me)


### About the project

The Modbus TCP client is a software component that interacts with industrial automation systems through our mobile application. ModMaster allows the user to interact with devices through this protocol. The home page displays modbus registers and allows new data to be added. The profile page includes the Firebase Authentication integration, while the Settings page edits the modbus connection settings and application preferences. The chart page displays the historical data of the selected register in a graph. Users can easily manage industrial automation via mobile devices and interact with devices through the application.


<!--
settings_page.png
connection_settings.png
| Register Detail Page | Login Page | Connection Settings Page |
|-----------|-----------|-----------|
| <img src="assets/app_images/register_detail_page.jpg" width="200"> | <img src="assets/app_images/chart_page.jpg" width="200"> | <img src="assets/app_images/connection_settings.png" width="200"> | 
-->


### What is Modbus TCP Client ?

Modbus TCP client is a software or device that implements a communication protocol used in industrial automation systems. Its basic function is to carry out data transfer between industrial devices and to interact with control systems and these devices. This allows the Modbus TCP client to perform functions such as reading sensor values, sending control commands, monitoring and controlling remote devices. It also performs remote monitoring, control, data collection and analysis tasks by communicating with devices supporting the Modbus TCP protocol in industrial automation facilities, factories and energy systems. This protocol is also widely used by SCADA systems, which allows the Modbus TCP client to provide an effective connection between SCADA and devices in industrial facilities.


### App Images

| Home Page | Chart Page | Connection Settings | Register Detail Page |
|-----------|-----------|-----------|-----------|
| <img src="assets/app_images/home_page.jpg" width="180"> | <img src="assets/app_images/chart_page.jpg" width="180"> | <img src="assets/app_images/connection_settings.png" width="180"> | <img src="assets/app_images/register_detail_page.jpg" width="180"> |


| Profile Page | Settings Page | Login Page | Register Page |
|-----------|-----------|-----------|-----------|
| <img src="assets/app_images/profile_page.png" width="180"> | <img src="assets/app_images/settings_page.png" width="180"> | <img src="assets/app_images/login_page.png" width="180"> | <img src="assets/app_images/register_page.png" width="180"> |

### Used Packages
- [Flutter Riverpod](https://pub.dev/packages/flutter_riverpod) <br>
  <img src="https://github.com/rrousselGit/riverpod/blob/master/resources/icon/Facebook%20Cover%20A.png?raw=true" width="250"> <br>
- [Modbus](https://pub.dev/packages/modbus) <br>
- [Flutter Localization](https://pub.dev/packages/flutter_localization) <br>
- [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage) <br>
- [Cloud Firestore](https://pub.dev/packages/cloud_firestore) <br>
- [Graphic](https://pub.dev/packages/graphic) <br>
- [Firebase Core](https://pub.dev/packages/firebase_core) <br>
- [Firebase Auth](https://pub.dev/packages/firebase_auth) <br>


### Requirements

You need the following requirements for the application to work:

- [Flutter and Dart SDK](https://docs.flutter.dev/get-started/install)
- An IDE like [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/download)
- Emulator or a physical device


You can use the following commands to check the requirements:

```
flutter doctor
```
### Setup
Steps on how to install the app in your local environment:<br>
1-Clone the repository:
```
git clone https://github.com/MehmetCopurCE/ModMaster.git
```

2-Go to the application directory:
```
cd ModMaster
```
3- Run the application
```
flutter run
```

### License

[MIT License](LICENSE)

### Contact With Me

You can share your opinions and suggestions about the application with me from the links below.

[<img src="assets/images/LinkedIn_logo.png" width="50">](https://www.linkedin.com/in/m-copur/) <a href="mailto:mhmtcpr120@gmail.com?"><img src="https://img.shields.io/badge/gmail-%23DD0031.svg?&style=for-the-badge&logo=gmail&logoColor=white" height = "50"/></a>


### Contributors

<a href="https://github.com/MehmetCopurCE/ModMaster/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=MehmetCopurCE/ModMaster" />
</a>

Made with [contrib.rocks](https://contrib.rocks).
