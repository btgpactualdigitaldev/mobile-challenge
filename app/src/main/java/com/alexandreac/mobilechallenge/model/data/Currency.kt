package com.alexandreac.mobilechallenge.model.data

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity
data class Currency (@PrimaryKey var initials:String, @ColumnInfo(name = "name") var name:String)