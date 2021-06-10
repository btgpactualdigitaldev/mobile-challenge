package clcmo.com.btgcurrency.repository.data.local

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import clcmo.com.btgcurrency.repository.data.local.entity.CEntity

@Dao
interface CDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun saveCurrency(list: List<CEntity>)

    @Query("SELECT * FROM currency")
    fun getCurrencies(): List<CEntity>
}

