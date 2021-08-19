package br.dev.infra.btgconversiontool.room

import androidx.room.Database
import androidx.room.RoomDatabase
import br.dev.infra.btgconversiontool.data.CurrencyTable
import br.dev.infra.btgconversiontool.data.CurrencyView
import br.dev.infra.btgconversiontool.data.QuotesTable
import br.dev.infra.btgconversiontool.data.TimestampTable

@Database(
    entities = [CurrencyTable::class, QuotesTable::class, TimestampTable::class],
    views = [CurrencyView::class],
    version = 1,
    exportSchema = false
)

abstract class CurrencyDatabase : RoomDatabase() {

    abstract fun currencyDatabaseDao(): CurrencyDatabaseDao

}