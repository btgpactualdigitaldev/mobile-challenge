package clcmo.com.btgcurrency.repository.data.remote.response

import clcmo.com.btgcurrency.repository.data.remote.response.interfaces.*

data class QResponse(
    override val success: Boolean,
    override val error: ErrorResponse? = null,
    val mapQuotes: Map<String, Float>
): BaseResponse