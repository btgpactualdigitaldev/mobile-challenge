package com.br.btgteste.domain.helper

import com.br.btgteste.domain.model.Currency
import com.br.btgteste.domain.model.Quote
import org.junit.Test
import com.br.btgteste.test
import com.nhaarman.mockitokotlin2.any
import org.junit.Assert.assertEquals

class QuotesHelperTest  {

    @Test
    fun convertQuote_WhenConvertIsCall_ShouldReturnCorrectValue() = test {
        var result = 0.0
        var amount =  0.0
        var currencyFrom: Currency = any()
        var currencyTo: Currency = any()
        var list: List<Quote> = any()
        arrange {
             amount =  100.0
             currencyFrom = Currency("BRZ", "BRAZIL")
             currencyTo = Currency("Zeny", "Ragnarok")
             list = listOf(Quote("USDBRZ", 10.0), Quote("USDZeny", 1.23))
        }
        act {
            result = QuotesHelper.convert(amount, currencyFrom, currencyTo, list)
        }
        assert {
            assertEquals(result, 12.30, 0.0)
        }
    }
}
