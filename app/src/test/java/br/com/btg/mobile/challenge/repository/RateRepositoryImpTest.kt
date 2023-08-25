package br.com.btg.mobile.challenge.repository

import br.com.btg.mobile.challenge.base.BaseRepositoryTest
import br.com.btg.mobile.challenge.data.RATES
import br.com.btg.mobile.challenge.data.model.Response
import br.com.btg.mobile.challenge.data.remote.MobileChallengeApi
import br.com.btg.mobile.challenge.data.repository.RateRepositoryImp
import io.mockk.coEvery
import io.mockk.mockk
import kotlinx.coroutines.runBlocking
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4

@RunWith(JUnit4::class)
internal class RateRepositoryImpTest : BaseRepositoryTest() {

    private val api: MobileChallengeApi = mockk(relaxUnitFun = true)
    private lateinit var rateRepository: RateRepositoryImp

    @Before
    fun setUp() {
        rateRepository = RateRepositoryImp(api)
    }

    @Test
    fun givenSuccessResponseEmpty_whenFetchRates_thenReturnRatesEmpty() = runBlocking {
        coEvery { api.getRates() } returns Response(
            code = 200,
            message = "success",
            data = emptyList()
        )

        val result = rateRepository.getRates()

        Assert.assertEquals(true, result!!.isEmpty())
        Assert.assertEquals(0, result.size)
    }

    @Test
    fun givenSuccessResponse_whenFetchRates_thenReturnRatesDetail() = runBlocking {
        coEvery { api.getRates() } returns Response(
            code = 200,
            message = "success",
            data = RATES
        )

        val result = rateRepository.getRates()

        Assert.assertEquals(true, result!!.isNotEmpty())
        Assert.assertEquals(3, result.size)
        Assert.assertEquals(4.8816, result[0].exchangeRate)
        Assert.assertEquals("BRL", result[0].coin)
    }

    @Test
    fun givenErrorResponse_whenFetchRates_thenReturnError() = runBlocking {
        coEvery { api.getRates() } returns Response(
            code = 500,
            message = "error",
            data = null
        )

        val result = rateRepository.getRates()

        Assert.assertEquals(true, result.isNullOrEmpty())
    }
}
