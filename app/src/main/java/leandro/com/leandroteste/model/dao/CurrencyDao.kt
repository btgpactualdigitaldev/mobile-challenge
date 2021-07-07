package leandro.com.leandroteste.model.dao

import androidx.room.*
import leandro.com.leandroteste.model.data.Currency

@Dao
interface CurrencyDao {
    @Query("SELECT * FROM currency")
    fun getAll(): List<Currency>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertAll(vararg currencies: Currency)

    @Delete
    fun delete(currency: Currency)
}