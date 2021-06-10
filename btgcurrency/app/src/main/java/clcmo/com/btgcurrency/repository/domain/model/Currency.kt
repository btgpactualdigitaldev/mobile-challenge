package clcmo.com.btgcurrency.repository.domain.model

data class Currency(val id:String, val name: String, var quote: Quote? = null)

