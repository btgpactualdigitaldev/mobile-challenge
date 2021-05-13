package br.com.btg.btgchallenge.network.room

import androidx.room.TypeConverter
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import java.lang.reflect.Type
import java.util.*
import kotlin.collections.HashMap


class Converters {
    @TypeConverter
    fun fromTimestamp(value: Long?): Date? {
        return value?.let { Date(it) }
    }

    @TypeConverter
    fun dateToTimestamp(date: Date?): Long? {
        return date?.time?.toLong()
    }

    @TypeConverter
    fun stringToTypes(json: String?): ArrayList<String>? {
        val gson = Gson()
        val type: Type = object : TypeToken<List<String?>?>() {}.type
        return gson.fromJson<ArrayList<String>>(json, type)
    }

    @TypeConverter
    fun typesToString(list: ArrayList<String?>?): String? {
        val gson = Gson()
        val type: Type = object : TypeToken<List<String?>?>() {}.type
        return gson.toJson(list, type)
    }

//    @TypeConverter
//    fun stringToMapString(json: String?): Map<String, String> {
//        return Gson().fromJson(json,  object : TypeToken<Map<String, String>>() {}.type)
//    }
//
//    @TypeConverter
//    fun mapToStringString(value: Map<String, String>?): String {
//        return if(value == null) "" else Gson().toJson(value)
//    }
//
//    @TypeConverter
//    fun stringToMapDouble(json: String?): Map<String, Double> {
//        return Gson().fromJson(json,  object : TypeToken<Map<String, Double>>() {}.type)
//    }
//
//    @TypeConverter
//    fun mapToStringDouble(value: Map<String, Double>?): String {
//        return if(value == null) "" else Gson().toJson(value)
//    }





    @TypeConverter
    fun stringToHashMapString(json: String?): HashMap<String, String> {
        return Gson().fromJson(json,  object : TypeToken<HashMap<String, String>>() {}.type)
    }

    @TypeConverter
    fun hashmapToStringString(value: HashMap<String, String>?): String {
        return if(value == null) "" else Gson().toJson(value)
    }

    @TypeConverter
    fun stringToHashMapDouble(json: String?): HashMap<String, Double> {
        return Gson().fromJson(json,  object : TypeToken<HashMap<String, Double>>() {}.type)
    }

    @TypeConverter
    fun hashmapToStringDouble(value: HashMap<String, Double>?): String {
        return if(value == null) "" else Gson().toJson(value)
    }
}