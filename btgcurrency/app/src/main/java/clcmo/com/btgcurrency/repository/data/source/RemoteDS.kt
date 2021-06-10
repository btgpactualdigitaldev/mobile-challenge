package clcmo.com.btgcurrency.repository.data.source

import clcmo.com.btgcurrency.repository.data.remote.CService
import clcmo.com.btgcurrency.util.Result
import clcmo.com.btgcurrency.util.Result.*
import clcmo.com.btgcurrency.util.exceptions.Exception
import retrofit2.Retrofit

class RemoteDS(retrofit: Retrofit) : DataSource{
    private val service: CService = retrofit.create(CService::class.java)

    override suspend fun currencies(): Result<Map<String, String>> {
        val response = service.listCurrencies()
        return when {
            response.isSuccessful -> {
                val list = response.body()?.mapCurrencies ?: return Failure(Exception())
                Success(list)
            }
            else -> {
                val message = response.body()?.error?.desc ?: String()
                Failure(Exception(message))
            }
        }
    }

    override suspend fun quotes(): Result<Map<String, Float>> {
        val response = service.listQuotes()
        return when {
            response.isSuccessful -> {
                val list = response.body()?.mapQuotes ?: return Failure(Exception())
                Success(list)
            }
            else -> {
                val message = response.body()?.error?.desc ?: String()
                Failure(Exception(message))
            }
        }
    }
}