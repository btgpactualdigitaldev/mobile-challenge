package com.btg.conversormonetario.business.repository

import com.btg.conversormonetario.business.service.ServiceManager
import com.btg.conversormonetario.data.dto.ErrorRepositoryDTO
import com.btg.conversormonetario.data.model.InfoCurrencyModel
import com.btg.conversormonetario.data.service.Api

class WelcomeRepository(api: Api) : BaseRepository(api) {

    suspend fun getInfoCurrencies(
        onSuccess: (InfoCurrencyModel.Response) -> Unit,
        onError: (ErrorRepositoryDTO) -> Unit
    ) {
        ServiceManager.serviceCaller(api.getInfoCurrencies().await(), {
            onSuccess.invoke(it)
        }, {
            onError.invoke(processBusinessError(it))
        })
    }
}