package leandro.com.leandroteste.ui;

import java.lang.System;

@kotlin.Metadata(mv = {1, 1, 16}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000@\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\b\u0006\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\b\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\b\u0002\n\u0002\u0018\u0002\n\u0002\b\u0002\u0018\u0000 \u00192\u00020\u0001:\u0001\u0019B\u0005\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\t\u001a\u00020\u00042\u0006\u0010\n\u001a\u00020\u000bJ\u000e\u0010\f\u001a\u00020\r2\u0006\u0010\u000e\u001a\u00020\u000bJ\"\u0010\u000f\u001a\u00020\u00102\u0006\u0010\u0011\u001a\u00020\u00122\u0006\u0010\u0013\u001a\u00020\u00122\b\u0010\u0014\u001a\u0004\u0018\u00010\u0015H\u0014J\u0012\u0010\u0016\u001a\u00020\u00102\b\u0010\u0017\u001a\u0004\u0018\u00010\u0018H\u0014R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086.\u00a2\u0006\u000e\n\u0000\u001a\u0004\b\u0005\u0010\u0006\"\u0004\b\u0007\u0010\b\u00a8\u0006\u001a"}, d2 = {"Lleandro/com/leandroteste/ui/MainActivity;", "Landroidx/appcompat/app/AppCompatActivity;", "()V", "viewModel", "Lleandro/com/leandroteste/viewmodel/ConvertViewModel;", "getViewModel", "()Lleandro/com/leandroteste/viewmodel/ConvertViewModel;", "setViewModel", "(Lleandro/com/leandroteste/viewmodel/ConvertViewModel;)V", "creatViewModel", "application", "Landroid/app/Application;", "currencyDao", "Lleandro/com/leandroteste/model/dao/CurrencyDao;", "applicationContext", "onActivityResult", "", "requestCode", "", "resultCode", "data", "Landroid/content/Intent;", "onCreate", "savedInstanceState", "Landroid/os/Bundle;", "Companion", "app_debug"})
public final class MainActivity extends androidx.appcompat.app.AppCompatActivity {
    @org.jetbrains.annotations.NotNull()
    public leandro.com.leandroteste.viewmodel.ConvertViewModel viewModel;
    @org.jetbrains.annotations.NotNull()
    public static final java.lang.String CONVERT_FROM = "covertFrom";
    public static final int CONVERT_FROM_RESULT_OK = 1;
    @org.jetbrains.annotations.NotNull()
    public static final java.lang.String CONVERT_FROM_RESULT_INITIALS = "CONVERT_FROM_RESULT_INITIALS";
    @org.jetbrains.annotations.NotNull()
    public static final java.lang.String CONVERT_FROM_RESULT_NAME = "CONVERT_FROM_RESULT_NAME";
    @org.jetbrains.annotations.NotNull()
    public static final java.lang.String CONVERT_TO = "covertTo";
    public static final int CONVERT_TO_RESULT_OK = 2;
    @org.jetbrains.annotations.NotNull()
    public static final java.lang.String CONVERT_TO_RESULT_INITIALS = "CONVERT_TO_RESULT_INITIALS";
    @org.jetbrains.annotations.NotNull()
    public static final java.lang.String CONVERT_TO_RESULT_NAME = "CONVERT_TO_RESULT_NAME";
    public static final leandro.com.leandroteste.ui.MainActivity.Companion Companion = null;
    private java.util.HashMap _$_findViewCache;
    
    @org.jetbrains.annotations.NotNull()
    public final leandro.com.leandroteste.viewmodel.ConvertViewModel getViewModel() {
        return null;
    }
    
    public final void setViewModel(@org.jetbrains.annotations.NotNull()
    leandro.com.leandroteste.viewmodel.ConvertViewModel p0) {
    }
    
    @java.lang.Override()
    protected void onCreate(@org.jetbrains.annotations.Nullable()
    android.os.Bundle savedInstanceState) {
    }
    
    @org.jetbrains.annotations.NotNull()
    public final leandro.com.leandroteste.viewmodel.ConvertViewModel creatViewModel(@org.jetbrains.annotations.NotNull()
    android.app.Application application) {
        return null;
    }
    
    @org.jetbrains.annotations.NotNull()
    public final leandro.com.leandroteste.model.dao.CurrencyDao currencyDao(@org.jetbrains.annotations.NotNull()
    android.app.Application applicationContext) {
        return null;
    }
    
    @java.lang.Override()
    protected void onActivityResult(int requestCode, int resultCode, @org.jetbrains.annotations.Nullable()
    android.content.Intent data) {
    }
    
    public MainActivity() {
        super();
    }
    
    @kotlin.Metadata(mv = {1, 1, 16}, bv = {1, 0, 3}, k = 1, d1 = {"\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\b\u0002\n\u0002\u0010\u000e\n\u0002\b\u0003\n\u0002\u0010\b\n\u0002\b\u0005\b\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\b\u0002\u00a2\u0006\u0002\u0010\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\bX\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000b\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\f\u001a\u00020\bX\u0086T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\r"}, d2 = {"Lleandro/com/leandroteste/ui/MainActivity$Companion;", "", "()V", "CONVERT_FROM", "", "CONVERT_FROM_RESULT_INITIALS", "CONVERT_FROM_RESULT_NAME", "CONVERT_FROM_RESULT_OK", "", "CONVERT_TO", "CONVERT_TO_RESULT_INITIALS", "CONVERT_TO_RESULT_NAME", "CONVERT_TO_RESULT_OK", "app_debug"})
    public static final class Companion {
        
        private Companion() {
            super();
        }
    }
}