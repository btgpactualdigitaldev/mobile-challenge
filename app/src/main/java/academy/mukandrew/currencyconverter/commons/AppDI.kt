package academy.mukandrew.currencyconverter.commons

import academy.mukandrew.currencyconverter.data.datasources.CurrencyLocalDataSource
import academy.mukandrew.currencyconverter.data.datasources.CurrencyRemoteDataSource
import academy.mukandrew.currencyconverter.data.local.room.AppDatabase
import academy.mukandrew.currencyconverter.data.remote.retrofit.RetrofitConfig
import academy.mukandrew.currencyconverter.domain.repositories.CurrencyRepositoryImpl
import academy.mukandrew.currencyconverter.domain.usecases.CurrencyUseCase
import academy.mukandrew.currencyconverter.domain.usecases.CurrencyUseCaseImpl
import android.content.Context

object AppDI {

    private var useCase: CurrencyUseCase? = null

    fun getCurrencyUseCase(context: Context): CurrencyUseCase {
        return useCase ?: let {
            val local = CurrencyLocalDataSource(AppDatabase.createDatabase(context))
            val remote = CurrencyRemoteDataSource(RetrofitConfig().getRetrofitConfig(context))
            val repository = CurrencyRepositoryImpl(local, remote)
            CurrencyUseCaseImpl(repository).also { useCase = it }
        }
    }

}