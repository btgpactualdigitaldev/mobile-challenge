package leandro.com.leandroteste.viewmodel;

import java.lang.System;

@kotlin.Metadata(mv = {1, 1, 16}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000D\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\b\b\n\u0002\u0010\u000b\n\u0002\b\u0002\n\u0002\u0010\u000e\n\u0002\b\u0004\n\u0002\u0010\u0002\n\u0002\b\u0004\u0018\u00002\u00020\u00012\u00020\u0002B\u0015\u0012\u0006\u0010\u0003\u001a\u00020\u0004\u0012\u0006\u0010\u0005\u001a\u00020\u0006\u00a2\u0006\u0002\u0010\u0007J\b\u0010\u001b\u001a\u00020\u001cH\u0007J\u0006\u0010\u001d\u001a\u00020\u001cJ\u0006\u0010\u001e\u001a\u00020\u001cJ\u000e\u0010\u001f\u001a\u00020\u001c2\u0006\u0010\u001f\u001a\u00020\u0017R\u001d\u0010\b\u001a\u000e\u0012\n\u0012\b\u0012\u0004\u0012\u00020\u000b0\n0\t\u00a2\u0006\b\n\u0000\u001a\u0004\b\f\u0010\rR \u0010\u000e\u001a\b\u0012\u0004\u0012\u00020\u000b0\nX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\b\u000f\u0010\u0010\"\u0004\b\u0011\u0010\u0012R\u0017\u0010\u0013\u001a\b\u0012\u0004\u0012\u00020\u00140\t\u00a2\u0006\b\n\u0000\u001a\u0004\b\u0015\u0010\rR\u0017\u0010\u0016\u001a\b\u0012\u0004\u0012\u00020\u00170\t\u00a2\u0006\b\n\u0000\u001a\u0004\b\u0018\u0010\rR\u0011\u0010\u0003\u001a\u00020\u0004\u00a2\u0006\b\n\u0000\u001a\u0004\b\u0019\u0010\u001a\u00a8\u0006 "}, d2 = {"Lleandro/com/leandroteste/viewmodel/CurrencyListViewModel;", "Landroidx/lifecycle/AndroidViewModel;", "Landroidx/lifecycle/LifecycleObserver;", "repository", "Lleandro/com/leandroteste/datasource/ICurrencyDataSource;", "application", "Landroid/app/Application;", "(Lleandro/com/leandroteste/datasource/ICurrencyDataSource;Landroid/app/Application;)V", "currencies", "Landroidx/lifecycle/MutableLiveData;", "", "Lleandro/com/leandroteste/model/data/Currency;", "getCurrencies", "()Landroidx/lifecycle/MutableLiveData;", "items", "getItems", "()Ljava/util/List;", "setItems", "(Ljava/util/List;)V", "loadingVisibility", "", "getLoadingVisibility", "message", "", "getMessage", "getRepository", "()Lleandro/com/leandroteste/datasource/ICurrencyDataSource;", "load", "", "orderListByInitials", "orderListByName", "search", "app_debug"})
public final class CurrencyListViewModel extends androidx.lifecycle.AndroidViewModel implements androidx.lifecycle.LifecycleObserver {
    @org.jetbrains.annotations.NotNull()
    private final androidx.lifecycle.MutableLiveData<java.util.List<leandro.com.leandroteste.model.data.Currency>> currencies = null;
    @org.jetbrains.annotations.NotNull()
    private final androidx.lifecycle.MutableLiveData<java.lang.Boolean> loadingVisibility = null;
    @org.jetbrains.annotations.NotNull()
    private final androidx.lifecycle.MutableLiveData<java.lang.String> message = null;
    @org.jetbrains.annotations.NotNull()
    private java.util.List<leandro.com.leandroteste.model.data.Currency> items;
    @org.jetbrains.annotations.NotNull()
    private final leandro.com.leandroteste.datasource.ICurrencyDataSource repository = null;
    
    @org.jetbrains.annotations.NotNull()
    public final androidx.lifecycle.MutableLiveData<java.util.List<leandro.com.leandroteste.model.data.Currency>> getCurrencies() {
        return null;
    }
    
    @org.jetbrains.annotations.NotNull()
    public final androidx.lifecycle.MutableLiveData<java.lang.Boolean> getLoadingVisibility() {
        return null;
    }
    
    @org.jetbrains.annotations.NotNull()
    public final androidx.lifecycle.MutableLiveData<java.lang.String> getMessage() {
        return null;
    }
    
    @org.jetbrains.annotations.NotNull()
    public final java.util.List<leandro.com.leandroteste.model.data.Currency> getItems() {
        return null;
    }
    
    public final void setItems(@org.jetbrains.annotations.NotNull()
    java.util.List<leandro.com.leandroteste.model.data.Currency> p0) {
    }
    
    @androidx.lifecycle.OnLifecycleEvent(value = androidx.lifecycle.Lifecycle.Event.ON_START)
    public final void load() {
    }
    
    public final void orderListByInitials() {
    }
    
    public final void orderListByName() {
    }
    
    public final void search(@org.jetbrains.annotations.NotNull()
    java.lang.String search) {
    }
    
    @org.jetbrains.annotations.NotNull()
    public final leandro.com.leandroteste.datasource.ICurrencyDataSource getRepository() {
        return null;
    }
    
    public CurrencyListViewModel(@org.jetbrains.annotations.NotNull()
    leandro.com.leandroteste.datasource.ICurrencyDataSource repository, @org.jetbrains.annotations.NotNull()
    android.app.Application application) {
        super(null);
    }
}