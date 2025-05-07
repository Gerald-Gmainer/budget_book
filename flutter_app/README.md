# flutter_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

| Tool                              | Required Version         | Verification / Install Command                                                              |
|-----------------------------------|--------------------------|---------------------------------------------------------------------------------------------|
| **FVM (Flutter Version Manager)** | latest stable (>= 2.0.0) | `fvm --version`                                                                             |
| **Flutter SDK**                   | 3.13.5 (stable)          | `fvm use 3.13.5 && fvm flutter --version`                                                   |
| **Java (Temurin via SDKMAN)**     | 11.0.20-tem              | ```bash<br>sdk install java 11.0.20-tem<br>sdk default java 11.0.20-tem<br>java -version``` |
| **Android SDK Platform**          | android-33               | `sdkmanager "platforms;android-33" "build-tools;33.0.2"`                                    |
| **Android NDK**                   | 25.1.8937393             | _configured in_ `android/app/build.gradle`                                                  |
| **Gradle Wrapper**                | 8.4                      | _check_ `android/gradle/wrapper/gradle-wrapper.properties`                                  |
| **Android Gradle Plugin**         | 8.3.1                    | _check_ `android/build.gradle`                                                              |
| **Kotlin**                        | 1.9.0                    | _check_ `buildscript.ext.kotlin_version`                                                    |
| **compileSdkVersion**             | 33                       | _check_ `android/app/build.gradle`                                                          |
| **targetSdkVersion**              | 33                       | _check_ `android/app/build.gradle`                                                          |
| **minSdkVersion**                 | 19                       | _check_ `android/app/build.gradle`                                                          |