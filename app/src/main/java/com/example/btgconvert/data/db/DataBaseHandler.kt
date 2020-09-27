package com.example.btgconvert.data.db

import android.content.ContentValues
import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper
import com.example.btgconvert.data.model.Currency

val DB_NAME = "Convert"
val TB_NAME = "Currencies"
val COL_KEY = "currencyKey"
val COL_TITLE = "currencyTitle"
val COL_QUOTE = "currencyQuote"

class DataBaseHandler(context: Context): SQLiteOpenHelper(context, DB_NAME,null,1){
    override fun onCreate(db: SQLiteDatabase?) {
        val createTable = "CREATE TABLE " + TB_NAME + " (" +
                COL_KEY +" TEXT PRIMARY KEY,"+
                COL_TITLE+" TEXT,"+
                COL_QUOTE+" REAL)"

        db?.execSQL(createTable)
    }

    override fun onUpgrade(db: SQLiteDatabase?, oldVersion: Int, newVersion: Int) {

    }

    fun insertData(currencies:List<Currency>): Boolean{
        val db = this.writableDatabase
        val cv = ContentValues()
        for(currency in currencies){
            cv.put(COL_KEY, currency.currencyKey)
            cv.put(COL_TITLE, currency.currencyTitle)
            cv.put(COL_QUOTE, currency.currencyQuote)
            db.insert(TB_NAME, null, cv)
        }
        return true
    }

    fun getData() : MutableList<Currency>{
        val list : MutableList<Currency> = ArrayList()
        val db = this.readableDatabase
        val query = "Select * from " + TB_NAME
        val result = db.rawQuery(query, null)
        if(result.moveToFirst()){
            do{
                val currency = Currency(result.getString(result.getColumnIndex(COL_KEY)), result.getString(result.getColumnIndex(COL_TITLE)), result.getDouble(result.getColumnIndex(COL_QUOTE)))
                list.add(currency)
            }while(result.moveToNext())
        }

        result.close()
        db.close()
        return list
    }

    fun getDataOnFilter(filter:String) : MutableList<Currency>{
        val list : MutableList<Currency> = ArrayList()
        val db = this.readableDatabase
        val query = "SELECT * FROM "+ TB_NAME+" WHERE "+ COL_KEY+" LIKE '%"+ filter+"%' OR "+ COL_TITLE+" LIKE '%"+ filter+"%'"
        val result = db.rawQuery(query, null)
        if(result.moveToFirst()){
            do{
                val currency = Currency(result.getString(result.getColumnIndex(COL_KEY)), result.getString(result.getColumnIndex(COL_TITLE)), result.getDouble(result.getColumnIndex(COL_QUOTE)))
                list.add(currency)
            }while(result.moveToNext())
        }

        result.close()
        db.close()
        return list
    }

    fun getCurrency(key: String) : Currency{
        val currency : Currency
        val db = this.readableDatabase
        val query = "SELECT * FROM "+ TB_NAME+" WHERE "+ COL_KEY+" = '"+ key+"'"
        val result = db.rawQuery(query, null)
        result.moveToFirst()
        currency = Currency(result.getString(result.getColumnIndex(COL_KEY)), result.getString(result.getColumnIndex(COL_TITLE)), result.getDouble(result.getColumnIndex(COL_QUOTE)))

        result.close()
        db.close()
        return currency
    }

    fun deleteData(){
        val db = this.writableDatabase
        db.execSQL("DELETE FROM "+ TB_NAME)
    }

}

