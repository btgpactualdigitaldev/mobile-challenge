package com.btg.teste.entity

import org.junit.Test
import org.junit.Assert

class TestCurrencies {

    @Test
    fun currencies() {
        val currencies =
            Currencies(
                success = true,
                currencies = HashMap(),
                privacy = "privacy",
                terms = "terms"
            )

        Assert.assertNotNull(currencies.currencies)
        Assert.assertTrue(currencies.success)
        Assert.assertEquals(currencies.privacy,"privacy")
        Assert.assertEquals(currencies.terms,"terms")
    }

}