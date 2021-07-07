package leandro.com.leandroteste.model.response

data class CurrencyListResponse (var success:Boolean? = false,
                                 var currencies: Map<String, String>? = null,
                                 var error: ErrorResponse? = null)