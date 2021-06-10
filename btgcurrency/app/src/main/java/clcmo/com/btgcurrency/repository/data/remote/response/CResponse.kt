package clcmo.com.btgcurrency.repository.data.remote.response

import clcmo.com.btgcurrency.repository.data.remote.response.interfaces.*

data class CResponse(
    override val success: Boolean,
    override val error: ErrorResponse? = null,
    val mapCurrencies: Map<String, String>
): BaseResponse

