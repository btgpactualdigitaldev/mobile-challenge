# Retrofit
-keepattributes Signature, InnerClasses, EnclosingMethod
-keepattributes RuntimeVisibleAnnotations, RuntimeVisibleParameterAnnotations

-keepclassmembers,allowshrinking,allowobfuscation interface * {
    @retrofit2.http.* <methods>;
}

-dontwarn org.codehaus.mojo.animal_sniffer.IgnoreJRERequirement
-dontwarn javax.annotation.**
-dontwarn kotlin.Unit
-dontwarn retrofit2.KotlinExtensions
-dontwarn retrofit2.KotlinExtensions$*

-if interface * { @retrofit2.http.* <methods>; }
-keep,allowobfuscation interface <1>


### KOTLIN
-keep class kotlinx.coroutines.android.AndroidExceptionPreHandler { *; }
-keep class kotlinx.coroutines.CoroutineExceptionHandlerImplKt { *; }
-dontnote kotlinx.coroutines.**
-dontnote kotlin.coroutines.AbstractCoroutineContextElement


### ANDROIDX
-dontwarn androidx.camera.extensions.**
-dontwarn androidx.fragment.app.FragmentKt
-dontwarn androidx.fragment.app.FragmentResultListener
-dontwarn androidx.window.extensions.**
-dontwarn androidx.window.sidecar.**
-keep,includedescriptorclasses class * extends androidx.lifecycle.ViewModel
-keep,includedescriptorclasses class * extends androidx.lifecycle.AndroidViewModel {
    <init>(android.app.Application);
}


# Crash
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception
-keep class com.crashlytics.** { *; }
-dontwarn com.crashlytics.**


# Reflection
-dontwarn kotlin.reflect.jvm.internal.**
-keep class kotlin.reflect.jvm.internal.** { *; }


# Build
-keep class br.com.btg.mobile.challenge.BuildConfig { *; }


# Project
-keep class br.com.btg.mobile.challenge.data.model.** { *; }

### OKHTTP
-dontnote okio.**
-dontwarn okhttp3.internal.platform.**
-dontnote okhttp3.**


### REMOVE LOGS
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int i(...);
    public static int w(...);
    public static int d(...);
    public static int e(...);
}
