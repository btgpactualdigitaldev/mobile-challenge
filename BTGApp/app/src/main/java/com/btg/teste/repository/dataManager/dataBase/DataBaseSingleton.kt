package com.btg.teste.repository.dataManager.dataBase

import androidx.room.Room
import android.content.Context

class DataBaseSingleton {
    companion object {
        private var _db: DataBase? = null

        fun getInstance(context: Context): DataBase {
            if (_db == null)
                _db = Room.databaseBuilder(context, DataBase::class.java, DataBase.DATABASE_NAME)
                    .build()

            return _db!!
        }
    }


}