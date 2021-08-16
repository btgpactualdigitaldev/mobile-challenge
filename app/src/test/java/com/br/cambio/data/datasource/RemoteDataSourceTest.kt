package com.br.cambio.data.datasource

import com.br.cambio.data.api.Api
import com.br.cambio.data.model.Exchange
import com.br.cambio.domain.model.CurrencyDomain
import com.nhaarman.mockito_kotlin.mock
import com.nhaarman.mockito_kotlin.whenever
import junit.framework.Assert.assertEquals
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.TestCoroutineDispatcher
import kotlinx.coroutines.test.resetMain
import kotlinx.coroutines.test.runBlockingTest
import org.junit.After
import org.junit.Test
import retrofit2.Response

@ExperimentalCoroutinesApi
class RemoteDataSourceTest {

    private val testDispatcher = TestCoroutineDispatcher()

    private val service: Api = mock()
    private val dataSource: RemoteDataSource = RemoteDataSourceImpl(service)

    @After
    fun tearDown() {
        Dispatchers.resetMain()
        testDispatcher.cleanupTestCoroutines()
    }

    @Test
    fun `list currency should return the list from remote data source`() = runBlockingTest {
        // Given
        whenever(service.getCurrency()).thenReturn(mockResponse())

        // When
        val result = dataSource.getCurrencies()

        // Then
        assertEquals(result, expectedResponse())
        assertEquals(result?.get(0)?.key, "BRL")
    }

    private fun setCurrency(): HashMap<String, String> {
        val currency = HashMap<String, String>()
        currency["BRL"] = "Brazilian Real"

        return currency
    }

    private fun setPrice(): HashMap<String, Double> {

        return HashMap<String, Double>()
    }

    private fun mockResponse() = Response.success(
                Exchange(
                    currencies = setCurrency(),
                    quotes = setPrice(),
                    success = true,
                    source = "USD"
                )
            )

    private fun expectedResponse() =
        listOf(
            CurrencyDomain(
                key = "BRL",
                value = "Brazilian Real"
            )
        )
}