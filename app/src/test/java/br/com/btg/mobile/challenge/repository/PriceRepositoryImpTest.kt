package br.com.btg.mobile.challenge.repository

import br.com.btg.mobile.challenge.base.BaseRepositoryTest
import br.com.btg.mobile.challenge.data.PRICES
import br.com.btg.mobile.challenge.data.model.Response
import br.com.btg.mobile.challenge.data.remote.MobileChallengeApi
import br.com.btg.mobile.challenge.data.repository.PriceRepositoryImp
import io.mockk.coEvery
import io.mockk.mockk
import kotlinx.coroutines.runBlocking
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4

@RunWith(JUnit4::class)
internal class PriceRepositoryImpTest : BaseRepositoryTest() {

    private val api: MobileChallengeApi = mockk(relaxUnitFun = true)
    private lateinit var priceRepository: PriceRepositoryImp

    @Before
    fun setUp() {
        priceRepository = PriceRepositoryImp(api)
    }

    @Test
    fun givenSuccessResponseEmpty_whenFetchPrices_thenReturnPricesEmpty() = runBlocking {
        coEvery { api.getPrices() } returns Response(
            code = 200,
            message = "success",
            data = emptyList()
        )

        val result = priceRepository.getPrices()

        Assert.assertEquals(true, result!!.isEmpty())
        Assert.assertEquals(0, result.size)
    }

    @Test
    fun givenSuccessResponse_whenFetchPrices_thenReturnPricesDetail() = runBlocking {
        coEvery { api.getPrices() } returns Response(
            code = 200,
            message = "success",
            data = PRICES
        )

        val result = priceRepository.getPrices()

        Assert.assertEquals(true, result!!.isNotEmpty())
        Assert.assertEquals(3, result.size)
        Assert.assertEquals(1.0, result[0].price)
        Assert.assertEquals("USD", result[0].coin)
    }

    @Test
    fun givenErrorResponse_whenFetchPrices_thenReturnError() = runBlocking {
        coEvery { api.getPrices() } returns Response(
            code = 500,
            message = "error",
            data = null
        )

        val result = priceRepository.getPrices()

        Assert.assertEquals(true, result.isNullOrEmpty())
    }
}
