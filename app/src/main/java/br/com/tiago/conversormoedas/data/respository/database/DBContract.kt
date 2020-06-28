package br.com.tiago.conversormoedas.data.respository.database

import android.provider.BaseColumns

object DBContract {

    class CoinsEntry : BaseColumns {
        companion object {
            const val TABLE_NAME = "coins"
            const val COLUMN_COINS_ID = "id"
            const val COLUMN_COINS_INITIALS = "initials"
            const val COLUMN_COINS_NAME = "name"
        }
    }
}