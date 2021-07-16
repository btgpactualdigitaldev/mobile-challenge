package br.com.conversordemoedas.model

import android.os.Build
import br.com.conversordemoedas.utils.Network
import retrofit2.Callback
import java.time.Instant
import java.time.format.DateTimeFormatter

class LiveManager(private val network: Network) {

    fun getCurrencyLive(currenciesCodes: String, callback: Callback<Live>) {
        val currencyLayer = network.currencyLayerService()
        val call =  currencyLayer.getCurrencyLive(currenciesCodes)

        call.enqueue(callback)
    }

    fun getDateTime(timestamp: String): String? {

        var update = ""

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val dateConvertedSplit = DateTimeFormatter.ISO_INSTANT.format(Instant.ofEpochSecond(timestamp.toLong())).split("T")
            val daySplit = dateConvertedSplit[0].split("-")
            val hourSplit = dateConvertedSplit[1].split(":")
            val day = daySplit[2] + "/" + daySplit[1] + "/" + daySplit[0]
            val hour = hourSplit[0] + ":" + hourSplit[1] + ":" + hourSplit[2].substring(0, 2)
            update = "Atualizado: $day $hour"
        }

        return update
    }

}