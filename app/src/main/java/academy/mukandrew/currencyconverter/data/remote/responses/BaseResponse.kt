package academy.mukandrew.currencyconverter.data.remote.responses

interface BaseResponse {
    val success: Boolean
    val error: BaseResponseError?
}