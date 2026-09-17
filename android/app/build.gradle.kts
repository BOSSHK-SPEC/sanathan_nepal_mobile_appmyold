plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.sanathan_nepal_mobile_app"
    // Pinned above Flutter's default (36) because permission_handler_android —
    // pulled in for the microphone and camera prompts a call needs — compiles
    // against 37. Compiling against a newer SDK is backward compatible; what
    // is not compatible is a plugin compiled against a level the app does not
    // know, which fails the build outright. Revisit when Flutter's default
    // catches up and this line becomes a no-op.
    compileSdk = 37
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // Required by flutter_local_notifications, which schedules and formats
        // notifications with java.time — an API that does not exist on the
        // older Android versions this app still supports. Desugaring back-fills
        // it at build time; without it the build fails outright rather than
        // degrading, which is why this is not optional.
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.sanathan_nepal_mobile_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    // The library the desugaring above rewrites calls against. Version pinned
    // to what flutter_local_notifications itself depends on: an older one is
    // rejected by the plugin's AAR metadata check.
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
