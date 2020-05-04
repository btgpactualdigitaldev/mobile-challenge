package com.example.mobile_challenge.db

import androidx.room.*
import com.example.mobile_challenge.model.CurrencyEntity

@Dao
interface CurrencyDao {
  @Query("SELECT * FROM currencyentity")
  fun getAll(): List<CurrencyEntity>

  @Query("SELECT * FROM currencyentity WHERE currencyCode LIKE :code LIMIT 1")
  fun findByCode(code: String): CurrencyEntity

  @Insert
  fun insertAll(users: List<CurrencyEntity>)

  @Delete
  fun delete(user: CurrencyEntity)

  @Insert(onConflict = OnConflictStrategy.IGNORE)
  fun insert(entity: CurrencyEntity): Long

  @Update(onConflict = OnConflictStrategy.REPLACE)
  fun update(entity: CurrencyEntity)

  @Transaction
  fun upsert(entity: CurrencyEntity) {
    val id = insert(entity)
    if (id == -1L) {
      update(entity)
    }
  }
}