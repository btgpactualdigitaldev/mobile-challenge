package leandro.com.leandroteste.ui.adapter;

import java.lang.System;

@kotlin.Metadata(mv = {1, 1, 16}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000:\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\b\u0005\n\u0002\u0018\u0002\n\u0002\u0010\u0002\n\u0002\b\u0005\n\u0002\u0010\b\n\u0002\b\u0005\n\u0002\u0018\u0002\n\u0002\b\u0004\u0018\u00002\f\u0012\b\u0012\u00060\u0002R\u00020\u00000\u00012\u00020\u0003:\u0001\u001cB\u0013\u0012\f\u0010\u0004\u001a\b\u0012\u0004\u0012\u00020\u00060\u0005\u00a2\u0006\u0002\u0010\u0007J\b\u0010\u0012\u001a\u00020\u0013H\u0016J\u001c\u0010\u0014\u001a\u00020\r2\n\u0010\u0015\u001a\u00060\u0002R\u00020\u00002\u0006\u0010\u0016\u001a\u00020\u0013H\u0016J\u001c\u0010\u0017\u001a\u00060\u0002R\u00020\u00002\u0006\u0010\u0018\u001a\u00020\u00192\u0006\u0010\u001a\u001a\u00020\u0013H\u0016J\u0014\u0010\u001b\u001a\u00020\r2\n\u0010\u0004\u001a\u0006\u0012\u0002\b\u00030\u0005H\u0016R \u0010\u0004\u001a\b\u0012\u0004\u0012\u00020\u00060\u0005X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\b\b\u0010\t\"\u0004\b\n\u0010\u0007R(\u0010\u000b\u001a\u0010\u0012\u0004\u0012\u00020\u0006\u0012\u0004\u0012\u00020\r\u0018\u00010\fX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\b\u000e\u0010\u000f\"\u0004\b\u0010\u0010\u0011\u00a8\u0006\u001d"}, d2 = {"Lleandro/com/leandroteste/ui/adapter/CurrenciesAdapter;", "Landroidx/recyclerview/widget/RecyclerView$Adapter;", "Lleandro/com/leandroteste/ui/adapter/CurrenciesAdapter$ViewHolder;", "Lleandro/com/leandroteste/ui/adapter/AdapterItemsContract;", "items", "", "Lleandro/com/leandroteste/model/data/Currency;", "(Ljava/util/List;)V", "getItems", "()Ljava/util/List;", "setItems", "onItemClick", "Lkotlin/Function1;", "", "getOnItemClick", "()Lkotlin/jvm/functions/Function1;", "setOnItemClick", "(Lkotlin/jvm/functions/Function1;)V", "getItemCount", "", "onBindViewHolder", "holder", "position", "onCreateViewHolder", "parent", "Landroid/view/ViewGroup;", "viewType", "replaceItems", "ViewHolder", "app_debug"})
public final class CurrenciesAdapter extends androidx.recyclerview.widget.RecyclerView.Adapter<leandro.com.leandroteste.ui.adapter.CurrenciesAdapter.ViewHolder> implements leandro.com.leandroteste.ui.adapter.AdapterItemsContract {
    @org.jetbrains.annotations.Nullable()
    private kotlin.jvm.functions.Function1<? super leandro.com.leandroteste.model.data.Currency, kotlin.Unit> onItemClick;
    @org.jetbrains.annotations.NotNull()
    private java.util.List<leandro.com.leandroteste.model.data.Currency> items;
    
    @org.jetbrains.annotations.Nullable()
    public final kotlin.jvm.functions.Function1<leandro.com.leandroteste.model.data.Currency, kotlin.Unit> getOnItemClick() {
        return null;
    }
    
    public final void setOnItemClick(@org.jetbrains.annotations.Nullable()
    kotlin.jvm.functions.Function1<? super leandro.com.leandroteste.model.data.Currency, kotlin.Unit> p0) {
    }
    
    @org.jetbrains.annotations.NotNull()
    @java.lang.Override()
    public leandro.com.leandroteste.ui.adapter.CurrenciesAdapter.ViewHolder onCreateViewHolder(@org.jetbrains.annotations.NotNull()
    android.view.ViewGroup parent, int viewType) {
        return null;
    }
    
    @java.lang.Override()
    public int getItemCount() {
        return 0;
    }
    
    @java.lang.Override()
    public void onBindViewHolder(@org.jetbrains.annotations.NotNull()
    leandro.com.leandroteste.ui.adapter.CurrenciesAdapter.ViewHolder holder, int position) {
    }
    
    @java.lang.Override()
    public void replaceItems(@org.jetbrains.annotations.NotNull()
    java.util.List<?> items) {
    }
    
    @org.jetbrains.annotations.NotNull()
    public final java.util.List<leandro.com.leandroteste.model.data.Currency> getItems() {
        return null;
    }
    
    public final void setItems(@org.jetbrains.annotations.NotNull()
    java.util.List<leandro.com.leandroteste.model.data.Currency> p0) {
    }
    
    public CurrenciesAdapter(@org.jetbrains.annotations.NotNull()
    java.util.List<leandro.com.leandroteste.model.data.Currency> items) {
        super();
    }
    
    @kotlin.Metadata(mv = {1, 1, 16}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000\u001e\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0004\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\b\u0086\u0004\u0018\u00002\u00020\u0001B\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J\u000e\u0010\u0007\u001a\u00020\b2\u0006\u0010\t\u001a\u00020\nR\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\b\n\u0000\u001a\u0004\b\u0005\u0010\u0006\u00a8\u0006\u000b"}, d2 = {"Lleandro/com/leandroteste/ui/adapter/CurrenciesAdapter$ViewHolder;", "Landroidx/recyclerview/widget/RecyclerView$ViewHolder;", "binding", "Lleandro/com/leandroteste/databinding/CurrencyItemBinding;", "(Lleandro/com/leandroteste/ui/adapter/CurrenciesAdapter;Lleandro/com/leandroteste/databinding/CurrencyItemBinding;)V", "getBinding", "()Lleandro/com/leandroteste/databinding/CurrencyItemBinding;", "bind", "", "currency", "Lleandro/com/leandroteste/model/data/Currency;", "app_debug"})
    public final class ViewHolder extends androidx.recyclerview.widget.RecyclerView.ViewHolder {
        @org.jetbrains.annotations.NotNull()
        private final leandro.com.leandroteste.databinding.CurrencyItemBinding binding = null;
        
        public final void bind(@org.jetbrains.annotations.NotNull()
        leandro.com.leandroteste.model.data.Currency currency) {
        }
        
        @org.jetbrains.annotations.NotNull()
        public final leandro.com.leandroteste.databinding.CurrencyItemBinding getBinding() {
            return null;
        }
        
        public ViewHolder(@org.jetbrains.annotations.NotNull()
        leandro.com.leandroteste.databinding.CurrencyItemBinding binding) {
            super(null);
        }
    }
}