package br.com.leandrospidalieri.btgpactualconversion.database

import android.content.Context
import androidx.lifecycle.LiveData
import androidx.room.*

@Dao
interface CurrencyDao{
    @Query("select * from databasecurrency")
    fun getCurrencies() : LiveData<List<DatabaseCurrency>>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertAll(vararg currency: DatabaseCurrency)
}

@Database(entities = [DatabaseCurrency::class], version = 1)
abstract class CurrenciesDatabase:RoomDatabase(){
    abstract val currencyDao: CurrencyDao
}

private lateinit var INSTANCE: CurrenciesDatabase

fun getDatabase(context: Context): CurrenciesDatabase{
    synchronized(CurrenciesDatabase::class.java){
        if(!::INSTANCE.isInitialized){
            INSTANCE = Room.databaseBuilder(context.applicationContext,
                CurrenciesDatabase::class.java,"currencies").build()
        }
    }
    return INSTANCE
}