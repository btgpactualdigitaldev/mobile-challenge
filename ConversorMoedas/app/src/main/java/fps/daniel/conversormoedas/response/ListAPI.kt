package fps.daniel.conversormoedas.response

data class ListAPI(

    var success: Boolean = false,
    var terms: String = "",
    var privacy: String = "",
    var currencies: Map<String,String> = HashMap()
)