package leandro.com.leandroteste.model.repository;

import java.lang.System;

@kotlin.Metadata(mv = {1, 1, 16}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000:\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0006\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\b\u0003\u0018\u00002\u00020\u0001B\u0015\u0012\u0006\u0010\u0002\u001a\u00020\u0001\u0012\u0006\u0010\u0003\u001a\u00020\u0004\u00a2\u0006\u0002\u0010\u0005J@\u0010\u0006\u001a\u00020\u00072\u0006\u0010\b\u001a\u00020\t2\u0006\u0010\n\u001a\u00020\u000b2\u0012\u0010\f\u001a\u000e\u0012\u0004\u0012\u00020\t\u0012\u0004\u0012\u00020\u00070\r2\u0012\u0010\u000e\u001a\u000e\u0012\u0004\u0012\u00020\t\u0012\u0004\u0012\u00020\u00070\rH\u0016J6\u0010\u000f\u001a\u00020\u00072\u0018\u0010\f\u001a\u0014\u0012\n\u0012\b\u0012\u0004\u0012\u00020\u00110\u0010\u0012\u0004\u0012\u00020\u00070\r2\u0012\u0010\u000e\u001a\u000e\u0012\u0004\u0012\u00020\t\u0012\u0004\u0012\u00020\u00070\rH\u0016J\u0010\u0010\u0012\u001a\u00020\u00072\u0006\u0010\u0013\u001a\u00020\u0011H\u0016R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0002\u001a\u00020\u0001X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0014"}, d2 = {"Lleandro/com/leandroteste/model/repository/CurrencyRepository;", "Lleandro/com/leandroteste/datasource/ICurrencyDataSource;", "remoteDataSource", "currencyLocalDataSource", "Lleandro/com/leandroteste/datasource/CurrencyLocalDataSource;", "(Lleandro/com/leandroteste/datasource/ICurrencyDataSource;Lleandro/com/leandroteste/datasource/CurrencyLocalDataSource;)V", "convert", "", "currencies", "", "fromValue", "", "success", "Lkotlin/Function1;", "failure", "listAll", "", "Lleandro/com/leandroteste/model/data/Currency;", "save", "currency", "app_debug"})
public final class CurrencyRepository implements leandro.com.leandroteste.datasource.ICurrencyDataSource {
    private final leandro.com.leandroteste.datasource.ICurrencyDataSource remoteDataSource = null;
    private final leandro.com.leandroteste.datasource.CurrencyLocalDataSource currencyLocalDataSource = null;
    
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
    
    public CurrencyRepository(@org.jetbrains.annotations.NotNull()
    leandro.com.leandroteste.datasource.ICurrencyDataSource remoteDataSource, @org.jetbrains.annotations.NotNull()
    leandro.com.leandroteste.datasource.CurrencyLocalDataSource currencyLocalDataSource) {
        super();
    }
}