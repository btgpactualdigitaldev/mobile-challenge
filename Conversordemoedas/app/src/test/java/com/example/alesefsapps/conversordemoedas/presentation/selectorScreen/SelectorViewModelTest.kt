package com.example.alesefsapps.conversordemoedas.presentation.selectorScreen

import android.arch.core.executor.testing.InstantTaskExecutorRule
import android.arch.lifecycle.Observer
import com.example.alesefsapps.conversordemoedas.R
import com.example.alesefsapps.conversordemoedas.data.model.Currency
import com.example.alesefsapps.conversordemoedas.data.model.Quote
import com.example.alesefsapps.conversordemoedas.data.model.Values
import com.example.alesefsapps.conversordemoedas.data.repository.CurrencyRepository
import com.example.alesefsapps.conversordemoedas.data.repository.ValueLiveRepository
import com.example.alesefsapps.conversordemoedas.data.result.CurrencyResult
import com.example.alesefsapps.conversordemoedas.data.result.LiveValueResult
import com.nhaarman.mockitokotlin2.verify
import org.hamcrest.core.Is.`is`
import org.junit.Assert.*
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import org.mockito.junit.MockitoJUnitRunner
import java.math.BigDecimal

//@RunWith(MockitoJUnitRunner::class)
class SelectorViewModelTest {

    @get:Rule
    val rule = InstantTaskExecutorRule()

    private lateinit var viewModel: SelectorViewModel

    @Mock
    private lateinit var selectorLiveDataObserver: Observer<List<Values>>

    @Mock
    private lateinit var viewFlipperLiveDataObserver: Observer<Pair<Int, Int?>>


    @Before
    fun setup() {
        MockitoAnnotations.initMocks(this)
    }

    @Test
    fun `when view model getValueLive get success`() {
        val quotes = listOf(
            Quote("AAABBB", BigDecimal.valueOf(1))
        )
        val currencies = listOf(
            Currency("AAA", "name AAA")
        )

        val resultValueLiveSuccess = MockValueLiveRepository(LiveValueResult.Success(quotes))
        val resultCurrencySuccess = MockCurrencyRepository(CurrencyResult.Success(currencies))
        viewModel = SelectorViewModel(resultValueLiveSuccess, resultCurrencySuccess)

        viewModel.getValueLive()

        assertThat(quotes, `is`(viewModel.quotes))
    }

    @Test
    fun `when view model getValueLive get error 401`() {
        val currencies = listOf(
            Currency("AAA", "name AAA")
        )
        val resultValueLiveSuccess = MockValueLiveRepository(LiveValueResult.ApiError(401))
        val resultCurrencySuccess = MockCurrencyRepository(CurrencyResult.Success(currencies))
        viewModel = SelectorViewModel(resultValueLiveSuccess, resultCurrencySuccess)
        viewModel.viewFlipperLiveData.observeForever(viewFlipperLiveDataObserver)

        viewModel.getValueLive()

        verify(viewFlipperLiveDataObserver).onChanged(Pair(2, R.string.error_401_live))
    }

    @Test
    fun `when view model getValueLive get error 404`() {
        val currencies = listOf(
            Currency("AAA", "name AAA")
        )
        val resultValueLiveSuccess = MockValueLiveRepository(LiveValueResult.ApiError(404))
        val resultCurrencySuccess = MockCurrencyRepository(CurrencyResult.Success(currencies))
        viewModel = SelectorViewModel(resultValueLiveSuccess, resultCurrencySuccess)
        viewModel.viewFlipperLiveData.observeForever(viewFlipperLiveDataObserver)

        viewModel.getValueLive()

        verify(viewFlipperLiveDataObserver).onChanged(Pair(2, R.string.error_generico_live))
    }


    @Test
    fun `when view model getValueLive get server error`() {
        val currencies = listOf(
            Currency("AAA", "name AAA")
        )
        val resultValueLiveSuccess = MockValueLiveRepository(LiveValueResult.SeverError())
        val resultCurrencySuccess = MockCurrencyRepository(CurrencyResult.Success(currencies))
        viewModel = SelectorViewModel(resultValueLiveSuccess, resultCurrencySuccess)
        viewModel.viewFlipperLiveData.observeForever(viewFlipperLiveDataObserver)

        viewModel.getValueLive()

        verify(viewFlipperLiveDataObserver).onChanged(Pair(2, R.string.error_server_live))
    }






    @Test
    fun `when view model getCurrency get success`() {
        val quotes = listOf(
            Quote("AAABBB", BigDecimal.valueOf(1))
        )
        val currencies = listOf(
            Currency("AAA", "name AAA")
        )
        val resultValueLiveSuccess = MockValueLiveRepository(LiveValueResult.Success(quotes))
        val resultCurrencySuccess = MockCurrencyRepository(CurrencyResult.Success(currencies))
        viewModel = SelectorViewModel(resultValueLiveSuccess, resultCurrencySuccess)

        viewModel.getCurrency(quotes)

        assertThat(quotes, `is`(viewModel.quotes))
        assertThat(currencies, `is`(viewModel.currencies))
    }


    @Test
    fun `when view model getValues get success`() {
        val quotes = listOf(
            Quote("AAABBB", BigDecimal.valueOf(1))
        )
        val currencies = listOf(
            Currency("AAA", "name AAA")
        )
        val values = listOf(
            Values("AAA", "name AAA", BigDecimal.valueOf(1)),
            Values("AAA", "name AAA", BigDecimal.valueOf(1))
        )

        val resultValueLiveSuccess = MockValueLiveRepository(LiveValueResult.Success(quotes))
        val resultCurrencySuccess = MockCurrencyRepository(CurrencyResult.Success(currencies))
        viewModel = SelectorViewModel(resultValueLiveSuccess, resultCurrencySuccess)

        viewModel.selectorLiveData.observeForever(selectorLiveDataObserver)
        viewModel.viewFlipperLiveData.observeForever(viewFlipperLiveDataObserver)

        viewModel.getValues(quotes, currencies)

//        verify(selectorLiveDataObserver).onChanged(values)
        verify(viewFlipperLiveDataObserver).onChanged(Pair(1, null))
    }
}


class MockValueLiveRepository(private val liveValueResult: LiveValueResult) : ValueLiveRepository {
    override fun getValueLive(valueResultCallback: (result: LiveValueResult) -> Unit) {
        valueResultCallback(liveValueResult)
    }
}
class MockCurrencyRepository(private val currencyResult: CurrencyResult) : CurrencyRepository {
    override fun getCurrency(currenciesResultCallback: (result: CurrencyResult) -> Unit) {
        currenciesResultCallback(currencyResult)
    }
}