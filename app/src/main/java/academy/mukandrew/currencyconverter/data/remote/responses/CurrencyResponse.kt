package academy.mukandrew.currencyconverter.data.remote.responses

data class CurrencyResponse(
    override val success: Boolean,
    override val error: BaseResponseError? = null,
    val currencies: Map<String, String>
) : BaseResponse