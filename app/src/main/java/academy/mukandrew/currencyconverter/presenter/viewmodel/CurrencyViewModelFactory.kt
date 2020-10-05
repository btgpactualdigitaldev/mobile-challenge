package academy.mukandrew.currencyconverter.presenter.viewmodel

import academy.mukandrew.currencyconverter.domain.usecases.CurrencyUseCase
import android.app.Application
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider

class CurrencyViewModelFactory(
    private val application: Application,
    private val useCase: CurrencyUseCase
) : ViewModelProvider.Factory {
    override fun <T : ViewModel?> create(modelClass: Class<T>): T {
        return modelClass.getConstructor(
            Application::class.java,
            CurrencyUseCase::class.java
        ).newInstance(
            application,
            useCase
        )
    }
}