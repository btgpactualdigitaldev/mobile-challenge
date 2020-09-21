package br.com.leandrospidalieri.btgpactualconversion.util

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkInfo
import androidx.lifecycle.MutableLiveData
import java.math.RoundingMode
import java.text.DecimalFormat

fun <T> MutableLiveData<T>.notifyObserver() {
    this.value = this.value
}

fun Double.toFormattedCurrencyString():String{
    val dec = DecimalFormat("###,###,##0.00")
    dec.roundingMode = RoundingMode.CEILING

    return dec.format(this)
}

fun hasNetwork(context: Context): Boolean {
    var isConnected = false
    val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
    val activeNetwork: NetworkInfo? = connectivityManager.activeNetworkInfo
    if (activeNetwork != null && activeNetwork.isConnected)
        isConnected = true
    return isConnected
}