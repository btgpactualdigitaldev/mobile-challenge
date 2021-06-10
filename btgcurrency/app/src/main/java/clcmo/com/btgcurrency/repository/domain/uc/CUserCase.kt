package clcmo.com.btgcurrency.repository.domain.uc

import clcmo.com.btgcurrency.repository.domain.model.Currency
import clcmo.com.btgcurrency.repository.domain.model.Quote
import clcmo.com.btgcurrency.repository.domain.repository.CRepository
import clcmo.com.btgcurrency.util.Result
import clcmo.com.btgcurrency.util.Result.*
import clcmo.com.btgcurrency.util.constants.Constants.QT_NOT_CALC
import clcmo.com.btgcurrency.util.constants.Constants.QUOTE_USD_INDEX_DEFAULT

class CUserCase(private val repo: CRepository) : CUserCaseI {

    override suspend fun currencies(): Result<List<Currency>> =
        when (val currencies = repo.currencies()) {
            is Failure -> currencies
            else -> {
                when (val quotes = repo.quotes()){
                    is Failure -> quotes
                    else -> Success(acl(
                        (currencies as Success).dataResult,
                        (quotes as Success).dataResult
                    ))
                }
            }
        }

    private fun acl(currencies: List<Currency>, quotes: List<Quote>): List<Currency> =
        currencies.mapNotNull {
            getQuoteById(it.id, quotes)?.let { q->
                it.apply { quote = q }
            }
        }

    override fun getQuoteById(code: String, quoteList: List<Quote>): Quote? =
        quoteList?.firstOrNull { code in it.id.substring(QUOTE_USD_INDEX_DEFAULT) }

    override suspend fun convertValue(qt: Float, from: Currency, to: Currency): Result<Float> {
        return when {
            !qt.isFinite() && qt <= QT_NOT_CALC -> Failure(Exception())
            else -> {
                val fromValue = from.quote?.value ?: return Failure(Exception())
                val toValue = to.quote?.value ?: return Failure(Exception())
                Success(dataResult = (qt / fromValue) * toValue)
            }
        }
    }
}