package com.br.btgteste.presentation.list

import androidx.lifecycle.MutableLiveData
import com.br.btgteste.domain.model.ApiResult
import com.br.btgteste.domain.model.Currency
import com.br.btgteste.domain.usecase.CurrencyListUseCase
import com.br.btgteste.domain.usecase.ResponseBlock
import com.br.btgteste.getCompletionBlockFromUseCase
import com.br.btgteste.test
import com.nhaarman.mockitokotlin2.any
import com.nhaarman.mockitokotlin2.doReturn
import com.nhaarman.mockitokotlin2.verify
import com.nhaarman.mockitokotlin2.whenever
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.Mockito
import org.mockito.MockitoAnnotations

class ListCurrencyViewModelTest {

    private lateinit var viewModelSpy: ListCurrencyViewModel

    @Mock
    lateinit var liveDataResponseMock: MutableLiveData<ApiResult<List<Currency>>>

    @Mock
    lateinit var currencyListUseCaseMock: CurrencyListUseCase

    @Before
    fun setup() {
        MockitoAnnotations.initMocks(this)
        viewModelSpy = Mockito.spy(
            ListCurrencyViewModel(currencyListUseCaseMock).apply {
                liveDataResponse = liveDataResponseMock
            }
        )
    }

    @Test
    fun requestCurrencies_setCorrectCall_fromListCurrencies() = test {
       lateinit var completionBlock: ResponseBlock<List<Currency>>
        val result = ApiResult.Success<List<Currency>>(listOf())
        arrange {
            doReturn(result).whenever(currencyListUseCaseMock).executeAsyncTasks(any())
        }
        act {
            viewModelSpy.getCurrencies()
            completionBlock = getCompletionBlockFromUseCase(currencyListUseCaseMock)
            completionBlock.invoke(result)
        }
        assert {
            verify(liveDataResponseMock).value = result
        }
    }
}