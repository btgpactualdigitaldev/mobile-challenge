package com.btg.convertercurrency.data_local.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import java.util.*

@Entity
class SettingsDb (

    @PrimaryKey
    var key: String = "",
    var value: String ="",
    var dateUpdate : String = ""
) {

    companion object {

        fun getUpdated(): SettingsDb {
            return SettingsDb( key = "update_currency_list", value = false.toString())
        }

        fun getFromCurrency(): SettingsDb {
            return SettingsDb( key = "from_currency_save", value = "USD")
        }

        fun getToCurrency(): SettingsDb {
            return SettingsDb( key = "to_currency_save", value = "BRL")
        }
    }
}