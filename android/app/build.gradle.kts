// Root-level Gradle plugins
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin") // Flutter plugin (after Android & Kotlin)
}

android {
    namespace = "com.example.construction_manager_app" // App package name (Change if needed)

    // SDK & NDK Config
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973" // ✅ Forced to highest NDK version as per plugin requirement

    // Java compatibility options
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    // Kotlin JVM compatibility
    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    // Default App Config
    defaultConfig {
        applicationId = "com.example.construction_manager_app" // App ID used for Play Store
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // Build Type Configurations
    buildTypes {
        release {
            // Right now signing with debug keys so 'flutter run --release' works
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

// Flutter SDK Source Path
flutter {
    source = "../.." // Relative path to your Flutter SDK
}
