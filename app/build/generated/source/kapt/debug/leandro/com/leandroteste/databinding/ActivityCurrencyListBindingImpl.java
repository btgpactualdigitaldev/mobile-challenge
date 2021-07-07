package leandro.com.leandroteste.databinding;
import leandro.com.leandroteste.R;
import leandro.com.leandroteste.BR;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import android.view.View;
@SuppressWarnings("unchecked")
public class ActivityCurrencyListBindingImpl extends ActivityCurrencyListBinding  {

    @Nullable
    private static final androidx.databinding.ViewDataBinding.IncludedLayouts sIncludes;
    @Nullable
    private static final android.util.SparseIntArray sViewsWithIds;
    static {
        sIncludes = null;
        sViewsWithIds = new android.util.SparseIntArray();
        sViewsWithIds.put(R.id.currency_list_back, 4);
        sViewsWithIds.put(R.id.currency_list_search_edt, 5);
        sViewsWithIds.put(R.id.currency_list_search_btn, 6);
        sViewsWithIds.put(R.id.currency_list_title, 7);
        sViewsWithIds.put(R.id.currency_list_switch, 8);
    }
    // views
    @NonNull
    private final android.widget.ProgressBar mboundView2;
    // variables
    // values
    // listeners
    // Inverse Binding Event Handlers

    public ActivityCurrencyListBindingImpl(@Nullable androidx.databinding.DataBindingComponent bindingComponent, @NonNull View root) {
        this(bindingComponent, root, mapBindings(bindingComponent, root, 9, sIncludes, sViewsWithIds));
    }
    private ActivityCurrencyListBindingImpl(androidx.databinding.DataBindingComponent bindingComponent, View root, Object[] bindings) {
        super(bindingComponent, root, 2
            , (android.widget.RelativeLayout) bindings[4]
            , (androidx.recyclerview.widget.RecyclerView) bindings[3]
            , (android.widget.LinearLayout) bindings[0]
            , (android.widget.TextView) bindings[1]
            , (android.widget.RelativeLayout) bindings[6]
            , (android.widget.EditText) bindings[5]
            , (android.widget.Switch) bindings[8]
            , (android.widget.TextView) bindings[7]
            );
        this.currencyListItems.setTag(null);
        this.currencyListLayout.setTag(null);
        this.currencyListMessage.setTag(null);
        this.mboundView2 = (android.widget.ProgressBar) bindings[2];
        this.mboundView2.setTag(null);
        setRootTag(root);
        // listeners
        invalidateAll();
    }

    @Override
    public void invalidateAll() {
        synchronized(this) {
                mDirtyFlags = 0x8L;
        }
        requestRebind();
    }

    @Override
    public boolean hasPendingBindings() {
        synchronized(this) {
            if (mDirtyFlags != 0) {
                return true;
            }
        }
        return false;
    }

    @Override
    public boolean setVariable(int variableId, @Nullable Object variable)  {
        boolean variableSet = true;
        if (BR.viewModel == variableId) {
            setViewModel((leandro.com.leandroteste.viewmodel.CurrencyListViewModel) variable);
        }
        else {
            variableSet = false;
        }
            return variableSet;
    }

    public void setViewModel(@Nullable leandro.com.leandroteste.viewmodel.CurrencyListViewModel ViewModel) {
        this.mViewModel = ViewModel;
        synchronized(this) {
            mDirtyFlags |= 0x4L;
        }
        notifyPropertyChanged(BR.viewModel);
        super.requestRebind();
    }

    @Override
    protected boolean onFieldChange(int localFieldId, Object object, int fieldId) {
        switch (localFieldId) {
            case 0 :
                return onChangeViewModelMessage((androidx.lifecycle.MutableLiveData<java.lang.String>) object, fieldId);
            case 1 :
                return onChangeViewModelLoadingVisibility((androidx.lifecycle.MutableLiveData<java.lang.Boolean>) object, fieldId);
        }
        return false;
    }
    private boolean onChangeViewModelMessage(androidx.lifecycle.MutableLiveData<java.lang.String> ViewModelMessage, int fieldId) {
        if (fieldId == BR._all) {
            synchronized(this) {
                    mDirtyFlags |= 0x1L;
            }
            return true;
        }
        return false;
    }
    private boolean onChangeViewModelLoadingVisibility(androidx.lifecycle.MutableLiveData<java.lang.Boolean> ViewModelLoadingVisibility, int fieldId) {
        if (fieldId == BR._all) {
            synchronized(this) {
                    mDirtyFlags |= 0x2L;
            }
            return true;
        }
        return false;
    }

    @Override
    protected void executeBindings() {
        long dirtyFlags = 0;
        synchronized(this) {
            dirtyFlags = mDirtyFlags;
            mDirtyFlags = 0;
        }
        androidx.lifecycle.MutableLiveData<java.lang.String> viewModelMessage = null;
        boolean androidxDatabindingViewDataBindingSafeUnboxViewModelLoadingVisibilityGetValue = false;
        int viewModelLoadingVisibilityViewVISIBLEViewGONE = 0;
        androidx.lifecycle.MutableLiveData<java.lang.Boolean> viewModelLoadingVisibility = null;
        java.lang.String viewModelMessageGetValue = null;
        int viewModelLoadingVisibilityViewGONEViewVISIBLE = 0;
        java.lang.Boolean viewModelLoadingVisibilityGetValue = null;
        leandro.com.leandroteste.viewmodel.CurrencyListViewModel viewModel = mViewModel;

        if ((dirtyFlags & 0xfL) != 0) {


            if ((dirtyFlags & 0xdL) != 0) {

                    if (viewModel != null) {
                        // read viewModel.message
                        viewModelMessage = viewModel.getMessage();
                    }
                    updateLiveDataRegistration(0, viewModelMessage);


                    if (viewModelMessage != null) {
                        // read viewModel.message.getValue()
                        viewModelMessageGetValue = viewModelMessage.getValue();
                    }
            }
            if ((dirtyFlags & 0xeL) != 0) {

                    if (viewModel != null) {
                        // read viewModel.loadingVisibility
                        viewModelLoadingVisibility = viewModel.getLoadingVisibility();
                    }
                    updateLiveDataRegistration(1, viewModelLoadingVisibility);


                    if (viewModelLoadingVisibility != null) {
                        // read viewModel.loadingVisibility.getValue()
                        viewModelLoadingVisibilityGetValue = viewModelLoadingVisibility.getValue();
                    }


                    // read androidx.databinding.ViewDataBinding.safeUnbox(viewModel.loadingVisibility.getValue())
                    androidxDatabindingViewDataBindingSafeUnboxViewModelLoadingVisibilityGetValue = androidx.databinding.ViewDataBinding.safeUnbox(viewModelLoadingVisibilityGetValue);
                if((dirtyFlags & 0xeL) != 0) {
                    if(androidxDatabindingViewDataBindingSafeUnboxViewModelLoadingVisibilityGetValue) {
                            dirtyFlags |= 0x20L;
                            dirtyFlags |= 0x80L;
                    }
                    else {
                            dirtyFlags |= 0x10L;
                            dirtyFlags |= 0x40L;
                    }
                }


                    // read androidx.databinding.ViewDataBinding.safeUnbox(viewModel.loadingVisibility.getValue()) ? View.VISIBLE : View.GONE
                    viewModelLoadingVisibilityViewVISIBLEViewGONE = ((androidxDatabindingViewDataBindingSafeUnboxViewModelLoadingVisibilityGetValue) ? (android.view.View.VISIBLE) : (android.view.View.GONE));
                    // read androidx.databinding.ViewDataBinding.safeUnbox(viewModel.loadingVisibility.getValue()) ? View.GONE : View.VISIBLE
                    viewModelLoadingVisibilityViewGONEViewVISIBLE = ((androidxDatabindingViewDataBindingSafeUnboxViewModelLoadingVisibilityGetValue) ? (android.view.View.GONE) : (android.view.View.VISIBLE));
            }
        }
        // batch finished
        if ((dirtyFlags & 0xeL) != 0) {
            // api target 1

            this.currencyListItems.setVisibility(viewModelLoadingVisibilityViewGONEViewVISIBLE);
            this.currencyListMessage.setVisibility(viewModelLoadingVisibilityViewGONEViewVISIBLE);
            this.mboundView2.setVisibility(viewModelLoadingVisibilityViewVISIBLEViewGONE);
        }
        if ((dirtyFlags & 0xdL) != 0) {
            // api target 1

            androidx.databinding.adapters.TextViewBindingAdapter.setText(this.currencyListMessage, viewModelMessageGetValue);
        }
    }
    // Listener Stub Implementations
    // callback impls
    // dirty flag
    private  long mDirtyFlags = 0xffffffffffffffffL;
    /* flag mapping
        flag 0 (0x1L): viewModel.message
        flag 1 (0x2L): viewModel.loadingVisibility
        flag 2 (0x3L): viewModel
        flag 3 (0x4L): null
        flag 4 (0x5L): androidx.databinding.ViewDataBinding.safeUnbox(viewModel.loadingVisibility.getValue()) ? View.VISIBLE : View.GONE
        flag 5 (0x6L): androidx.databinding.ViewDataBinding.safeUnbox(viewModel.loadingVisibility.getValue()) ? View.VISIBLE : View.GONE
        flag 6 (0x7L): androidx.databinding.ViewDataBinding.safeUnbox(viewModel.loadingVisibility.getValue()) ? View.GONE : View.VISIBLE
        flag 7 (0x8L): androidx.databinding.ViewDataBinding.safeUnbox(viewModel.loadingVisibility.getValue()) ? View.GONE : View.VISIBLE
    flag mapping end*/
    //end
}