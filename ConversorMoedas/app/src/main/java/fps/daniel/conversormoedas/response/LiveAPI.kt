package fps.daniel.conversormoedas.response

data class LiveAPI(
    val success: Boolean,
    val terms: String,
    val privacy: String,
    val quotes: Map<String,Double>
)