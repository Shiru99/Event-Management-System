
# Installation 


**How to install Flutter on Ubuntu**

***1. Download the Flutter SDK (https://flutter.dev/docs/get-started/install) for Linux version.and extract it somewhere***

***2. update the PATH to add the Flutter SDK.***
```
$ gedit .bashrc

    export PATH={path-of-sdk}/flutter/bin:$PATH  (Add This)

$ flutter doctor --android-licenses

$ flutter doctor

Output : 

    Doctor summary (to see all details, run flutter doctor -v):
    [✓] Flutter (Channel stable, 1.22.3, on Linux, locale en_IN)
    [✓] Android toolchain - develop for Android devices (Android SDK version 30.0.2)
    [✓] Android Studio (version 4.0)
    [✓] VS Code (version 1.51.0)
    [!] Connected device
        ! No devices available

    ! Doctor found issues in 1 category.
```

***3. Download and install Flutter plugin in Android Studio:***
```
Android Studio->File->Settings->Plugins

install Flutter and Dart plugin for Android Studio
```

