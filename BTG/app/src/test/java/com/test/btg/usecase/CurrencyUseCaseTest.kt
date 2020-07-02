package com.test.btg.usecase

import com.test.btg.repository.CurrencyRepository
import io.mockk.every
import io.mockk.mockk
import io.reactivex.disposables.Disposable
import org.junit.Assert.assertSame
import org.junit.Test

class CurrencyUseCaseTest {

    @Test
    fun whenRequestLives_ShouldReceiveDisposable() {
        val repository = mockk<CurrencyRepository>(relaxed = true)

        val mockDisposable = mockk<Disposable>()
        every { repository.searchLive(any(), any()) } returns mockDisposable

        val useCase = CurrencyUseCase(repository)

        val disposable = useCase.requestLive({}, {})

        assertSame(disposable, mockDisposable)
    }
}