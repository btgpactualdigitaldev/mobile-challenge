package br.com.btg.btgchallenge.network.model

import java.util.*
import kotlin.collections.HashMap


data class ApiResponse<T>
    (
    var success: Boolean?,
    var error: Error?,
    var terms: String?,
    var privacy: String?,
    var timestamp: Int,
    var path: String?,
    var source: String?,
    var quotes: HashMap<String, Double>,
    var currencies: HashMap<String, String>
){
    constructor():this(true, null, null, null, 0, null, null, HashMap(), HashMap())

}