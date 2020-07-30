package br.com.mobilechallenge.model

import android.content.ContentValues
import android.content.Context
import android.database.Cursor
import android.database.SQLException
import android.database.sqlite.SQLiteDatabase

import br.com.mobilechallenge.model.bean.ListBean
import br.com.mobilechallenge.model.bean.LiveBean

class PriceDAO(context: Context) {
    private val columns = arrayOf("id", "id_currencies", "cd_price", "vl_price")

    private var dba: SQLiteDatabase = context.openOrCreateDatabase(
        DataBase.instance.name,
        Context.MODE_PRIVATE,
        null
    )

    fun save(table: LiveBean) {
        val row: Int = update(table)

        if (row == 0) { insert(table) }
    }

    private fun update(table: LiveBean) : Int {
        var values = ContentValues()
            values.put(columns[1], table.idCurrencies)
            values.put(columns[2], table.code)
            values.put(columns[3], table.price)

        var where = "(${columns[1]} = ${table.idCurrencies})"

        return dba.update(Tables.TB_PRICE, values, where, null)
    }

    private fun insert(table: LiveBean) : Long {
        var values = ContentValues()
            values.put(columns[1], table.idCurrencies)
            values.put(columns[2], table.code)
            values.put(columns[3], table.price)

        return dba.insert(Tables.TB_PRICE, "", values)
    }

    fun truncate() {
        dba.delete(Tables.TB_PRICE, null, null)
        dba.execSQL("UPDATE SQLITE_SEQUENCE SET seq = 0 WHERE name = '${Tables.TB_PRICE}'")
    }

    /*****************************************************************************************
     * Cursor
     *****************************************************************************************/
    private fun getCursor(idCurrencies: Int?) : Cursor? {
        var where = "(${columns[1]} = $idCurrencies)"

        return try {
            dba.query(
                Tables.TB_PRICE,
                columns,
                where,
                null,
                null,
                null,
                null)
        }
        catch (e: SQLException) { null }
    }

    /*****************************************************************************************
     * Listagem
     *****************************************************************************************/
    fun get(idCurrencies: Int?) : LiveBean? {
        var data: Cursor? = getCursor(idCurrencies)
        var result: LiveBean? = null

        if (data!!.count > 0) {
            data.moveToFirst()
            do {
                result = LiveBean(data.getInt(0),
                                  data.getInt(1),
                                  data.getString(2),
                                  data.getDouble(3))
            } while (data.moveToNext())
        }
        data.close()

        return result
    }

    fun close() { dba.close() }
}