package br.dev.infra.btgconversiontool.data

import androidx.room.ColumnInfo
import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(
    tableName = "timestamp_table"
)
data class TimestampTable(
    @ColumnInfo(name = "timestamp") @PrimaryKey val timestamp: String
)
