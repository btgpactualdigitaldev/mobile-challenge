package com.eden.btg.http

import android.app.Activity
import android.content.Intent
import android.os.AsyncTask
import android.util.JsonReader
import android.widget.ListView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.eden.btg.R
import com.eden.btg.activity.ViewDialog
import com.eden.btg.adapter.ListaMoedasAdapter
import com.eden.btg.model.Moeda
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL


class SetValorEmDollar(
    var moeda: Moeda,
    val contexto: AppCompatActivity
) : AsyncTask<Void?, Void?, Void?>() {
    val accessKey = "7889a399bbd3086cf1e9028b104c89ea"
    var erro: String = ""
    val metodo = "live"
    val objetoProcurado = "quotes"
    val vd = ViewDialog(contexto)

    override fun doInBackground(vararg p0: Void?): Void? {
        val endpoint = URL("http://api.currencylayer.com/$metodo?access_key=$accessKey")
        publishProgress()

        if(moeda.sigla == "USD"){
            moeda.vrDollar = 1.0
        } else {

            val myConnection: HttpURLConnection =
                endpoint.openConnection() as HttpURLConnection

            if (myConnection.responseCode == 200) {
                val jsonReader = JsonReader(InputStreamReader(myConnection.inputStream, "UTF-8"))

                jsonReader.beginObject()

                while (jsonReader.hasNext()) {
                    val key = jsonReader.nextName()
                    if (key == objetoProcurado) {
                        jsonReader.beginObject()
                        while (jsonReader.hasNext()) {
                            if (jsonReader.nextName().substring(3, 6) == moeda.sigla) {
                                moeda.vrDollar = jsonReader.nextDouble()
                                if (moeda.vrDollar <= 0) getErro(999)
                            } else
                                jsonReader.nextDouble()
                        }
                        break
                    } else {
                        jsonReader.skipValue()
                    }
                }

            } else {
                erro = getErro(myConnection.responseCode)
            }
        }
        return null
    }

    override fun onProgressUpdate(vararg values: Void?) {
        super.onProgressUpdate(*values)
        vd.showDialog()
    }

    override fun onPostExecute(result: Void?) {
        super.onPostExecute(result)
        val returnIntent = Intent()
        returnIntent.putExtra("MOEDA", moeda)
        contexto.setResult(Activity.RESULT_OK, returnIntent)
        vd.hideDialog()
        contexto.finish()
    }

    fun getErro(erro: Int): String {
        val msg = when (erro) {
            404 -> R.string.erro404
            101 -> R.string.erro101
            103 -> R.string.erro103
            104 -> R.string.erro104
            105 -> R.string.erro105
            106 -> R.string.erro106
            102 -> R.string.erro102
            201 -> R.string.erro201
            202 -> R.string.erro202
            301 -> R.string.erro301
            302 -> R.string.erro302
            401 -> R.string.erro401
            402 -> R.string.erro402
            403 -> R.string.erro403
            501 -> R.string.erro501
            502 -> R.string.erro502
            503 -> R.string.erro503
            504 -> R.string.erro504
            505 -> R.string.erro505
            999 -> "Valor não encontrado para a moeda selecionada"
            else ->R.string.erroelse
        }
        return "Ocorreu um problema ao obter a lista, \n $msg"

    }
}


class DownloadListaMoeda(
    var lv: ListView,
    var contexto: AppCompatActivity
) : AsyncTask<Void, Void, ArrayList<Moeda>>() {
    val accessKey = "7889a399bbd3086cf1e9028b104c89ea"
    var erro: String = ""
    val metodo = "list"
    val objetoProcurado = "currencies"
    val vd = ViewDialog(contexto)

    override fun doInBackground(vararg p0: Void?): ArrayList<Moeda> {
        val listaMoedas: ArrayList<Moeda> = ArrayList()
        val endpoint = URL("http://api.currencylayer.com/$metodo?access_key=$accessKey")
        publishProgress()

        val myConnection: HttpURLConnection =
            endpoint.openConnection() as HttpURLConnection

        if (myConnection.responseCode == 200) {
            val jsonReader = JsonReader(InputStreamReader(myConnection.inputStream, "UTF-8"))

            jsonReader.beginObject()

            while (jsonReader.hasNext()) {
                val key = jsonReader.nextName()
                if (key == objetoProcurado) {
                    jsonReader.beginObject()
                    while (jsonReader.hasNext()) {
                        listaMoedas.add(Moeda(jsonReader.nextName(), jsonReader.nextString()))
                    }
                    break
                } else {
                    jsonReader.skipValue()
                }
            }

        } else {
            erro = getErro(myConnection.responseCode)
        }
        return listaMoedas
    }

    override fun onProgressUpdate(vararg values: Void?) {
        super.onProgressUpdate(*values)
        vd.showDialog()
    }

    override fun onPostExecute(result: ArrayList<Moeda>) {
        Toast.makeText(contexto, erro.takeIf { it != "" } ?: "Lista Completa", Toast.LENGTH_LONG)
            .show()
        lv.adapter = ListaMoedasAdapter(result, contexto)
        vd.hideDialog()
    }

    fun getErro(erro: Int): String {
        val msg = when (erro) {
            404 -> R.string.erro404
            101 -> R.string.erro101
            103 -> R.string.erro103
            104 -> R.string.erro104
            105 -> R.string.erro105
            106 -> R.string.erro106
            102 -> R.string.erro102
            201 -> R.string.erro201
            202 -> R.string.erro202
            301 -> R.string.erro301
            302 -> R.string.erro302
            401 -> R.string.erro401
            402 -> R.string.erro402
            403 -> R.string.erro403
            501 -> R.string.erro501
            502 -> R.string.erro502
            503 -> R.string.erro503
            504 -> R.string.erro504
            505 -> R.string.erro505
            else ->R.string.erroelse
        }
        return "Ocorreu um problema ao obter a lista, \n $msg"

    }
}
