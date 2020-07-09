package com.carlos.silva.desafiobtg.data.networks

import android.content.Context
import com.carlos.silva.desafiobtg.R
import com.carlos.silva.desafiobtg.data.models.Currencies
import com.carlos.silva.desafiobtg.data.models.Quotes
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import okhttp3.OkHttpClient
import okhttp3.Request

class CurrencyLayerLoader {
    companion object {
        suspend fun loadCurrencies(context: Context?): Currencies? {
            val key = context?.getString(R.string.key_api)
            val apiURL = context?.getString(R.string.api_url)
            val listURL = context?.getString(R.string.list)
                ?.format(apiURL)
                .plus(key)

            val connection = OkHttpClient.Builder()
                .build()

            val request = Request.Builder()
                .url(listURL)
                .build()

            return withContext(Dispatchers.IO) {
                connection.newCall(request)
                    .execute().body?.let {
                        val type = object : TypeToken<Currencies>() {}.type
                        val result = Gson().fromJson<Currencies>(it.string(), type)
                        result
                    }
            }
        }

        suspend fun loadQuotes(context: Context?): Quotes? {
            val key = context?.getString(R.string.key_api)
            val apiURL = context?.getString(R.string.api_url)
            val listURL = context?.getString(R.string.live)
                ?.format(apiURL)
                .plus(key)

            val connection = OkHttpClient.Builder()
                .build()

            val request = Request.Builder()
                .url(listURL)
                .build()

            return withContext(Dispatchers.IO) {
                connection.newCall(request)
                    .execute().body?.let {
                        val type = object : TypeToken<Quotes>() {}.type
                        val result = Gson().fromJson<Quotes>(it.string(), type)
                        result
                    }
            }
        }
    }
}