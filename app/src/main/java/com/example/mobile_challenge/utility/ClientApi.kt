package com.example.mobile_challenge.utility

import com.example.mobile_challenge.model.*
import io.ktor.client.HttpClient
import io.ktor.client.engine.okhttp.OkHttp
import io.ktor.client.request.get
import io.ktor.client.request.parameter
import io.ktor.http.takeFrom
import kotlinx.serialization.UnstableDefault
import kotlinx.serialization.json.Json

@OptIn(UnstableDefault::class)
class ClientApi {

  private val url = "http://api.currencylayer.com"
  private val key = "01e1094551d9f88fa5c01ec84516c1fe"

  private val client = HttpClient(OkHttp)

  // Handle Currency

  suspend fun httpRequestGetList(): ResponseOptionsCurrency {
    return try {
      val json = client.get<String> {
        parameter("access_key", key)
        url {
          takeFrom(this@ClientApi.url)
          encodedPath = "/list"
        }
      }
      return checkForCurrencyResponse(json)
    } catch (e: Exception) {
      ResponseOptionsCurrency.ErrorResponse("Connection Error. $e")
    }
  }

  private fun checkForCurrencyResponse(json: String): ResponseOptionsCurrency {
    return try {
      val currencyResponse = Json.parse(CurrencyResponse.serializer(), json)
      ResponseOptionsCurrency.SuccessResponse(currencyResponse)
    } catch (e: Exception) {
      checkForCurrencyErrorResponse(json)
    }
  }

  private fun checkForCurrencyErrorResponse(json: String): ResponseOptionsCurrency.ErrorResponse {
    return try {
      val errorResponse = Json.parse(ErrorResponse.serializer(), json)
      ResponseOptionsCurrency.ErrorResponse(errorResponse.error.info)
    } catch (e: Exception) {
      ResponseOptionsCurrency.ErrorResponse("Connection Error. $e")
    }
  }

  // Handle Quote

  suspend fun httpRequestGetLive(): ResponseOptionsQuote {
    return try {
      val json = client.get<String> {
        parameter("access_key", key)
        url {
          takeFrom(this@ClientApi.url)
          encodedPath = "/live"
        }
      }
      return checkForQuoteResponse(json)
    } catch (e: Exception) {
      ResponseOptionsQuote.ErrorResponse("Connection Error. $e")
    }
  }

  private fun checkForQuoteResponse(json: String): ResponseOptionsQuote {
    return try {
      val quoteResponse = Json.parse(QuoteResponse.serializer(), json)
      ResponseOptionsQuote.SuccessResponse(quoteResponse)
    } catch (e: Exception) {
      checkForQuoteErrorResponse(json)
    }
  }

  private fun checkForQuoteErrorResponse(json: String): ResponseOptionsQuote.ErrorResponse {
    return try {
      val errorResponse = Json.parse(ErrorResponse.serializer(), json)
      ResponseOptionsQuote.ErrorResponse(errorResponse.error.info)
    } catch (e: Exception) {
      ResponseOptionsQuote.ErrorResponse("Connection Error. $e")
    }
  }
}