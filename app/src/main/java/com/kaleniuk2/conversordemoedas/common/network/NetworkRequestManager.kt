package com.kaleniuk2.conversordemoedas.common.network

import com.kaleniuk2.conversordemoedas.data.DataWrapper
import org.json.JSONObject
import java.io.BufferedReader
import java.io.IOException
import java.io.InputStream
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL

object NetworkRequestManager  {
    private const val ERROR = "Erro ao efetuar pesquisa"
    fun makeRequest(urlString: String): DataWrapper<JSONObject> {
        try {
            val url = URL(urlString)
            val urlConnection = url.openConnection() as HttpURLConnection
            urlConnection.connectTimeout = 2000
            urlConnection.readTimeout = 2000

            if (urlConnection.responseCode == HttpURLConnection.HTTP_OK) {
              val response = readStream(urlConnection.inputStream)
              val responseJson = JSONObject(response)

              return DataWrapper.Success(responseJson)
            }
        } catch(e: Exception) {
            return DataWrapper.Error(ERROR)
        }
        return DataWrapper.Error(ERROR)
    }

    private fun readStream(`in`: InputStream): String {
        var reader: BufferedReader? = null
        val response = StringBuffer()
        try {
            reader = BufferedReader(InputStreamReader(`in`))
            var line: String? = ""
            while (reader.readLine().also { line = it } != null) {
                response.append(line)
            }
        } catch (e: IOException) {
            e.printStackTrace()
        } finally {
            if (reader != null) {
                try {
                    reader.close()
                } catch (e: IOException) {
                    e.printStackTrace()
                }
            }
        }
        return response.toString()
    }

}