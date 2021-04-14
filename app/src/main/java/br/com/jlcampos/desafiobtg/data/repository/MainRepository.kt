package br.com.jlcampos.desafiobtg.data.repository

import br.com.jlcampos.desafiobtg.utils.Constants
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.Response
import org.json.JSONObject
import org.json.JSONStringer
import java.io.IOException
import java.util.*
import java.util.concurrent.TimeUnit

class MainRepository {

    fun getListRepo(): String {

        var json: String
        val client = OkHttpClient()

        val request = Request.Builder()
                .url(Constants.list_ws)
                .build()

        val client1: OkHttpClient = client.newBuilder()
                .readTimeout(99999, TimeUnit.SECONDS)
                .build()

        try {
            val response: Response = client1.newCall(request).execute()

            json = Objects.requireNonNull(response.body()?.string())!!

        } catch (e: IOException) {
            json = JSONStringer().`object`()
                    .key(Constants.SUCCESS)
                    .value(false)
                    .key(Constants.ERROR)
                    .value(JSONObject(
                            JSONStringer().`object`()
                                    .key(Constants.CODE)
                                    .value(Constants.ERROR_CONNECT)
                                    .key(Constants.INFO)
                                    .value(e.message.toString()
                                    ).endObject().toString()
                    )
                    ).endObject()
                    .toString()
        }

        return json
    }

    fun getQuote(currencies: String, source: String): String {
        var json: String
        val client = OkHttpClient()

        val request = Request.Builder()
                .url(Constants.live_ws + Constants.live_currencies + currencies + Constants.live_source + source)
                .build()

        val client1: OkHttpClient = client.newBuilder()
                .readTimeout(99999, TimeUnit.SECONDS)
                .build()

        try {
            val response: Response = client1.newCall(request).execute()

            json = Objects.requireNonNull(response.body()?.string())!!

        } catch (e: IOException) {
            json = JSONStringer().`object`()
                    .key(Constants.SUCCESS)
                    .value(false)
                    .key(Constants.ERROR)
                    .value(JSONObject(
                            JSONStringer().`object`()
                                    .key(Constants.CODE)
                                    .value(Constants.ERROR_CONNECT)
                                    .key(Constants.INFO)
                                    .value(e.message.toString()
                                    ).endObject().toString()
                    )
                    ).endObject()
                    .toString()
        }

        return json
    }
}