package br.com.mobilechallenge.model

import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper

/**
 * Constructor que cria uma instancia de SQLiteHelper
 *
 * @param context
 * @param nomeBanco nome do banco de dados
 * @param versaoBanco versao do banco de dados (se for diferente   para atualizar)
 * @param scriptSQLCreate SQL com o create table..
 * @param scriptSQLDelete SQL com o drop table...
 */
class SQLiteHelper private constructor(private val context: Context,
                                       private val nomeBanco: String,
                                       private val versaoBanco: Int,
                                       private val scriptSQLCreate: Array<String>,
                                       private val scriptSQLDelete: String
) : SQLiteOpenHelper(context, nomeBanco, null, versaoBanco) {

    override fun onCreate(db: SQLiteDatabase) {
        for (element in scriptSQLCreate) {
            db.execSQL(element)
        }
    }

    override fun onUpgrade(db: SQLiteDatabase, i: Int, i1: Int) {
        db.execSQL(scriptSQLDelete)
        onCreate(db)
    }

    override fun onDowngrade(db: SQLiteDatabase,
                             oldVersion: Int,
                             newVersion: Int) {
        super.onDowngrade(db, oldVersion, newVersion)
    }

    /**************************************************************************************
     * Builder (Design Patterns)
     */
    class Builder {
        private var context: Context? = null
        private var nomeBanco: String? = null
        private var versaoBanco: Int = 0
        private var scriptSQLCreate: Array<String>? = null
        private var scriptSQLDelete: String? = null

        fun context(context: Context?): Builder {
            this.context = context
            return this
        }

        fun nomeBanco(nomeBanco: String): Builder {
            this.nomeBanco = nomeBanco
            return this
        }

        fun versaoBanco(versaoBanco: Int): Builder {
            this.versaoBanco = versaoBanco
            return this
        }

        fun scriptSQLCreate(scriptSQLCreate: Array<String>): Builder {
            this.scriptSQLCreate = scriptSQLCreate
            return this
        }

        fun scriptSQLDelete(scriptSQLDelete: String?): Builder {
            this.scriptSQLDelete = scriptSQLDelete
            return this
        }

        fun build(): SQLiteHelper {
            checkNotNull(nomeBanco) { "DataBase name required." }
            checkNotNull(context) { "Context required." }
            return SQLiteHelper(
                context!!,
                nomeBanco!!,
                versaoBanco,
                scriptSQLCreate!!,
                scriptSQLDelete!!
            )
        }
    }

}