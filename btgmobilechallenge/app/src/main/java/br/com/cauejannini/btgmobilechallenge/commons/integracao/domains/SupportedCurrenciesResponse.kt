package br.com.cauejannini.btgmobilechallenge.commons.integracao.domains

import java.io.Serializable

class SupportedCurrenciesResponse : ApiResponse(), Serializable{

    var currencies: HashMap<String, String>? = null

}