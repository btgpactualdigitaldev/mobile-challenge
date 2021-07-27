package com.btg.teste.repository.dataManager.repository

import android.content.Context
import com.btg.teste.repository.dataManager.dao.IDao
import com.btg.teste.repository.dataManager.dataBase.DataBase
import com.btg.teste.repository.dataManager.dataBase.DataBaseSingleton
import com.btg.teste.utils.Coroutine
import java.lang.reflect.Type

abstract class AbstractRepository<T, E>(context: Context, type: Type) where T : IDao<E> {
    protected var _dao: T

    private lateinit var c: Class<T>

    init {
        _dao = dbSet(context, type)
    }

    fun <U> dbSet(context: Context, type: Type): U where U : IDao<E> {
        return DataBase::class.java.methods.find { x -> x.returnType == type }?.invoke(
                DataBaseSingleton.getInstance(context)) as U
    }

    fun <U> execute(action: () -> U?): U? {
        var result: U? = null

        Coroutine.start {
            try {
                result = action()
            } catch (t: Throwable) {
                result = null
            }
        }
        return result
    }
}