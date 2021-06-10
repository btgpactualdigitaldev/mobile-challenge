package clcmo.com.btgcurrency.repository.data.source

import clcmo.com.btgcurrency.util.Result

interface DataSource {
    suspend fun currencies(): Result<Map<String, String>>
    suspend fun quotes(): Result<Map<String, Float>>
    fun saveC(mCurrencies: Map<String, String>) = Unit
    fun saveQ(mQuotes: Map<String, Float>) = Unit
}