package com.gui.antonio.testebtg.data

import androidx.room.Entity
import androidx.room.PrimaryKey
import com.google.gson.annotations.Expose

import com.google.gson.annotations.SerializedName

@Entity(tableName = "currencies")
class Currencies(
    @PrimaryKey(autoGenerate = true)
    var id: Int? = null,
    val symbol: String,
    val name: String
)
