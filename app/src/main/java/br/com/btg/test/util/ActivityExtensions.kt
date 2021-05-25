package br.com.btg.test.util

import android.app.Activity
import android.content.Context
import android.location.LocationManager
import android.util.DisplayMetrics
import android.view.View
import android.view.WindowManager
import android.view.inputmethod.InputMethodManager
import androidx.appcompat.app.AppCompatActivity

fun Activity.setFlagKeepScreenOn() {
    window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
}

fun Activity.clearFlagKeepScreenOn() {
    window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
}

fun Activity.setFlagLayoutFullscreen() {
    window.decorView.systemUiVisibility =
        View.SYSTEM_UI_FLAG_LAYOUT_STABLE or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
}

fun Activity.setFlagTranslucentNavigationAndStatus() {
    window.addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION or WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
}

fun Activity.getScreenWidth() =
    DisplayMetrics().apply { window.windowManager.defaultDisplay.getMetrics(this) }.widthPixels

fun Activity.isLocationServiceEnabled(callback: (enabled: Boolean) -> Unit) {
    val lm = getSystemService(Context.LOCATION_SERVICE) as LocationManager
    val isOn = lm.isProviderEnabled(LocationManager.GPS_PROVIDER)
    callback(isOn)
}

inline fun <reified T> Activity.extra(key: String): Lazy<T> = lazy {
    val value = intent.extras?.get(key)
    if (value is T) {
        value
    } else {
        throw IllegalArgumentException(
            "Couldn't find extra with key \"$key\" from type " +
                T::class.java.canonicalName
        )
    }
}

inline fun <reified T> Activity.extra(key: String, crossinline default: () -> T): Lazy<T> = lazy {
    val value = intent.extras?.get(key)
    if (value is T) value else default()
}

fun AppCompatActivity.showKeyboard() {
    val inputMethodManager = getSystemService(Context.INPUT_METHOD_SERVICE) as? InputMethodManager
    inputMethodManager?.toggleSoftInput(InputMethodManager.SHOW_FORCED, 0)
}

fun AppCompatActivity.hideKeyboard() = hideKeyboard(currentFocus ?: View(this))

fun Context.hideKeyboard(view: View) {
    val inputMethodManager = getSystemService(Context.INPUT_METHOD_SERVICE) as? InputMethodManager
    inputMethodManager?.hideSoftInputFromWindow(view.windowToken, 0)
}
