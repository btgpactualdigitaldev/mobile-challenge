package com.vald3nir.data

import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import com.vald3nir.data.database.DatabaseHandler
import com.vald3nir.data.rest.RestClient
import kotlinx.coroutines.runBlocking
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class DatabaseTest {

    @Before
    fun loadDatabase() {
        runBlocking {
            val restClient = RestClient()

            val context = InstrumentationRegistry.getInstrumentation().targetContext
            val database = DatabaseHandler(context)

            database.updateCurrencies(restClient.listCurrencies())
            database.updateExchanges(restClient.listExchanges())
            database.close()
        }
    }

    @Test
    fun testListAll() {
        val context = InstrumentationRegistry.getInstrumentation().targetContext
        val database = DatabaseHandler(context)

        val exchanges = database.listAllExchanges()
        val currencies = database.listAllCurrencies()
        val flags = database.listAllFlag()

        database.close()

        Assert.assertNotNull(exchanges)
        Assert.assertNotEquals(exchanges!!.size, 0)

        Assert.assertNotNull(currencies)
        Assert.assertNotEquals(currencies!!.size, 0)

        Assert.assertNotNull(flags)
        Assert.assertNotEquals(flags!!.size, 0)
    }

}