package br.com.leandrospidalieri.btgpactualconversion.database

import androidx.room.Entity
import androidx.room.PrimaryKey
import br.com.leandrospidalieri.btgpactualconversion.domain.models.Currency

@Entity
data class DatabaseCurrency constructor(
    @PrimaryKey
    val code: String,
    val description: String,
    val quote: Double
)

fun List<DatabaseCurrency>.asDomainCurrency():List<Currency>{
    return map{
        Currency(
            code = it.code,
            description = it.description,
            quote = it.quote
        )
    }
}