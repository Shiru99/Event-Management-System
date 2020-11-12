
# Installation 


**How to install Andriod Studio on Ubuntu**

***0. (Required) Java version > 6.0 :***
```
    $ sudo apt update

    $ sudo apt install default-jre

    $ java -version

    $ sudo apt install default-jdk

    $ javac -version


# Setting the JAVA_HOME Environment Variable :

    $ sudo update-alternatives --config java

    $ sudo nano /etc/environment

        add this < JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64" >

    $ source /etc/environment

    $ echo $JAVA_HOME

```
---




***1. Download the Android Studio package (https://developer.android.com/studio) for Linux and extract it somewhere***

***2. To launch Android Studio :***
```
$ cd android-studio/bin

$ ./studio.sh
```



***3. Set the ANDROID_HOME environment variable***
```
$ sudo gedit ~/.bashrc
 
export ANDROID_HOME=/home/user_directory/Android/Sdk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
```

***4. Download the various files of the Android SDK***

