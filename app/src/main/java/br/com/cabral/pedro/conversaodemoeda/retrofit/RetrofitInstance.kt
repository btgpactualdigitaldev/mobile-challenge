package br.com.cabral.pedro.conversaodemoeda.retrofit

import br.com.cabral.pedro.conversaodemoeda.enum.EnderecoAPI
import com.google.gson.Gson
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class RetrofitInstance {

    companion object{
        fun getRetrofitInstance(): Retrofit {
            return Retrofit.Builder()
                .baseUrl(EnderecoAPI.URL_API_BASE.valor)
                .addConverterFactory(GsonConverterFactory.create(Gson()))
                .build()
        }
    }

}