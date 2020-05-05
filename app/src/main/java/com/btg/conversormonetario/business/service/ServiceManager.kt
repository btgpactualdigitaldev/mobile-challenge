package com.btg.conversormonetario.business.service

import com.btg.conversormonetario.data.model.ErrorModel
import com.btg.conversormonetario.data.model.ServiceErrorModel
import com.google.gson.GsonBuilder
import org.json.JSONObject
import retrofit2.Response
import java.io.IOException

open class ServiceManager {
    companion object {
        const val HTTP_OK = 200
        const val HTTP_UNAUTHORIZED = 401
        const val HTTP_INTERNAL_SERVER_ERROR = 500

        fun <T> serviceCaller(
            api: Response<T>,
            onSuccess: (T) -> Unit,
            onError: (ServiceErrorModel) -> Unit
        ) {
            if (api.code() == HTTP_OK) {
                try {
                    onSuccess.invoke(api.body()!!)
                } catch (exception: Exception) {
                    errorResponse(api, onError)
                }
            } else {
                errorResponse(api, onError)
            }
        }

        private fun errorResponse(
            api: Response<*>,
            onError: (ServiceErrorModel) -> Unit
        ) {
            try {
                val errorBodySerialized = JSONObject(api.errorBody()?.string() ?: "")
                val objectError = errorBodySerialized.getJSONObject("error")
                onError.invoke(
                    ServiceErrorModel(
                        httpCode = api.code(),
                        throwable = api.errorBody(),
                        response = ErrorModel(
                            objectError.getInt("code"),
                            objectError.getString("info")
                        )
                    )
                )
            } catch (exception: IOException) {
                applyThrowableResponse(api, onError)
            }
        }

        @Synchronized
        private fun applyThrowableResponse(
            api: Response<*>,
            onError: (ServiceErrorModel) -> Unit
        ) {
            val error = ServiceErrorModel()
            error.httpCode = api.code()
            error.throwable = api.errorBody()
            error.response = getErrorModel(api, onError)
            when (error.httpCode) {
                HTTP_UNAUTHORIZED -> onError.invoke(error)
                in HTTP_INTERNAL_SERVER_ERROR..599 -> onError.invoke(error)
                else -> onError.invoke(error)
            }
        }

        private fun getErrorModel(
            api: Response<*>,
            onError: (ServiceErrorModel) -> Unit
        ): ErrorModel {
            return try {
                GsonBuilder().create().fromJson(api.body().toString(), ErrorModel::class.java)
            } catch (e: Exception) {
                applyThrowableResponse(api, onError)
                getEmptyErrorBody()
            }
        }

        private fun getEmptyErrorBody(): ErrorModel =
            GsonBuilder().create().fromJson("{}", ErrorModel::class.java)
    }
}