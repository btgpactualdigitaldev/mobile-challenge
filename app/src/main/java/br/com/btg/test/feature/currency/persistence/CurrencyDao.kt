package br.com.btg.test.feature.currency.persistence

import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.Query
import kotlinx.coroutines.flow.Flow


@Dao
interface CurrencyDao {

    @Query("SELECT * FROM CurrencyEntity")
    fun getAll(): Flow<List<CurrencyEntity>>

    @Insert
    fun insertAll(vararg users: CurrencyEntity)

    @Delete
    fun delete(currency: CurrencyEntity)

    @Query("SELECT EXISTS(SELECT * FROM CurrencyEntity WHERE code = :code)")
    fun isRowIsExist(code: String): Boolean
}
