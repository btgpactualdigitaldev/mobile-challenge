package br.com.btg.mobile.challenge.helper

import okhttp3.MediaType.Companion.toMediaTypeOrNull
import okhttp3.ResponseBody.Companion.toResponseBody
import retrofit2.HttpException
import retrofit2.Response

const val INTERNAL_SERVER_ERROR_CODE = 500

const val CONTENT_ERROR = "Test Server Error"
const val TEXT_PLAIN = "text/plain"

object ExceptionTestData {

    val HTTP_EXCEPTION_ERROR_500_DATA = HttpException(
        Response.error<Any>(
            INTERNAL_SERVER_ERROR_CODE,
            CONTENT_ERROR.toResponseBody(TEXT_PLAIN.toMediaTypeOrNull())
        )
    )
}
