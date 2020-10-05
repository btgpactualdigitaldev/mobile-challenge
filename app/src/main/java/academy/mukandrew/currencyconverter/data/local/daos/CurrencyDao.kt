package academy.mukandrew.currencyconverter.data.local.daos

import academy.mukandrew.currencyconverter.data.local.entities.CurrencyEntity
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query

@Dao
interface CurrencyDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun save(list: List<CurrencyEntity>)

    @Query("SELECT * FROM currency")
    suspend fun getAll(): List<CurrencyEntity>
}