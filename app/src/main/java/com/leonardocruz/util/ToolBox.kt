package com.leonardocruz.util

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkInfo
import com.google.gson.Gson
import com.google.gson.JsonArray
import com.google.gson.reflect.TypeToken
import com.leonardocruz.btgteste.model.Currencies
import com.leonardocruz.btgteste.model.CurrencyLive
import java.lang.Exception
import java.util.*
import kotlin.collections.ArrayList

class ToolBox

fun convertHashMapToList(hash: HashMap<String, String>): MutableList<Currencies> {
    val listCurrency = mutableListOf<Currencies>()
    val entrySet: Set<Map.Entry<String, String>> = hash.entries
    ArrayList(entrySet).forEach {
        listCurrency.add(Currencies(it.key, it.value))
    }
    return listCurrency
}

fun String.safeDouble() : Double {
    return try{
        this.toDouble()
    } catch (e:Exception){
        -1.0
    }
}

fun parseJsonList(json: JsonArray?): MutableList<Currencies>? {
    val type = object : TypeToken<MutableList<Currencies?>?>() {}.type
    return Gson().fromJson(json, type)
}

fun testConnection(context: Context): Boolean {
    val connectivityManager =
        context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
    val networkInfo: NetworkInfo?
    if (connectivityManager != null) {
        networkInfo = connectivityManager.activeNetworkInfo
        return networkInfo != null && networkInfo.isConnected &&
                (networkInfo.type == ConnectivityManager.TYPE_WIFI
                        || networkInfo.type == ConnectivityManager.TYPE_MOBILE)
    }
    return false
}
