package br.com.tiago.conversormoedas.data.respository.database

import android.content.ContentValues
import android.content.Context
import android.database.sqlite.SQLiteConstraintException
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper
import br.com.tiago.conversormoedas.data.model.Coin

class DatabaseHelper(context: Context): SQLiteOpenHelper(context, DATABASE_NAME, null, DATABASE_VERSION) {

    override fun onCreate(db: SQLiteDatabase) {
        db.execSQL(SQL_CREATE_COINS_ENTRIES)
    }

    override fun onUpgrade(db: SQLiteDatabase, p1: Int, p2: Int) {
        db.execSQL(SQL_DELETE_COINS_ENTRIES)
        onCreate(db)
    }

    @Throws(SQLiteConstraintException::class)
    fun insertOrReplaceCoin(coin: Coin): Boolean {
        // Gets the data repository in write mode
        val db = writableDatabase

        // Create a new map of values, where column names are the keys
        val values = ContentValues()
        values.put(DBContract.CoinsEntry.COLUMN_COINS_INITIALS, coin.initials)
        values.put(DBContract.CoinsEntry.COLUMN_COINS_NAME, coin.name)

        // Insert the new row, returning the primary key value of the new row
        return if (coin.id > 0){
            val columnId = DBContract.CoinsEntry.COLUMN_COINS_ID
            val whereClause = "$columnId = ?"
            val idCoin = coin.id.toString()
            val whereArgs = arrayOf(idCoin)

            db.update(DBContract.CoinsEntry.TABLE_NAME, values, whereClause, whereArgs) > 0
        } else {
            db.insert(DBContract.CoinsEntry.TABLE_NAME, null, values) > 0
        }
    }

    @Throws(SQLiteConstraintException::class)
    fun getCoins(): List<Coin>? {

        val table = DBContract.CoinsEntry.TABLE_NAME
        val db = this.readableDatabase
        val selectQuery = "SELECT * FROM $table"
        val coins: MutableList<Coin> = mutableListOf()

        val it = db.rawQuery(selectQuery, null)
        if (it.moveToFirst()) {
            do {
                val coin = Coin (
                    id = it.getLong(it.getColumnIndex(DBContract.CoinsEntry.COLUMN_COINS_ID)),
                    initials = it.getString(it.getColumnIndex(DBContract.CoinsEntry.COLUMN_COINS_INITIALS)),
                    name = it.getString(it.getColumnIndex(DBContract.CoinsEntry.COLUMN_COINS_NAME))
                )

                coins.add(coin)

            } while (it.moveToNext())
        }

        it.close()

        return coins
    }

    companion object {

        var DATABASE_NAME = "coins_database"
        private const val DATABASE_VERSION = 1

        // COINS
        private const val SQL_CREATE_COINS_ENTRIES =
            "CREATE TABLE IF NOT EXISTS " + DBContract.CoinsEntry.TABLE_NAME + " (" +
                    DBContract.CoinsEntry.COLUMN_COINS_ID + " INTEGER PRIMARY KEY AUTOINCREMENT," +
                    DBContract.CoinsEntry.COLUMN_COINS_INITIALS + " VARCHAR(10)," +
                    DBContract.CoinsEntry.COLUMN_COINS_NAME + " VARCHAR(100))"

        private const val SQL_DELETE_COINS_ENTRIES =
            "DROP TABLE IF EXISTS " + DBContract.CoinsEntry.TABLE_NAME
        // COINS
    }
}