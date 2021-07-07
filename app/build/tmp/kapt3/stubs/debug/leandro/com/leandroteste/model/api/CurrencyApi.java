package leandro.com.leandroteste.model.api;

import java.lang.System;

@kotlin.Metadata(mv = {1, 1, 16}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000\"\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0002\bf\u0018\u0000 \t2\u00020\u0001:\u0001\tJ\u0018\u0010\u0002\u001a\b\u0012\u0004\u0012\u00020\u00040\u00032\b\b\u0001\u0010\u0005\u001a\u00020\u0006H\'J\u000e\u0010\u0007\u001a\b\u0012\u0004\u0012\u00020\b0\u0003H\'\u00a8\u0006\n"}, d2 = {"Lleandro/com/leandroteste/model/api/CurrencyApi;", "", "convert", "Lretrofit2/Call;", "Lleandro/com/leandroteste/model/response/ConvertResponse;", "currencies", "", "listCurrencies", "Lleandro/com/leandroteste/model/response/CurrencyListResponse;", "Companion", "app_debug"})
public abstract interface CurrencyApi {
    public static final leandro.com.leandroteste.model.api.CurrencyApi.Companion Companion = null;
    
    @org.jetbrains.annotations.NotNull()
    @retrofit2.http.GET(value = "list?access_key=3eab59c5260ed0ea7df8955fbc3306ba")
    public abstract retrofit2.Call<leandro.com.leandroteste.model.response.CurrencyListResponse> listCurrencies();
    
    @org.jetbrains.annotations.NotNull()
    @retrofit2.http.GET(value = "live?access_key=3eab59c5260ed0ea7df8955fbc3306ba&currencies=")
    public abstract retrofit2.Call<leandro.com.leandroteste.model.response.ConvertResponse> convert(@org.jetbrains.annotations.NotNull()
    @retrofit2.http.Query(value = "currencies")
    java.lang.String currencies);
    
    @kotlin.Metadata(mv = {1, 1, 16}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000\u0012\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\b\u0002\n\u0002\u0010\u000e\n\u0000\b\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\b\u0002\u00a2\u0006\u0002\u0010\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0005"}, d2 = {"Lleandro/com/leandroteste/model/api/CurrencyApi$Companion;", "", "()V", "ACCESS_KEY", "", "app_debug"})
    public static final class Companion {
        private static final java.lang.String ACCESS_KEY = "?access_key=3eab59c5260ed0ea7df8955fbc3306ba";
        
        private Companion() {
            super();
        }
    }
}