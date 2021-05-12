package com.leonardo.convertcoins.services

import android.content.Context
import com.leonardo.convertcoins.models.RealtimeRates
import com.leonardo.convertcoins.models.SupportedCurrencies

class SQLiteService(context: Context, mode: Int) {
    private val db = context.openOrCreateDatabase(DB.NAME,  mode, null)

    // object that contains all db constants needed
    object DB {
        const val NAME = "EXCHANGE"
        object TABLE {
            const val CURRENCIES = "currencies"
            const val QUOTES = "quotes"
        }
        const val VERSION = 1 // Update this variable when you want to run onUpgrade again
    }

    init {
        // create both tables if it not exists yet
        db.run {
            execSQL("CREATE TABLE IF NOT EXISTS ${DB.TABLE.CURRENCIES} (coin VARCHAR, description VARCHAR )")
            execSQL("CREATE TABLE IF NOT EXISTS ${DB.TABLE.QUOTES} (usd_coin VARCHAR, quote VARCHAR)") // usd_coin because the quotes comes as USD<COIN>
        }
    }

    /** Save a state of last supported currencies on "currencies" table
     * @param supported currencies returned from API
     */
    fun saveCurrencies(supported: SupportedCurrencies) {
        db.execSQL("DELETE FROM ${DB.TABLE.CURRENCIES}")
        for (currency in supported.currencies.entries) {
            db.execSQL("INSERT INTO ${DB.TABLE.CURRENCIES}(coin, description) VALUES('${currency.key}', '${currency.value}')")
        }
    }

    /**
     * Save state of last quotes on "quotes" table
     * @param realtime rates returned from API
     */
    fun saveQuotes(realtime: RealtimeRates) {
        db.execSQL("DELETE FROM  ${DB.TABLE.QUOTES}")
        for (quote in realtime.quotes.entries) {
            db.execSQL("INSERT INTO ${DB.TABLE.QUOTES}(usd_coin, quote) VALUES('${quote.key}', '${quote.value}')")
        }
    }

    /**
     * Recover state of last supported currencies saved on database
     * @return SupportedCurrencies object containing information needed
     */
    fun getSavedSupportedCurrencies(): SupportedCurrencies {
        val search = "SELECT coin, description FROM ${DB.TABLE.CURRENCIES}"
        val cursor = db.rawQuery(search, null)

        val iCoin = cursor.getColumnIndex("coin")
        val iDescription = cursor.getColumnIndex("description")
        val map = hashMapOf<String, String>()
        while (cursor.moveToNext()) {
            map[cursor.getString(iCoin)] = cursor.getString(iDescription)
        }
        return SupportedCurrencies(true, map)
    }

    /**
     * Recover last quotes saved on database
     * @return RealtimeRates object containing information needed
     */
    fun getSavedRealtimeRates(): RealtimeRates {
        val search = "SELECT usd_coin, quote FROM ${DB.TABLE.QUOTES}"
        val cursor = db.rawQuery(search, null)

        val iUsdCoin = cursor.getColumnIndex("usd_coin")
        val iQuote = cursor.getColumnIndex("quote")
        val map = hashMapOf<String, Double>()
        while (cursor.moveToNext()) {
            map[cursor.getString(iUsdCoin)] = cursor.getDouble(iQuote)
        }
        return RealtimeRates(true, "USD", map)
    }
}