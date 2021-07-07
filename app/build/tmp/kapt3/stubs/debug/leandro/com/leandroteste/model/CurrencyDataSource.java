package leandro.com.leandroteste.model;

import java.lang.System;

@kotlin.Metadata(mv = {1, 1, 16}, bv = {1, 0, 3}, k = 1, d1 = {"\u00008\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0004\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0006\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\b\u0003\u0018\u00002\u00020\u0001B\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J@\u0010\u0007\u001a\u00020\b2\u0006\u0010\t\u001a\u00020\n2\u0006\u0010\u000b\u001a\u00020\f2\u0012\u0010\r\u001a\u000e\u0012\u0004\u0012\u00020\n\u0012\u0004\u0012\u00020\b0\u000e2\u0012\u0010\u000f\u001a\u000e\u0012\u0004\u0012\u00020\n\u0012\u0004\u0012\u00020\b0\u000eH\u0016J6\u0010\u0010\u001a\u00020\b2\u0018\u0010\r\u001a\u0014\u0012\n\u0012\b\u0012\u0004\u0012\u00020\u00120\u0011\u0012\u0004\u0012\u00020\b0\u000e2\u0012\u0010\u000f\u001a\u000e\u0012\u0004\u0012\u00020\n\u0012\u0004\u0012\u00020\b0\u000eH\u0016J\u0010\u0010\u0013\u001a\u00020\b2\u0006\u0010\u0014\u001a\u00020\u0012H\u0016R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\b\n\u0000\u001a\u0004\b\u0005\u0010\u0006\u00a8\u0006\u0015"}, d2 = {"Lleandro/com/leandroteste/model/CurrencyDataSource;", "Lleandro/com/leandroteste/datasource/ICurrencyDataSource;", "currencyApi", "Lleandro/com/leandroteste/model/api/CurrencyApi;", "(Lleandro/com/leandroteste/model/api/CurrencyApi;)V", "getCurrencyApi", "()Lleandro/com/leandroteste/model/api/CurrencyApi;", "convert", "", "currencies", "", "fromValue", "", "success", "Lkotlin/Function1;", "failure", "listAll", "", "Lleandro/com/leandroteste/model/data/Currency;", "save", "currency", "app_debug"})
public final class CurrencyDataSource implements leandro.com.leandroteste.datasource.ICurrencyDataSource {
    @org.jetbrains.annotations.NotNull()
    private final leandro.com.leandroteste.model.api.CurrencyApi currencyApi = null;
    
    @java.lang.Override()
    public void listAll(@org.jetbrains.annotations.NotNull()
    kotlin.jvm.functions.Function1<? super java.util.List<leandro.com.leandroteste.model.data.Currency>, kotlin.Unit> success, @org.jetbrains.annotations.NotNull()
    kotlin.jvm.functions.Function1<? super java.lang.String, kotlin.Unit> failure) {
    }
    
    @java.lang.Override()
    public void save(@org.jetbrains.annotations.NotNull()
    leandro.com.leandroteste.model.data.Currency currency) {
    }
    
    @java.lang.Override()
    public void convert(@org.jetbrains.annotations.NotNull()
    java.lang.String currencies, double fromValue, @org.jetbrains.annotations.NotNull()
    kotlin.jvm.functions.Function1<? super java.lang.String, kotlin.Unit> success, @org.jetbrains.annotations.NotNull()
    kotlin.jvm.functions.Function1<? super java.lang.String, kotlin.Unit> failure) {
    }
    
    @org.jetbrains.annotations.NotNull()
    public final leandro.com.leandroteste.model.api.CurrencyApi getCurrencyApi() {
        return null;
    }
    
    public CurrencyDataSource(@org.jetbrains.annotations.NotNull()
    leandro.com.leandroteste.model.api.CurrencyApi currencyApi) {
        super();
    }
}