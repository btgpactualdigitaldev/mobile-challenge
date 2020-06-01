package br.com.cauejannini.btgmobilechallenge.commons.integracao.domains

import java.io.Serializable

class ApiError: Serializable {

    var code: Number? = null
    var info: String? = null
}