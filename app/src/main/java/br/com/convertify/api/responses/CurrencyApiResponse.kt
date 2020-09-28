package br.com.convertify.api.responses

data class CurrencyApiResponse(
    val success: Boolean,
    val terms: String,
    val privacy: String,
    val currencies: Map<String, String>
) {
}