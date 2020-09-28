package br.com.convertify.api.responses

data class QuotationApiResponse(
    val success: Boolean,
    val terms: String,
    val privacy: String,
    val quotes: Map<String, Double>
) {
}