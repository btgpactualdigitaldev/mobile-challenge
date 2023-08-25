package br.com.btg.mobile.challenge.viewModel

import br.com.btg.mobile.challenge.base.BaseViewModelTest
import br.com.btg.mobile.challenge.data.PRICES
import br.com.btg.mobile.challenge.data.RATES
import br.com.btg.mobile.challenge.data.repository.PriceRepository
import br.com.btg.mobile.challenge.data.repository.RateRepository
import br.com.btg.mobile.challenge.helper.ExceptionTestData.HTTP_EXCEPTION_ERROR_500_DATA
import br.com.btg.mobile.challenge.helper.test
import br.com.btg.mobile.challenge.ui.HomeViewModel
import io.mockk.coEvery
import io.mockk.mockk
import io.mockk.spyk
import io.mockk.verify
import org.junit.Assert
import org.junit.Before
import org.junit.Test

internal class HomeViewModelTest : BaseViewModelTest() {

    private lateinit var viewModel: HomeViewModel
    private val rateRepository: RateRepository = mockk(relaxUnitFun = true)
    private val priceRepository: PriceRepository = mockk(relaxUnitFun = true)

    @Before
    fun setUp() {
        viewModel = spyk(HomeViewModel(rateRepository, priceRepository))
    }

    @Test
    fun whenGetPrices_givenReturnPrices_thenSuccess() {
        // Arrange
        val observable = viewModel.dataPricesSuccess.test()
        coEvery { priceRepository.getPrices() } returns PRICES

        // Act
        viewModel.getPrices()

        // Assert
        verify { observable.onChanged(PRICES) }
    }

    @Test
    fun whenGetPrices_givenReturnPrices_thenHttpError500() {
        // Arrange
        val observableError = viewModel.error.test()
        coEvery { priceRepository.getPrices() } throws HTTP_EXCEPTION_ERROR_500_DATA

        // Act
        viewModel.getPrices()

        // Assert
        verify { observableError.onChanged(HTTP_EXCEPTION_ERROR_500_DATA) }
    }

    @Test
    fun whenGetRates_givenReturnRates_thenSuccess() {
        // Arrange
        val observable = viewModel.dataRatesSuccess.test()
        coEvery { rateRepository.getRates() } returns RATES

        // Act
        viewModel.getRates()

        // Assert
        verify { observable.onChanged(RATES) }
    }

    @Test
    fun whenGetRates_givenReturnRates_thenHttpError500() {
        // Arrange
        val observableError = viewModel.error.test()
        coEvery { rateRepository.getRates() } throws HTTP_EXCEPTION_ERROR_500_DATA

        // Act
        viewModel.getRates()

        // Assert
        verify { observableError.onChanged(HTTP_EXCEPTION_ERROR_500_DATA) }
    }

    @Test
    fun whenGetConvert_givenReturnValue_thenConvertValue() {
        // Act
        val result = viewModel.convertValue(1.0, 0.400)
        // Assert
        Assert.assertEquals("2.5", result)

        // Act
        val resultZero = viewModel.convertValue(0.0, 0.400)
        // Assert
        Assert.assertEquals("0.0", resultZero)
    }
}
