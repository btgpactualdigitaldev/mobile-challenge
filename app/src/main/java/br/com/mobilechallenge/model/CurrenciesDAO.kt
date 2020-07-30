package br.com.mobilechallenge.model

import android.content.ContentValues
import android.content.Context
import android.database.Cursor
import android.database.SQLException
import android.database.sqlite.SQLiteDatabase

import br.com.mobilechallenge.model.bean.ListBean

class CurrenciesDAO(context: Context) {
    private val columns = arrayOf("id", "cd_currency", "nm_currency")

    private var dba: SQLiteDatabase = context.openOrCreateDatabase(
        DataBase.instance.name,
        Context.MODE_PRIVATE,
        null
    )

    fun truncate() {
        dba.delete(Tables.TB_CURRENCIES, null, null)
        dba.execSQL("UPDATE SQLITE_SEQUENCE SET seq = 0 WHERE name = '${Tables.TB_CURRENCIES}'")
    }

    fun save(table: ListBean) : Long {
        var values = ContentValues()
            values.put(columns[0], table.id)
            values.put(columns[1], table.code)
            values.put(columns[2], table.description)

        return dba.insert(Tables.TB_CURRENCIES, "", values)
    }

    /*****************************************************************************************
     * Cursor
     *****************************************************************************************/
    private fun getCursor() : Cursor? {
        return try {
            dba.query(
                Tables.TB_CURRENCIES,
                columns,
                null,
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
    fun list() : MutableList<ListBean> {
        var data: Cursor? = getCursor()
        var result: MutableList<ListBean> = emptyList<ListBean>().toMutableList()

        if (data!!.count > 0) {
            data.moveToFirst()
            do {
                val table = ListBean(data.getInt(0),
                                     data.getString(1),
                                     data.getString(2))
                result.add(table)

            } while (data.moveToNext())
        }
        data?.close()

        return result
    }

    fun close() { dba.close() }
}