package com.btg.conversormonetario.business.repository

import com.btg.conversormonetario.business.service.ServiceManager.Companion.serviceCaller
import com.btg.conversormonetario.data.dto.ErrorRepositoryDTO
import com.btg.conversormonetario.data.model.ConvertCurrencyModel
import com.btg.conversormonetario.data.service.Api

class CurrencyRepository(api: Api) : BaseRepository(api) {

    suspend fun getCurrencyConverted(
        currentCurrency: String,
        targetCurrency: String,
        amountCurrency: String,
        onSuccess: (ConvertCurrencyModel.Response) -> Unit,
        onError: (ErrorRepositoryDTO) -> Unit
    ) {
        serviceCaller(api.getCurrencyConverted(currentCurrency, targetCurrency, amountCurrency).await(), {
            onSuccess.invoke(it)
        }, {
            onError.invoke(processBusinessError(it))
        })
    }
}