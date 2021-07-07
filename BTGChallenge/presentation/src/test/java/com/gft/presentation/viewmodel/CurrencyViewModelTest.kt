package com.gft.presentation.viewmodel

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.lifecycle.Observer
import com.gft.domain.usecases.ConvertUseCase
import com.gft.presentation.entities.ConvertEntity
import io.mockk.MockKAnnotations
import io.mockk.coEvery
import io.mockk.impl.annotations.MockK
import io.mockk.verify
import kotlinx.coroutines.runBlocking
import org.junit.Before
import org.junit.Rule
import org.junit.Test

class CurrencyViewModelTest {
    @get:Rule
    var instantExecutorRule = InstantTaskExecutorRule()

    @MockK
    lateinit var convertUseCase: ConvertUseCase

    @MockK
    lateinit var observer: Observer<ConvertEntity>

    lateinit var currencyViewModel: CurrencyViewModel

    @Before
    fun setUp() {
        MockKAnnotations.init(this)
        this.currencyViewModel = CurrencyViewModel(convertUseCase)
    }

    @Test
    fun testConvert_Success() = runBlocking {
        coEvery { convertUseCase.execute(any(), any(), any()) } returns 0.0

        currencyViewModel.convert()
    }

}