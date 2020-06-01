package br.com.cauejannini.btgmobilechallenge.commons.integracao.domains

import java.io.Serializable

abstract class ApiResponse: Serializable {

    var success: Boolean = false
    var terms: String? = null
    var privacy: String? = null
    var error: ApiError? = null

}