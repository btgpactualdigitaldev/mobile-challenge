package br.com.leonamalmeida.mobilechallenge.data.source.local.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import br.com.leonamalmeida.mobilechallenge.data.Currency
import io.reactivex.Completable
import io.reactivex.Flowable

/**
 * Created by Leo Almeida on 27/06/20.
 */

@Dao
interface CurrencyDao {

    @Query("SELECT * FROM currency WHERE code LIKE :keyToSearch OR name LIKE :keyToSearch ORDER BY CASE WHEN :orderByName = 0 THEN code ELSE name END")
    fun getCurrencies(keyToSearch: String, orderByName: Boolean): Flowable<List<Currency>>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertCurrencies(currencies: List<Currency>): Completable
}