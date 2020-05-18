package com.btg.teste.moneyConvert


import android.app.Activity
import android.view.View
import com.btg.teste.repository.remote.service.Connect
import com.btg.teste.repository.remote.service.IConnect
import dagger.Module
import dagger.Provides


@Module
class MoneyConvertModule(
    val context: Activity? = null,
    val view: View? = null,
    val moneyConvertFragment: MoneyConvertFragment? = null,
    val moneyConvertPresenter: MoneyConvertPresenter? = null
) {

    @Provides
    fun provideMoneyConvertRouter(): MoneyConvertRouter = MoneyConvertRouter(view!!)

    @Provides
    fun provideMoneyConvertPresenterInput(): MoneyConvertContracts.MoneyConvertPresenterInput {
        return MoneyConvertPresenter(context!!, view!!, moneyConvertFragment!!)
    }

    @Provides
    fun provideConnect(): IConnect = Connect(context!!)

}