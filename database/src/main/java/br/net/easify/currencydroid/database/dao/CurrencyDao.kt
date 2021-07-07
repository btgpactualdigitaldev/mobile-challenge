package br.net.easify.currencydroid.database.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import br.net.easify.currencydroid.database.model.Currency

@Dao
interface CurrencyDao {
    @Query("SELECT * FROM currency ORDER BY currencyId")
    fun getAll(): List<Currency>

    @Query("SELECT * FROM currency WHERE currencyId = :currencyId")
    fun getCurrency(currencyId: String): Currency?

    @Query("SELECT * FROM currency WHERE id = :id")
    fun getCurrency(id: Long): Currency?

    @Query("SELECT COUNT(*) FROM currency")
    fun getCount(): Long

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insert(currencyData: List<Currency>)

    @Query("DELETE FROM currency")
    fun deleteAll()
}