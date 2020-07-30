package br.com.mobilechallenge.utils

import android.content.Context
import android.content.SharedPreferences
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Build
import java.math.RoundingMode
import java.text.DecimalFormat
import java.text.DecimalFormatSymbols
import java.util.*

object Utils {
    fun setStringConfig(context: Context, key: String, value: String) {
        var settings: SharedPreferences = context.getSharedPreferences("config", Context.MODE_PRIVATE)
        var editor: SharedPreferences.Editor = settings.edit()
        editor.putString(key, value)
        editor.apply()
    }

    fun getStringConfig(context: Context, key: String?) : String? {
        var config: SharedPreferences = context.getSharedPreferences("config", Context.MODE_PRIVATE)
        return config.getString(key, "")
    }

    @Suppress("DEPRECATION")
    fun isInternetConnect(context: Context): Boolean {
        var result = false
        val cm = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager?

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            cm?.run {
                cm.getNetworkCapabilities(cm.activeNetwork)?.run {
                    result = when {
                        hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> true
                        hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) -> true
                        hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) -> true
                        else -> false
                    }
                }
            }
        }
        else {
            cm?.run {
                cm.activeNetworkInfo?.run {
                    if (type == ConnectivityManager.TYPE_WIFI) {
                        result = true
                    }
                    else if (type == ConnectivityManager.TYPE_MOBILE) {
                        result = true
                    }
                }
            }
        }
        return result
    }

    fun roundOffDecimal(number: Double): String? {
        val df = DecimalFormat("#.##", DecimalFormatSymbols(Locale.US))
            df.roundingMode = RoundingMode.FLOOR
        return df.format(number)
    }
}