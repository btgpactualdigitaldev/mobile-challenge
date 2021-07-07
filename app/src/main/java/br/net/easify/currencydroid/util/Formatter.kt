package br.net.easify.currencydroid.util

import android.annotation.SuppressLint
import java.text.DecimalFormat
import java.text.SimpleDateFormat
import java.util.*
import java.util.concurrent.TimeUnit


class Formatter {

    companion object {
        fun currentDate(): Date {
            return Date()
        }

        fun currentDateTimeDMYAsString(): String {
            val simpleDateFormat = SimpleDateFormat("dd-MM-yyyy HH:mm:ss")
            return simpleDateFormat.format(currentDate())
        }

        fun currentDateTimeYMDAsString(): String {
            val simpleDateFormat = SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
            return simpleDateFormat.format(currentDate())
        }

        fun decimalFormatterTwoDigits(value: Float): String {
            val dec = DecimalFormat("#.##")
            return dec.format(value)
        }

        fun decimalFormatterOneDigit(value: Float): String {
            val dec = DecimalFormat("#.#")
            return dec.format(value)
        }

        @SuppressLint("DefaultLocale")
        fun hmsTimeFormatter(milliSeconds: Long): String {
            return java.lang.String.format(
                "%02d:%02d:%02d",
                TimeUnit.MILLISECONDS.toHours(milliSeconds),
                TimeUnit.MILLISECONDS.toMinutes(milliSeconds) - TimeUnit.HOURS.toMinutes(
                    TimeUnit.MILLISECONDS.toHours(milliSeconds)
                ),
                TimeUnit.MILLISECONDS.toSeconds(milliSeconds) - TimeUnit.MINUTES.toSeconds(
                    TimeUnit.MILLISECONDS.toMinutes(milliSeconds)
                )
            )
        }

        @SuppressLint("DefaultLocale")
        fun msTimeFormatter(milliSeconds: Long): String {
            return java.lang.String.format(
                "%02d:%02d",
                TimeUnit.MILLISECONDS.toMinutes(milliSeconds),
                TimeUnit.MILLISECONDS.toSeconds(milliSeconds) - TimeUnit.MINUTES.toSeconds(
                    TimeUnit.MILLISECONDS.toMinutes(milliSeconds)
                )
            )
        }
    }
}