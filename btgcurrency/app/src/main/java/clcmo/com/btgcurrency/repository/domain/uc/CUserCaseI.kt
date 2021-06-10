package clcmo.com.btgcurrency.repository.domain.uc

import clcmo.com.btgcurrency.repository.domain.model.*
import clcmo.com.btgcurrency.util.Result

interface CUserCaseI {
    suspend fun currencies(): Result<List<Currency>>
    fun getQuoteById(code: String, quoteList: List<Quote>): Quote?
    suspend fun convertValue(qt: Float, from: Currency, to: Currency) : Result<Float>
}

