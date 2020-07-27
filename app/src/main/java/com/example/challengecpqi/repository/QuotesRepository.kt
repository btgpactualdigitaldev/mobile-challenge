package com.example.challengecpqi.repository

import android.content.Context
import com.example.challengecpqi.dao.config.CpqiDataBase
import com.example.challengecpqi.model.Quote
import com.example.challengecpqi.model.response.QuotesResponse
import com.example.challengecpqi.network.config.Result
import com.example.challengecpqi.dao.config.ResultLocal
import com.example.challengecpqi.dao.entiry.*
import com.example.challengecpqi.network.config.ServiceConfig
import com.example.challengecpqi.util.callLocal
import com.example.challengecpqi.util.callService
import com.google.gson.JsonObject
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers
import org.json.JSONObject

class QuotesRepository(
    private val service: ServiceConfig,
    private val context: Context,
    private val dispatcher: CoroutineDispatcher = Dispatchers.IO
) {

    private suspend fun getListQuotesRemote(): Result<JsonObject> {
        return callService(dispatcher) { service.listQuotesService?.getListQuotes()!! }
    }

    suspend fun getListQuotes() : Result<QuotesResponse> {
        return when (val response = getListQuotesRemote()) {
            is Result.NetworkError -> Result.NetworkError
            is Result.GenericError -> Result.GenericError(response.errorResponse)
            is Result.Success -> {
                try {
                    val jsonObject = JSONObject(response.value.toString())
                    val success = jsonObject.getBoolean("success")
                    val terms = jsonObject.getString("terms")
                    val privacy = jsonObject.getString("privacy")
                    val timestamp = jsonObject.getLong("timestamp")
                    val source = jsonObject.getString("source")
                    val quotes = mutableListOf<Quote>()
                    val jsonObjectQuotes = jsonObject.getJSONObject("quotes")
                    val keys = jsonObjectQuotes.keys()
                    while (keys.hasNext()) {
                        val key = keys.next() as String
                        quotes.add(
                            Quote(
                                key,
                                jsonObjectQuotes.getDouble(key)
                            )
                        )
                    }
                    Result.Success(QuotesResponse(success, terms, privacy, timestamp, source, quotes))
                } catch (e: Exception) {
                    Result.NetworkError
                }
            }
        }
    }

    private suspend fun getListQuoteDB(): ResultLocal<QuoteResponseWithQuote?> {
        return callLocal(dispatcher) { CpqiDataBase.invoke(context).quoteResponseDao().allQuoteResponse() }
    }

    suspend fun getListQuoteLocal() : ResultLocal<QuotesResponse> {
        when(val data = getListQuoteDB()) {
            is ResultLocal.Error -> return ResultLocal.Error(data.errorMsg)
            is ResultLocal.Success -> {
                data.value?.also {
                    val quotes = mutableListOf<Quote>()
                    it.quoteEntities?.forEach { quoteEntity ->
                        quotes.add(quoteEntity.toQuote())
                    }
                    return ResultLocal.Success(
                        QuotesResponse(
                        success = it.quoteResponseEntity.success,
                        privacy = it.quoteResponseEntity.privacy,
                        terms = it.quoteResponseEntity.terms,
                        quotes = quotes,
                        source = it.quoteResponseEntity.source,
                        timestamp = it.quoteResponseEntity.timestamp
                        )
                    )
                }
                return ResultLocal.Error(null)
            }
        }
    }

    suspend fun saveQuoteDB(value : QuoteResponseEntity): ResultLocal<Unit> {
        return callLocal(dispatcher) { CpqiDataBase.invoke(context).quoteResponseDao().save(value) }
    }
    suspend fun saveListQuoteDB(value : List<QuoteEntity>): ResultLocal<Unit> {
        return callLocal(dispatcher) { CpqiDataBase.invoke(context).quoteDao().save(value) }
    }

    suspend fun getQuoteResponseEntityDB(): ResultLocal<QuoteResponseEntity?> {
        return callLocal(dispatcher) { CpqiDataBase.invoke(context).quoteResponseDao().getQuoteResponse() }
    }
}