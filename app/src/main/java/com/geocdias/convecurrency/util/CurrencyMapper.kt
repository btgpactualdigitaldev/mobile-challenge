package com.geocdias.convecurrency.util

import com.geocdias.convecurrency.data.database.entities.CurrencyEntity
import com.geocdias.convecurrency.data.database.entities.ExchangeRateEntity
import com.geocdias.convecurrency.data.network.response.CurrencyListResponse
import com.geocdias.convecurrency.data.network.response.ExchangeRateResponse
import com.geocdias.convecurrency.model.CurrencyModel
import com.geocdias.convecurrency.model.ExchangeRateModel

abstract class Mapper<T,I> {
    abstract fun map(origin: T): I

    fun mapList(origin: List<T>) : List<I> = origin.map { map(it) }
}

data class CurrencyMapper(
    val remoteCurrencyListToDbMapper: RemoteCurrencyListToDb,
    val remoteExchangeRateToDbMapper: RemoteExchangeRateToDb,
    val currencyEntityToDomainMapper: CurrencyEntityToModel,
    val exchangeRateEntityToModel: ExchangeRateEntityToModel
)

class RemoteCurrencyListToDb: Mapper<CurrencyListResponse, List<CurrencyEntity>>(){
    override fun map(origin: CurrencyListResponse): List<CurrencyEntity> {
        return origin.currencies.entries.map { entry ->
            CurrencyEntity(
                code = entry.key,
                name = entry.value
            )
        }
    }
}

class RemoteExchangeRateToDb: Mapper<ExchangeRateResponse, List<ExchangeRateEntity>>(){
    override fun map(origin: ExchangeRateResponse): List<ExchangeRateEntity> {
        return origin.quotes.map { quote ->
            ExchangeRateEntity(
                quote = quote.key,
                rate = quote.value.toDouble()
            )
        }
    }
}

class CurrencyEntityToModel: Mapper<CurrencyEntity, CurrencyModel>() {
    override fun map(origin: CurrencyEntity): CurrencyModel {
        return CurrencyModel(
            code = origin.code,
            name = origin.name
        )
    }
}

class ExchangeRateEntityToModel: Mapper<ExchangeRateEntity?, ExchangeRateModel>() {
    override fun map(origin: ExchangeRateEntity?): ExchangeRateModel {
        return ExchangeRateModel(
            rate = origin?.rate ?: 0.0
        )
    }
}
