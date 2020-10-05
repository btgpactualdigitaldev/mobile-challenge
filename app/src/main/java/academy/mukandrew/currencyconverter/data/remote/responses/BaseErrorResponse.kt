package academy.mukandrew.currencyconverter.data.remote.responses

interface BaseResponseError {
    val code: Int
    val info: String
}