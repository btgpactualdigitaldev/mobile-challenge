package com.btg.teste.conversion

import android.app.Activity
import com.btg.teste.components.notNull
import com.btg.teste.entity.Currencies
import com.btg.teste.entity.CurrencyLayer
import com.btg.teste.repository.dataManager.entity.CurrenciesEntity
import com.btg.teste.repository.dataManager.repository.currenciesRepository.ICurrenciesRepository
import com.btg.teste.repository.remote.service.currency.IServiceCurrencyLayer
import com.btg.teste.repository.remote.service.IConnect
import com.btg.teste.utils.Coroutine
import com.btg.teste.viewmodel.Conversion
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

import javax.inject.Inject

class ConversionInteractor(
    private val activity: Activity,
    private val iConversionInteractorOutput: ConversionContracts.ConversionInteractorOutput,
    private val iServiceCurrencyLayer: IServiceCurrencyLayer
) : ConversionContracts.ConversionInteractorInput {

    @Inject
    lateinit var iConnect: IConnect

    @Inject
    lateinit var iCurrenciesRepository: ICurrenciesRepository

    init {
        DaggerConversionComponents
            .builder()
            .conversionModule(
                ConversionModule(
                    context = activity
                )
            )
            .build()
            .inject(this)
    }

    override fun searchCurrencies() {
        if (iConnect.verifyConnection()) {
            iServiceCurrencyLayer.currencies(
                success = {
                    if (it.code() == 200) {
                        val currencies = it.body()
                        if (currencies.notNull()) {
                            if (currencies.success) {
                                searchConversions(currencies)
                            } else {
                                iConversionInteractorOutput.errorMensage("error")
                            }
                        } else {
                            iConversionInteractorOutput.failNetWork()
                        }
                    } else {
                        iConversionInteractorOutput.failResquest(it.code())
                    }
                },
                failure = {
                    iConversionInteractorOutput.errorCurrencyLayer(it)
                    returnBackUp()
                })
        } else {
            iConversionInteractorOutput.failNetWork()
            returnBackUp()
        }

    }

    override fun searchConversions(currencies: Currencies?) {
        if (iConnect.verifyConnection()) {
            iServiceCurrencyLayer.currencyLayer(
                success = {
                    if (it.code() == 200) {
                        val currencyLayer = it.body()
                        if (currencyLayer.notNull()) {
                            if (currencyLayer.success) {
                                GlobalScope.launch {
                                    currencies?.currencies?.forEach { convert ->
                                        currencyLayer.quotes.forEach { mapto ->
                                            if (mapto.key.contains(convert.key)) {
                                                withContext(context = Dispatchers.IO) {
                                                    val backup =
                                                        iCurrenciesRepository.findViewByCurrency(
                                                            convert.key
                                                        )
                                                    if (backup.notNull()) {
                                                        backup.currency = convert.key
                                                        backup.name = convert.value
                                                        backup.value = mapto.value
                                                        iCurrenciesRepository.update(backup)
                                                    } else {
                                                        iCurrenciesRepository.insert(
                                                            CurrenciesEntity(
                                                                currency = convert.key,
                                                                name = convert.value,
                                                                value = mapto.value
                                                            )
                                                        )
                                                    }
                                                }
                                                return@forEach
                                            }
                                        }
                                    }

                                    withContext(context = Dispatchers.Main) {
                                        iConversionInteractorOutput.resultCurrencyLayer(
                                            currencyLayer,
                                            currencies
                                        )
                                    }
                                }
                            } else {
                                iConversionInteractorOutput.errorMensage("error")
                            }
                        } else {
                            iConversionInteractorOutput.failNetWork()
                        }
                    } else {
                        iConversionInteractorOutput.failResquest(it.code())
                    }
                },
                failure = {
                    iConversionInteractorOutput.errorCurrencyLayer(it)
                    returnBackUp()
                })
        } else {
            iConversionInteractorOutput.failNetWork()
            returnBackUp()
        }
    }

    private fun returnBackUp() {
        val finds = iCurrenciesRepository.find()
        if (finds.notNull() && finds.isNotEmpty()) {
            iConversionInteractorOutput.resultCurrencyLayer(
                CurrencyLayer(
                    quotes = finds.associate { Pair(it.currency, it.value) }
                ),
                Currencies(
                    currencies = finds.associate { Pair(it.currency, it.name) }
                )
            )
        }
    }
}