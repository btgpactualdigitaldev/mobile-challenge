package br.com.andreldsr.btgcurrencyconverter.data.model

import androidx.room.Entity
import androidx.room.PrimaryKey
import java.time.LocalDate

@Entity(tableName = "currency")
data class CurrencyEntity(
    @PrimaryKey(autoGenerate = true)
    val id: Long?,
    val name: String,
    val initials: String,
    val quote: Float,
    val lastTimeUpdated: Long
) {}