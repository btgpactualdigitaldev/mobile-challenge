package com.geocdias.convecurrency

import com.geocdias.convecurrency.data.database.entities.ExchangeRateEntity

object ExchangeRateFakeProvider {
    fun rateList(): List<ExchangeRateEntity> = listOf(
        ExchangeRateEntity(1, quote = "USDAED", rate =  3.672982),
        ExchangeRateEntity(2, quote = "USDAFN", rate =  57.8936),
        ExchangeRateEntity(3, quote = "USDALL", rate =  126.1652),
        ExchangeRateEntity(4, quote = "USDAMD", rate =  475.306),
        ExchangeRateEntity(5, quote = "USDANG", rate =  1.78952),
        ExchangeRateEntity(6, quote = "USDAOA", rate =  109.216875),
        ExchangeRateEntity(7, quote = "USDARS", rate =  8.901966),
        ExchangeRateEntity(8, quote = "USDAUD", rate =  1.269072),
        ExchangeRateEntity(9, quote = "USDAWG", rate =  1.792375),
        ExchangeRateEntity(10, quote = "USDAZN", rate =  1.04945),
        ExchangeRateEntity(11, quote = "USDBAM", rate =  1.757305)
    )

}
