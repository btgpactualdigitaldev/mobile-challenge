package com.svm.btgmoneyconverter.data.database

import android.content.ContentValues
import android.content.Context
import android.database.Cursor
import android.database.sqlite.SQLiteDatabase
import com.svm.btgmoneyconverter.model.Currency
import com.svm.btgmoneyconverter.utils.DBOpenHelper


class CurrencyDB {

    //SQLite
    private var db: SQLiteDatabase
    private var helper: DBOpenHelper
    private lateinit var cursor: Cursor

    //Variaveis
    private lateinit var currencies: ArrayList<Currency>
    private lateinit var currency: Currency
    private var searchReturn: Array<String>
    private val tbName = "currencies"

    constructor(context: Context){
        this.helper = DBOpenHelper(context)
        this.db = helper.getDatabase()
        this.searchReturn = arrayOf("id", "symbol","name")
    }

    fun insertAll(data: ArrayList<Currency>) {
        data.forEach {
            val cv = ContentValues()
            cv.put("symbol", it.symbol)
            cv.put("name", it.name)
            db.insert(tbName, null, cv)
        }
    }

    fun getAll(): ArrayList<Currency>{
        currencies = arrayListOf()
        cursor = db.query(tbName, searchReturn,
            null, null, null, null, null)
        cursor.moveToFirst()
        while (!cursor.isAfterLast()){
            currency = Currency(
                cursor.getString(1),
                cursor.getString(2),
                cursor.getInt(0)
            )
            currencies.add(currency)
            cursor.moveToNext()
        }
        cursor.close()
        return currencies
    }

    fun findById(id: Int): Currency{
        val selection = "id = $id"
        return searchResult(selection)
    }

    fun findBySymbol(symbol: String): Currency{
        val selection = "symbol = '$symbol'"
        return searchResult(selection)
    }

    private fun searchResult(selection: String): Currency{
        cursor = db.query(tbName, searchReturn, selection,
            null, null, null, null)
        cursor.moveToFirst()
        currency = Currency(cursor.getString(1),cursor.getString(2),cursor.getInt(0))
        cursor.close()

        return currency
    }

    fun deleteAll(){
        db.execSQL("DELETE FROM $tbName ")
        db.execSQL("DELETE FROM sqlite_sequence WHERE name='$tbName'");
    }

}