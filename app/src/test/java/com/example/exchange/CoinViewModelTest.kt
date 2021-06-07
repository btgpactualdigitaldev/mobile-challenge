package com.example.exchange

import android.view.View
import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.lifecycle.Observer
import com.example.exchange.viewmodel.CoinViewModel
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.rules.TestRule
import org.junit.runner.RunWith
import org.junit.runners.JUnit4
import org.mockito.Mock
import org.mockito.Mockito.verify
import org.mockito.MockitoAnnotations

@RunWith(JUnit4::class)
class CoinViewModelTest {

    @get:Rule
    var instantTaskExecutorRule: TestRule = InstantTaskExecutorRule()

    @Mock
    lateinit var loading: Observer<Int>

    private var viewmodel = CoinViewModel()

    @Before
    fun setUp() {
        MockitoAnnotations.initMocks(this)
        viewmodel.requestData()
        viewmodel.getLoading().observeForever(loading)
    }

    @Test
    fun showProgressBar() {
        verify(loading).onChanged(View.VISIBLE)
    }
}