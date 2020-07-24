package com.desafio.btgpactual.baseasync

import android.os.AsyncTask

class BaseAsyncTask<T>(
    private val executeTask: () -> T,
    private val finishTask: (result: T) -> Unit
) : AsyncTask<Void, Void, T>() {

    override fun doInBackground(vararg params: Void?) = executeTask()

    override fun onPostExecute(result: T) {
        super.onPostExecute(result)
        finishTask(result)
    }

}