package br.com.leonamalmeida.mobilechallenge.ui.main

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.lifecycle.MutableLiveData
import br.com.leonamalmeida.mobilechallenge.R
import br.com.leonamalmeida.mobilechallenge.RxImmediateSchedulerRule
import br.com.leonamalmeida.mobilechallenge.data.Result
import br.com.leonamalmeida.mobilechallenge.data.repositories.RateRepository
import br.com.leonamalmeida.mobilechallenge.getOrAwaitValue
import br.com.leonamalmeida.mobilechallenge.observeForTesting
import br.com.leonamalmeida.mobilechallenge.util.CURRENCY_DESTINY_REQUEST
import br.com.leonamalmeida.mobilechallenge.util.CURRENCY_ORIGIN_REQUEST
import com.google.common.truth.Truth
import com.nhaarman.mockito_kotlin.whenever
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import org.mockito.Mock
import org.mockito.MockitoAnnotations

/**
 * Created by Leo Almeida on 30/06/20.
 */
@RunWith(JUnit4::class)
class MainViewModelTest {

    @get:Rule
    val instantTaskExecutorRule = InstantTaskExecutorRule()

    @get:Rule
    val testSchedulerRule = RxImmediateSchedulerRule()

    @Mock
    lateinit var repository: RateRepository

    lateinit var viewModel: MainViewModel

    @Before
    fun setUp() {
        MockitoAnnotations.initMocks(this)
        viewModel = MainViewModel(repository)
    }


    @Test
    fun `Save the selected currency according request code`() {
        viewModel.handleCurrencySelection(CURRENCY_ORIGIN_REQUEST, "USD")

        viewModel.originCurrency.observeForTesting {
            Truth.assertThat(viewModel.originCurrency.getOrAwaitValue()).isEqualTo("USD")
        }

        viewModel.handleCurrencySelection(CURRENCY_DESTINY_REQUEST, "BRL")

        viewModel.destinyCurrency.observeForTesting {
            Truth.assertThat(viewModel.destinyCurrency.getOrAwaitValue()).isEqualTo("BRL")
        }
    }

    @Test
    fun `On Destiny or Origin Click, open the CurrencyActivity with the associated request code`() {
        viewModel.onDestinyClick()

        viewModel.openCurrencyActivity.observeForTesting {
            Truth.assertThat(viewModel.openCurrencyActivity.getOrAwaitValue())
                .isEqualTo(CURRENCY_DESTINY_REQUEST)
        }

        viewModel.onOriginClick()

        viewModel.openCurrencyActivity.observeForTesting {
            Truth.assertThat(viewModel.openCurrencyActivity.getOrAwaitValue())
                .isEqualTo(CURRENCY_ORIGIN_REQUEST)
        }
    }

    @Test
    fun `Display Amount Field only after destiny and origin was selected`() {
        viewModel.handleCurrencySelection(CURRENCY_DESTINY_REQUEST, "BRL")
        viewModel.handleCurrencySelection(CURRENCY_ORIGIN_REQUEST, "USD")

        viewModel.displayAmountField.observeForTesting {
            Truth.assertThat(viewModel.displayAmountField.getOrAwaitValue()).isEqualTo(true)
        }
    }

    @Test
    fun `make conversion with valid amount then receive last update date and the converted value`() {
        whenever(repository.makeConversion("USD", "BRL", 1F))
            .thenReturn(MutableLiveData(Result.Success(Pair("24/06/2020", "5,40"))))

        viewModel.originCurrency.value = "USD"
        viewModel.destinyCurrency.value = "BRL"
        viewModel.convert("1")

        viewModel.resultValue.observeForTesting {
            Truth.assertThat(viewModel.resultValue.getOrAwaitValue())
                .isEqualTo(Pair("24/06/2020", "5,40"))
        }
    }

    @Test
    fun `makeConversion with invalid amount must receive invalid_amount message`() {
        viewModel.originCurrency.value = "USD"
        viewModel.destinyCurrency.value = "BRL"
        viewModel.convert("1,,,")

        viewModel.error.observeForTesting {
            Truth.assertThat(viewModel.error.getOrAwaitValue()).isEqualTo(R.string.invalid_amount)
        }
    }

    @Test
    fun `On Error must receive default error message`() {
        whenever(repository.makeConversion("USD", "BRL", 1F))
            .thenReturn(MutableLiveData(Result.Error(R.string.fetch_rate_default_error_message)))

        viewModel.originCurrency.value = "USD"
        viewModel.destinyCurrency.value = "BRL"
        viewModel.convert("1")

        viewModel.error.observeForTesting {
            Truth.assertThat(viewModel.error.getOrAwaitValue())
                .isEqualTo(R.string.fetch_rate_default_error_message)
        }
    }
}