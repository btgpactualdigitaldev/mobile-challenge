package com.btg.teste.entity

import org.junit.Test
import org.junit.Assert

class TestCurrencyLayer {

    @Test
    fun currencyLayer() {
        val currencies =
            CurrencyLayer(
                success = true,
                quotes = HashMap(),
                privacy = "privacy",
                terms = "terms",
                source = "USD",
                timestamp = 1000
            )

        Assert.assertNotNull(currencies.quotes)
        Assert.assertTrue(currencies.success)
        Assert.assertEquals(currencies.privacy, "privacy")
        Assert.assertEquals(currencies.terms, "terms")
        Assert.assertEquals(currencies.source, "USD")
        Assert.assertEquals(currencies.timestamp, 1000)
    }

}