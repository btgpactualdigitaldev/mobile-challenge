package com.vald3nir.data

import androidx.test.ext.junit.runners.AndroidJUnit4
import com.vald3nir.data.rest.RestClient
import kotlinx.coroutines.runBlocking
import org.junit.Assert
import org.junit.Test
import org.junit.runner.RunWith


@RunWith(AndroidJUnit4::class)
class ClientRestTest {


    @Test
    fun testListAllCurrencies() {
        runBlocking {
            val restClient = RestClient()
            val items = restClient.listCurrencies()
            Assert.assertNotNull(items)
            Assert.assertNotEquals(items.size, 0)
        }
    }

    @Test
    fun testListAllExchanges() {
        runBlocking {
            val restClient = RestClient()
            val items = restClient.listExchanges()
            Assert.assertNotNull(items)
            Assert.assertNotEquals(items.size, 0)
        }
    }

}