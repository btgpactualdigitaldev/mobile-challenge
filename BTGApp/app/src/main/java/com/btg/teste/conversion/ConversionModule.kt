package com.btg.teste.conversion


import android.app.Activity
import android.view.View
import com.btg.teste.repository.dataManager.repository.currenciesRepository.CurrenciesRepository
import com.btg.teste.repository.dataManager.repository.currenciesRepository.ICurrenciesRepository
import com.btg.teste.repository.remote.service.Connect
import com.btg.teste.repository.remote.service.IConnect
import com.btg.teste.repository.remote.service.currency.ServiceCurrencyLayer
import dagger.Module
import dagger.Provides


@Module
class ConversionModule(
    val context: Activity? = null,
    val view: View? = null,
    val origin: Boolean = false,
    val conversionsFragment: ConversionsFragment? = null,
    val conversionPresenter: ConversionPresenter? = null
) {

    @Provides
    fun provideICurrenciesRepository(): ICurrenciesRepository = CurrenciesRepository(context!!)

    @Provides
    fun provideCurrenciesRouter(): ConversionRouter = ConversionRouter(view!!)

    @Provides
    fun provideCurrenciesInteractorInput(): ConversionContracts.ConversionInteractorInput =
        ConversionInteractor(context!!, conversionPresenter!!, ServiceCurrencyLayer())

    @Provides
    fun provideCurrenciesPresenterInput(): ConversionContracts.ConversionPresenterInput =
        ConversionPresenter(context!!, view!!, origin, conversionsFragment!!)

    @Provides
    fun provideConnect(): IConnect = Connect(context!!)

}