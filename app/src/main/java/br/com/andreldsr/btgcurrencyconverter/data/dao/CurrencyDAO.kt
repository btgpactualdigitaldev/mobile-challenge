package br.com.andreldsr.btgcurrencyconverter.data.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Query
import br.com.andreldsr.btgcurrencyconverter.data.model.CurrencyEntity
import br.com.andreldsr.btgcurrencyconverter.domain.entities.Currency

@Dao
interface CurrencyDAO {
    @Insert
    suspend fun save(currency: CurrencyEntity): Long

    @Query("SELECT  * FROM currency")
    suspend fun getAll(): List<CurrencyEntity>

    @Query("DELETE FROM currency")
    suspend fun deleteAll()

    @Query("SELECT quote FROM currency WHERE initials = :initials")
    suspend fun getQuote(initials: String): Float
}