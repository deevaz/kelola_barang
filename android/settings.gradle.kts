pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }

    // ▼▼▼ Ambil path Flutter SDK dari local.properties ▼▼▼
    val localProperties = java.util.Properties().apply {
        file("local.properties").inputStream().use { load(it) }
    }
    
    val flutterSdkPath = localProperties.getProperty("flutter.sdk")
        ?: throw GradleException("flutter.sdk tidak ditemukan di local.properties")
    
    includeBuild(File(flutterSdkPath, "packages/flutter_tools/gradle"))
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.name = "kelola_barang"
include(":app")