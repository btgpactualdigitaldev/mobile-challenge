package br.com.daccandido.currencyconverterapp.data.database

import br.com.daccandido.currencyconverterapp.data.model.Currency
import br.com.daccandido.currencyconverterapp.dataBaseRealm
import io.realm.RealmResults
import io.realm.kotlin.where
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class CurrencyDAO {

    suspend fun insertOrUpdate (currency: Currency, result: (Boolean) -> Unit) {
        withContext(Dispatchers.IO) {
            dataBaseRealm.executeTransaction { realm ->
                realm.where(Currency::class.java).equalTo("code", currency.code).findFirst()?.let {
                    if (currency.quote > 0) {
                        it.quote = currency.quote
                        currency.name = it.name
                        currency.id = it.id
                        currency.code = it.code
                    }
                    if (currency.name.isEmpty().not()) {
                        it.name = currency.name
                        currency.id = it.id
                        currency.code = it.code
                        currency.quote = it.quote
                    }

                    realm.copyToRealmOrUpdate(currency)?.let {
                        result(true)
                    } ?: run {
                        result(false)
                    }
                } ?: run {
                    val maxValue = realm.where<Currency>().max("id")
                    val primaryKey = (maxValue?.toLong() ?: 0) + 1
                    currency.id = primaryKey
                    realm.copyToRealm(currency)?.let {
                        result(true)
                    } ?: run {
                        currency.id = 0
                        result(false)
                    }
                }
            }
        }
    }

    fun getAllCurrencies (sort: String) : RealmResults<Currency> {
        return dataBaseRealm.where(Currency::class.java).sort(sort).findAll()
    }

    fun searchCurrency (sort: String, filter:String ) : RealmResults<Currency> {
        return dataBaseRealm
            .where(Currency::class.java)
            .beginGroup()
                .contains("code", filter.toUpperCase())
                    .or()
                .contains("name", filter)
                    .or()
                .equalTo("code", filter.toUpperCase())
                    .or()
                .equalTo("name", filter)
            .endGroup()
            .sort(sort).findAll()
    }

    fun getCurrency (field: String, value: String) : Currency? {
        return dataBaseRealm.where(Currency::class.java).equalTo(field, value).findFirst()
    }
}