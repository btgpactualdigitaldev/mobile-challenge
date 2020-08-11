package com.svm.btgmoneyconverter.data.database

import android.content.ContentValues
import android.content.Context
import android.database.Cursor
import android.database.sqlite.SQLiteDatabase
import com.svm.btgmoneyconverter.model.Quote
import com.svm.btgmoneyconverter.utils.DBOpenHelper

class QuoteDB {

    //SQLite
    private var db: SQLiteDatabase
    private var helper: DBOpenHelper
    private lateinit var cursor: Cursor

    //Variaveis
    private lateinit var quotes: ArrayList<Quote>
    private lateinit var quote: Quote
    private var searchReturn: Array<String>
    private val tbName = "quotes"

    constructor(context: Context){
        this.helper = DBOpenHelper(context)
        this.db = helper.getDatabase()
        this.searchReturn = arrayOf("id", "symbol","value")
    }

    fun insertAll(data: ArrayList<Quote>) {
        data.forEach {
            val cv = ContentValues()
            cv.put("symbol", it.symbol)
            cv.put("value", it.value)
            db.insert(tbName, null, cv)
        }
    }

    fun getAll(): ArrayList<Quote>{
        quotes = arrayListOf()
        cursor = db.query(tbName, searchReturn,
            null, null, null, null, null)
        cursor.moveToFirst()
        while (!cursor.isAfterLast()){
            quote = Quote(
                cursor.getString(1),
                cursor.getDouble(2),
                cursor.getInt(0)
            )
            quotes.add(quote)
            cursor.moveToNext()
        }
        cursor.close()
        return quotes
    }

    fun findById(id: Int): Quote {
        val selection = "id = $id"
        return searchResult(selection)
    }

    fun findBySymbol(symbol: String): Quote {
        val selection = "symbol = '$symbol'"
        return searchResult(selection)
    }

    private fun searchResult(selection: String): Quote {
        cursor = db.query(tbName, searchReturn, selection,
            null, null, null, null)
        cursor.moveToFirst()

        quote = Quote(cursor.getString(1),cursor.getDouble(2),cursor.getInt(0))
        cursor.close()

        return quote
    }

    fun deleteAll(){
        db.execSQL("DELETE FROM $tbName ")
        db.execSQL("DELETE FROM sqlite_sequence WHERE name='$tbName'");
    }

}