package br.com.cauejannini.btgmobilechallenge.commons.integracao.domains

import java.io.Serializable

class RatesResponse : ApiResponse(), Serializable{

    var source: String? = null
    var quotes: HashMap<String, Double>? = null

}