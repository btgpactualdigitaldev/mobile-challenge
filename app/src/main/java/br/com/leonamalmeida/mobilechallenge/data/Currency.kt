package br.com.leonamalmeida.mobilechallenge.data

import androidx.room.Entity
import androidx.room.PrimaryKey

/**
 * Created by Leo Almeida on 27/06/20.
 */

@Entity
data class Currency(
    @PrimaryKey val code: String,
    val name: String
) {
    override fun toString(): String {
        return "$code - $name"
    }
}