package br.com.albertomagalhaes.btgcurrencies.extension

import java.util.*

fun convertMillisToDateFormat(calendarInMillis: Long?): String {
    val c = Calendar.getInstance()
    c.timeInMillis = calendarInMillis!!
    val year: Int
    val month: Int
    val day: Int
    year = c[Calendar.YEAR]
    month = c[Calendar.MONTH] + 1
    day = c[Calendar.DAY_OF_MONTH]
    val dayText: String
    val monthText: String
    dayText = if (day.toString().length == 1) "0$day" else day.toString()
    monthText = if (month.toString().length == 1) "0$month" else month.toString()
    return "$dayText/$monthText/$year"
}

fun convertMillisToHourFormat(calendarInMillis: Long?): String {
    val c = Calendar.getInstance()
    c.timeInMillis = calendarInMillis!!
    val hour: Int
    val minute: Int
    hour = c[Calendar.HOUR_OF_DAY]
    minute = c[Calendar.MINUTE]
    val sHour: String
    val sMinute: String
    sHour = if (hour.toString().length == 1) "0$hour" else hour.toString()
    sMinute = if (minute.toString().length == 1) "0$minute" else minute.toString()
    return "$sHour:$sMinute"
}

fun convertTimestampToDateHour(timestamp: Long?) = "${convertMillisToDateFormat(timestamp)} - ${convertMillisToHourFormat(timestamp)}"
