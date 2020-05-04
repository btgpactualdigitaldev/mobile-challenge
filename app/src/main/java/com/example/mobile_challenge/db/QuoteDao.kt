package com.example.mobile_challenge.db

import androidx.room.*
import com.example.mobile_challenge.model.CurrencyEntity
import com.example.mobile_challenge.model.QuoteEntity

@Dao
interface QuoteDao {
  @Query("SELECT * FROM quoteentity")
  fun getAll(): List<QuoteEntity>

  @Query("SELECT * FROM quoteentity WHERE `to` LIKE :code LIMIT 1")
  fun findByCode(code: String): QuoteEntity

  @Insert
  fun insertAll(users: List<QuoteEntity>)

  @Delete
  fun delete(user: QuoteEntity)

  @Insert(onConflict = OnConflictStrategy.IGNORE)
  fun insert(entity: QuoteEntity): Long

  @Update(onConflict = OnConflictStrategy.REPLACE)
  fun update(entity: QuoteEntity)

  @Transaction
  fun upsert(entity: QuoteEntity) {
    val id = insert(entity)
    if (id == -1L) {
      update(entity)
    }
  }
}