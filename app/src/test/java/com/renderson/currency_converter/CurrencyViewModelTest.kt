package com.renderson.currency_converter

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import com.renderson.currency_converter.repository.CurrencyRepository
import com.renderson.currency_converter.ui.main.CurrencyViewModel
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Mock
import org.mockito.junit.MockitoJUnitRunner

@RunWith(MockitoJUnitRunner::class)
class CurrencyViewModelTest {

    @get:Rule
    val rule = InstantTaskExecutorRule()

    @Mock
    private lateinit var viewModel: CurrencyViewModel

    @Mock
    private lateinit var repository: CurrencyRepository

}