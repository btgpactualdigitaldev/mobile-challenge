package academy.mukandrew.currencyconverter.data.datasources

import retrofit2.Retrofit

import academy.mukandrew.currencyconverter.commons.Result
import academy.mukandrew.currencyconverter.commons.errors.NetworkException
import academy.mukandrew.currencyconverter.commons.errors.NoContentException
import academy.mukandrew.currencyconverter.data.remote.CurrencyService

class CurrencyRemoteDataSource(retrofit: Retrofit) : CurrencyDataSource() {
    private val service: CurrencyService = retrofit.create(CurrencyService::class.java)

    override suspend fun list(): Result<Map<String, String>> {
        val response = service.listCurrencies()
        return when {
            response.isSuccessful -> {
                val list = response.body()?.currencies ?: return Result.Failure(NoContentException())
                Result.Success(list)
            }
            else -> {
                val message = response.body()?.error?.info ?: String()
                Result.Failure(NetworkException(message))
            }
        }
    }

    override suspend fun quotes(): Result<Map<String, Float>> {
        val response = service.listQuotes()
        return when {
            response.isSuccessful -> {
                val list = response.body()?.quotes ?: return Result.Failure(NoContentException())
                Result.Success(list)
            }
            else -> {
                val message = response.body()?.error?.info ?: String()
                Result.Failure(NetworkException(message))
            }
        }
    }
}