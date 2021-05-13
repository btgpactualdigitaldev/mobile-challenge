package br.com.btg.btgchallenge.network.model.currency

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "quotes_table")
data class Quotes(
    @PrimaryKey(autoGenerate = true)
    @ColumnInfo(name = "id")var id : Int = 0,
    @ColumnInfo(name = "quotes")var quotes: HashMap<String, Double>,
    @ColumnInfo(name = "lastUpdate") var lastUpdate: Int?
) {

}