package academy.mukandrew.currencyconverter.data.remote.responses

data class QuoteResponse(
    override val success: Boolean,
    override val error: BaseResponseError?,
    val quotes: Map<String, Float>
) : BaseResponse