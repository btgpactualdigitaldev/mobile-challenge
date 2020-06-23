package com.example.currencyconverter.infrastructure.database

import com.example.currencyconverter.entity.Currency
import io.realm.Realm
import io.realm.RealmList
import java.util.*

class DatabaseInstance: Database {

    private lateinit var realm: Realm

    override fun onCreate() {
        realm = Realm.getDefaultInstance()
    }

    override fun getCurrencies(): List<Currency> {
        val response = mutableListOf<Currency>()
        val realmList = realm.where(DatabaseCurrencyModel::class.java).findAll()
        realmList.forEach {
            response.add(Currency(it.symbol, it.name, it.quote))
        }
        return response
    }

    override fun postCurrencies(currencies: List<Currency>) {

        currencies.forEach {
            val currencyToAdd = DatabaseCurrencyModel(it.symbol, it.name, it.quote)
            realm.beginTransaction()
            realm.insertOrUpdate(currencyToAdd)
            realm.commitTransaction()
        }
    }

    override fun onDestroy() {
        realm.close()
    }
}