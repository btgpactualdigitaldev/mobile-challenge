package br.com.mobilechallenge.model

import android.content.Context

class DataBase {
    private val DATABASE_VERSION = 1
    private val SCRIPT_DATABASE_CREATE = arrayOf(
        Tables.SCRIPT_TB_CUR,
        Tables.SCRIPT_TB_PRI
    )
    private val SCRIPT_DATABASE_DELETE =
        "DROP TABLE IF EXISTS " + Tables.TB_CURRENCIES + "; " +
        "DROP TABLE IF EXISTS " + Tables.TB_PRICE + "; "

    companion object {
        val instance: DataBase
            get() = DataBase()
    }

    fun create(context: Context) {
        val dbHelper = SQLiteHelper.Builder()
            .context(context)
            .nomeBanco(name)
            .versaoBanco(DATABASE_VERSION)
            .scriptSQLCreate(SCRIPT_DATABASE_CREATE)
            .scriptSQLDelete(SCRIPT_DATABASE_DELETE)
            .build()
        dbHelper.writableDatabase
        dbHelper.close()
    }

    val name: String
        get() = "challenge"
}