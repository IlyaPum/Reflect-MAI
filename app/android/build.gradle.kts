allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

// Старые плагины (например tflite_flutter 0.11, compileSdk 31) тянут androidx
// зависимости, требующие compileSdk 34+. Поднимаем compileSdk всем библиотечным
// модулям до 36 — на этапе применения плагина, когда extension уже создан,
// но проект ещё не оценён (afterEvaluate здесь невозможен).
subprojects {
    pluginManager.withPlugin("com.android.library") {
        extensions.configure<com.android.build.api.dsl.LibraryExtension>("android") {
            if ((compileSdk ?: 0) < 36) compileSdk = 36
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
