package academy.mukandrew.currencyconverter.data.local.daos

import academy.mukandrew.currencyconverter.data.local.entities.CurrencyQuoteEntity
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query

@Dao
interface CurrencyQuoteDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun save(list: List<CurrencyQuoteEntity>)

    @Query("SELECT * FROM currency_quote")
    suspend fun getAll(): List<CurrencyQuoteEntity>
}