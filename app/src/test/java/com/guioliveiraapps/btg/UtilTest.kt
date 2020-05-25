package com.guioliveiraapps.btg

import com.guioliveiraapps.btg.room.Currency
import com.guioliveiraapps.btg.room.Quote
import com.guioliveiraapps.btg.util.Util
import org.hamcrest.CoreMatchers.`is`
import org.hamcrest.MatcherAssert.assertThat
import org.junit.Test

class UtilTest {

    @Test
    fun getCurrenciesFromResponse_manyElements_returnsListOfCurrency() {
        val currencies: Map<String, String> =
            mapOf(Pair("AED", "United Arab Emirates Dirham"), Pair("AFN", "Afghan Afghani"))

        val result: List<Currency> = Util.getCurrenciesFromResponse(currencies)

        val c1 = Currency(
            0,
            "AED",
            "United Arab Emirates Dirham"
        )
        val c2 =
            Currency(0, "AFN", "Afghan Afghani")

        assertThat(result, `is`(listOf(c1, c2)))
    }

    @Test
    fun getQuotesFromResponse_manyElements_returnsListOfCurrency() {
        val quotes: Map<String, Double> =
            mapOf(Pair("AED", 1.0), Pair("AFN", 2.0))

        val result: List<Quote> = Util.getQuotesFromResponse(quotes)

        val q1 = Quote(0, "AED", 1.0)
        val q2 = Quote(0, "AFN", 2.0)

        assertThat(result, `is`(listOf(q1, q2)))
    }


}