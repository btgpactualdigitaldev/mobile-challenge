package clcmo.com.btgcurrency.repository.domain.repository

import clcmo.com.btgcurrency.repository.data.source.DataSource
import clcmo.com.btgcurrency.repository.domain.model.*
import clcmo.com.btgcurrency.util.Result
import clcmo.com.btgcurrency.util.Result.*
import clcmo.com.btgcurrency.util.constants.Constants.QT_QUOTE
import clcmo.com.btgcurrency.util.exceptions.Exception as E

class CRepository(
    private val lds: DataSource, private val rds: DataSource
) : CRepositoryI {

    override suspend fun currencies(): Result<List<Currency>> = try {
        when (val rResponse = rds.currencies()) {
            is Success -> Success(acl(rResponse.dataResult))
            else -> {
                val lResponse = lds.currencies()
                when {
                    lResponse is Failure || (lResponse as Success).dataResult.isEmpty() ->
                        (rResponse as? Failure) ?: Failure(E())
                    else -> Success(acl(lResponse.dataResult))
                }
            }
        }
    } catch (e: Exception) {
        Failure(e)
    }

    override suspend fun quotes(): Result<List<Quote>> = try {
        when (val rResponse = rds.quotes()) {
            is Success -> Success(aql(rResponse.dataResult))
            else -> {
                val lResponse = lds.quotes()
                when {
                    lResponse is Failure || (lResponse as Success).dataResult.isEmpty() ->
                        (rResponse as? Failure) ?: Failure(E())
                    else -> Success(aql(lResponse.dataResult))
                }
            }
        }
    } catch (e: Exception) {
        Failure(e)
    }

    override suspend fun acl(cMap: Map<String, String>) = cMap.map { Currency(it.key, it.value)  }

    override suspend fun aql(qMap: Map<String, Float>) = qMap.map { Quote(it.key, QT_QUOTE, it.value) }
}