package br.com.tiago.conversormoedas.presentation.conversor

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.lifecycle.Observer
import br.com.tiago.conversormoedas.data.ConversionRepository
import br.com.tiago.conversormoedas.data.ConversionResult
import com.nhaarman.mockitokotlin2.verify
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Mock
import org.mockito.junit.MockitoJUnitRunner
import java.text.DecimalFormat

@RunWith(MockitoJUnitRunner::class)
class CoinsViewModelTest {

    @get:Rule
    val rule = InstantTaskExecutorRule()

    @Mock
    private lateinit var conversionLiveDataOriginObserver: Observer<Float>

    @Mock
    private lateinit var conversionLiveDataDestinyObserver: Observer<Float>

    @Mock
    private lateinit var conversionLiveDataResultObserver: Observer<String>

    private lateinit var viewModel: ConversorViewModel

    @Test
    fun `when view model getRates origin get success then set conversorLiveData`() {

        // Arrange
        val rate = 5.479041F

        val resultSuccess = MockRepository(ConversionResult.Success(rate))
        viewModel = ConversorViewModel(resultSuccess)
        viewModel.conversionLiveDataOrigin.observeForever(conversionLiveDataOriginObserver)

        // Act
        viewModel.getRates(currency = "BRL", flag = 1)

        // Assert
        verify(conversionLiveDataOriginObserver).onChanged(rate)
    }

    @Test
    fun `when view model getRates destiny get success then set conversorLiveData`() {

        // Arrange
        val rate = 70.15845F

        val resultSuccess = MockRepository(ConversionResult.Success(rate))
        viewModel = ConversorViewModel(resultSuccess)
        viewModel.conversionLiveDataDestiny.observeForever(conversionLiveDataDestinyObserver)

        // Act
        viewModel.getRates(currency = "ARS", flag = 2)

        // Assert
        verify(conversionLiveDataDestinyObserver).onChanged(rate)
    }

    @Test
    fun `when view model calculate`() {

        // Arrange
        val rateOrigin = 1F
        val rateDestiny = 1F
        val value = 1F
        val total = 1F
        val result =  DecimalFormat("#.##").format(total)

        val resultSuccess = MockRepository(ConversionResult.ServerError)
        viewModel = ConversorViewModel(resultSuccess)

        viewModel.conversionLiveDataResult.observeForever(conversionLiveDataResultObserver)

        // Act
        viewModel.calculateValue(rateOrigin, rateDestiny, value)

        // Assert
        verify(conversionLiveDataResultObserver).onChanged(result)
    }
}

class MockRepository(private val result: ConversionResult): ConversionRepository {
    override fun getRates(
        currency: String,
        conversionResultsCallback: (result: ConversionResult) -> Unit
    ) {
        conversionResultsCallback(result)
    }
}