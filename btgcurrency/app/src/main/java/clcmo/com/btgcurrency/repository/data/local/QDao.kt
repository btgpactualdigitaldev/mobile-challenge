package clcmo.com.btgcurrency.repository.data.local

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import clcmo.com.btgcurrency.repository.data.local.entity.QEntity

@Dao
interface QDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun saveQuote(list: List<QEntity>)

    @Query("SELECT * FROM currency_quote")
    fun getQuotes(): List<QEntity>
}