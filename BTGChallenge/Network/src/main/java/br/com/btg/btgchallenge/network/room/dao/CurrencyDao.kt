package br.com.btg.btgchallenge.network.room.dao
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import br.com.btg.btgchallenge.network.model.currency.Currencies
import br.com.btg.btgchallenge.network.model.currency.Quotes

@Dao
interface CurrencyDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertCurrencies(currencies: Currencies)

    @Query("DELETE FROM currencies_table")
    suspend fun deleteCurrencies()

    @Query("SELECT * from currencies_table ORDER BY id DESC LIMIT 1")
    suspend fun getCurrencies(): Currencies?



    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertQuotes(quotes: Quotes)

    @Query("DELETE FROM quotes_table")
    suspend fun deleteQuotes()

    @Query("SELECT * from quotes_table ORDER BY id DESC LIMIT 1")
    suspend fun getQuotes(): Quotes
}