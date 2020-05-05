package com.btg.conversormonetario.data.dto

import com.btg.conversormonetario.data.model.ServiceErrorModel

data class ErrorRepositoryDTO(
    var serviceErrorModel: ServiceErrorModel? = null,
    var alertDTO: AlertDialogDTO? = null
)