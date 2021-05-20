package br.com.albertomagalhaes.btgcurrencies.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import androidx.room.Update
import br.com.albertomagalhaes.btgcurrencies.dto.CurrencyDTO

@Dao
interface CurrencyDAO {
    @Insert
    suspend fun insert(currency: CurrencyDTO): Long

    @Update
    suspend fun update(currency: CurrencyDTO)

    @Query("DELETE FROM currency")
    suspend fun deleteAll()

    @Query("SELECT * FROM currency")
    suspend fun getAll(): List<CurrencyDTO>

    @Query("SELECT * FROM currency LIMIT :limit")
    suspend fun getFirstN(limit:Int): List<CurrencyDTO>

    @Query("SELECT count(id) FROM currency")
    suspend fun getCount(): Int

    @Query("SELECT * FROM currency WHERE is_selected = :isSelected")
    suspend fun getByIsSelected(isSelected:Boolean = true): List<CurrencyDTO>?

    @Query("UPDATE currency SET is_selected = :isSelected WHERE code = :code")
    suspend fun updateByCodeAndIsSelected(code:String, isSelected : Boolean = true)

    @Query("UPDATE currency SET is_selected = 0")
    suspend fun clearSelection()

    @Query("SELECT count(id) FROM currency WHERE is_selected = 1")
    suspend fun getCurrencySelectedCount(): Int

}