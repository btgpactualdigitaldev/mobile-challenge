package com.example.mobile_challenge.model

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity
data class CurrencyEntity(
  @PrimaryKey
  val _id : Int ,
  val currencyCode: String,
  val currencyName: String
) {
  override fun equals(other: Any?): Boolean {
    other as CurrencyEntity

    if (currencyCode != other.currencyCode) {
      return false
    }
    if (currencyName != other.currencyName) {
      return false
    }
    return true
  }

  override fun hashCode(): Int {
    var result = currencyCode.hashCode()
    result = 31 * result + currencyName.hashCode()
    return result
  }
}