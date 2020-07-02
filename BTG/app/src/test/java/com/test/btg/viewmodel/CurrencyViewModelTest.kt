package com.test.btg.viewmodel

import android.view.View
import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import com.test.btg.usecase.CurrencyUseCase
import com.test.core.model.Lives
import io.mockk.every
import io.mockk.mockk
import io.reactivex.disposables.Disposable
import org.junit.Assert.assertEquals
import org.junit.Rule
import org.junit.Test

class CurrencyViewModelTest {

    @get:Rule
    val rule = InstantTaskExecutorRule()

    @Test
    fun whenInteractWithCurrencyInteractsCreatedActivity_ShouldDoRequestDataAndShowLoadingAndNotifyDataViewStatus() {
        val useCase = mockk<CurrencyUseCase>()
        val mockDisposable = mockk<Disposable>()
        val viewModel = CurrencyViewModel(useCase)
        val lives = mockk<Lives>()

        every { useCase.requestLive(any(), any()) } returns mockDisposable


        viewModel.interact(CurrencyInteracts.CreatedActivity)

        assertEquals(
            viewModel.loadingStatus.value,
            CurrencyAnswer.LoadingStatus(View.VISIBLE)
        )

        viewModel.createSuccessCallbackLives().invoke(lives)

        assertEquals(
            viewModel.loadingStatus.value,
            CurrencyAnswer.LoadingStatus(View.GONE)
        )

        assertEquals(
            viewModel.answers.value,
            CurrencyAnswer.CurrencyLives(lives)
        )

    }

    @Test
    fun whenInteractWithCurrencyInteractsCreatedActivityAndErrorApi_ShouldHideLoadingAndNotifyViewError() {
        val useCase = mockk<CurrencyUseCase>()
        val mockDisposable = mockk<Disposable>()
        val viewModel = CurrencyViewModel(useCase)
        val message = "message"

        every { useCase.requestLive(any(), any()) } returns mockDisposable


        viewModel.interact(CurrencyInteracts.CreatedActivity)

        assertEquals(
            viewModel.loadingStatus.value,
            CurrencyAnswer.LoadingStatus(View.VISIBLE)
        )

        viewModel
            .createFailureCallbackLives()
            .invoke(IllegalStateException(message))

        assertEquals(
            viewModel.loadingStatus.value,
            CurrencyAnswer.LoadingStatus(View.GONE)
        )

        assertEquals(
            viewModel.answers.value,
            CurrencyAnswer.Error(message)
        )
    }
}