package br.dev.infra.btgconversiontool.room


import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import br.dev.infra.btgconversiontool.data.CurrencyTable
import br.dev.infra.btgconversiontool.data.CurrencyView
import br.dev.infra.btgconversiontool.data.QuotesTable
import br.dev.infra.btgconversiontool.data.TimestampTable

@Dao
interface CurrencyDatabaseDao {

    //Insert
    @Insert
    suspend fun insertCurrency(vararg: CurrencyTable)

    @Insert
    suspend fun insertQuotes(vararg: QuotesTable)

    @Insert
    suspend fun insertTimestamp(vararg: TimestampTable)


    //Query
    @Query("select * from currency_table")
    suspend fun getAllCurrency(): List<CurrencyTable>?

    @Query("select * from quotes_table")
    suspend fun getAllQuote(): QuotesTable

    @Query("select quote from quotes_table where id = :id_value")
    suspend fun getQuote(vararg id_value: String): Float

    @Query("select * from timestamp_table")
    suspend fun getTimestamp(): String

    @Query("select * from currencyview")
    suspend fun getCurrencyQuotes(): List<CurrencyView>


    //Delete
    @Query("delete from currency_table")
    suspend fun clearCurrency()

    @Query("delete from quotes_table")
    suspend fun clearQuotes()

    @Query("delete from timestamp_table")
    suspend fun clearTimestamp()
}