package com.btg.conversormonetario.business.repository

import com.btg.conversormonetario.R
import com.btg.conversormonetario.data.dto.AlertDialogDTO
import com.btg.conversormonetario.data.dto.ErrorRepositoryDTO
import com.btg.conversormonetario.data.model.ServiceErrorModel
import com.btg.conversormonetario.data.service.Api

open class BaseRepository(var api: Api) {

    companion object {
        private fun getTitleAlertByHttpCode(httpCode: Int): Int {
            return when (httpCode) {
                400, 401, 403 -> R.string.alert_title_400
                404 -> R.string.alert_title_404
                500, 502, 503, 504 -> R.string.alert_title_500
                else -> R.string.alert_title_generic
            }
        }

        fun processBusinessError(serviceErrorModel: ServiceErrorModel): ErrorRepositoryDTO {
            val alertDTO = AlertDialogDTO(
                title = getTitleAlertByHttpCode(serviceErrorModel.httpCode),
                message = serviceErrorModel.response?.info
                    ?: "Nāo conseguimos achar uma causa para este problema. Tente novamente, e se o problema persistir, tente mais tarde.",
                textPositiveButton = R.string.all_understood
            )
            return ErrorRepositoryDTO(serviceErrorModel, alertDTO)
        }
    }
}