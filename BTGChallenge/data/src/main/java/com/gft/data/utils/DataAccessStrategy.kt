package com.gft.data.utils

import com.gft.domain.entities.Resource
import org.json.JSONException
import org.json.JSONObject
import retrofit2.Response

abstract class SafeApiRequest {
    suspend fun <T : Any> apiRequest(call: suspend () -> Response<T>): Resource<T> {

        val response = call.invoke()
        val message = StringBuilder()

        return if (response.isSuccessful) {
            Resource.success(response.body()!!)
        } else {
            val error = response.errorBody().toString()
            error.let {
                try {
                    message.append(JSONObject(it).getString("message"))
                } catch (e: JSONException) {
                    message.append("\n")
                }

            }
            Resource.error(message.toString())
        }
    }
}