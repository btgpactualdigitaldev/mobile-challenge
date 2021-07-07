package leandro.com.leandroteste.databinding;
import leandro.com.leandroteste.R;
import leandro.com.leandroteste.BR;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import android.view.View;
@SuppressWarnings("unchecked")
public class ActivityMainBindingImpl extends ActivityMainBinding  {

    @Nullable
    private static final androidx.databinding.ViewDataBinding.IncludedLayouts sIncludes;
    @Nullable
    private static final android.util.SparseIntArray sViewsWithIds;
    static {
        sIncludes = null;
        sViewsWithIds = new android.util.SparseIntArray();
        sViewsWithIds.put(R.id.main_title, 9);
        sViewsWithIds.put(R.id.convert_from_info, 10);
        sViewsWithIds.put(R.id.convert_from_value_edt, 11);
        sViewsWithIds.put(R.id.convert_to_info, 12);
        sViewsWithIds.put(R.id.convert_btn, 13);
    }
    // views
    @NonNull
    private final android.widget.RelativeLayout mboundView0;
    // variables
    // values
    // listeners
    // Inverse Binding Event Handlers

    public ActivityMainBindingImpl(@Nullable androidx.databinding.DataBindingComponent bindingComponent, @NonNull View root) {
        this(bindingComponent, root, mapBindings(bindingComponent, root, 14, sIncludes, sViewsWithIds));
    }
    private ActivityMainBindingImpl(androidx.databinding.DataBindingComponent bindingComponent, View root, Object[] bindings) {
        super(bindingComponent, root, 7
            , (androidx.appcompat.widget.AppCompatButton) bindings[13]
            , (android.widget.RelativeLayout) bindings[10]
            , (androidx.appcompat.widget.AppCompatTextView) bindings[3]
            , (androidx.appcompat.widget.AppCompatTextView) bindings[4]
            , (androidx.appcompat.widget.AppCompatEditText) bindings[11]
            , (android.widget.RelativeLayout) bindings[12]
            , (androidx.appcompat.widget.AppCompatTextView) bindings[5]
            , (androidx.appcompat.widget.AppCompatTextView) bindings[6]
            , (androidx.appcompat.widget.AppCompatTextView) bindings[7]
            , (android.widget.LinearLayout) bindings[2]
            , (android.widget.RelativeLayout) bindings[8]
            , (androidx.appcompat.widget.AppCompatTextView) bindings[1]
            , (androidx.appcompat.widget.AppCompatTextView) bindings[9]
            );
        this.convertFromInitials.setTag(null);
        this.convertFromName.setTag(null);
        this.convertToInitials.setTag(null);
        this.convertToName.setTag(null);
        this.convertToValueEdt.setTag(null);
        this.mainContent.setTag(null);
        this.mainLoading.setTag(null);
        this.mainMessage.setTag(null);
        this.mboundView0 = (android.widget.RelativeLayout) bindings[0];
        this.mboundView0.setTag(null);
        setRootTag(root);
        // listeners
        invalidateAll();
    }

    @Override
    public void invalidateAll() {
        synchronized(this) {
                mDirtyFlags = 0x100L;
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
            setViewModel((leandro.com.leandroteste.viewmodel.ConvertViewModel) variable);
        }
        else {
            variableSet = false;
        }
            return variableSet;
    }

    public void setViewModel(@Nullable leandro.com.leandroteste.viewmodel.ConvertViewModel ViewModel) {
        this.mViewModel = ViewModel;
        synchronized(this) {
            mDirtyFlags |= 0x80L;
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
            case 2 :
                return onChangeViewModelToInitials((androidx.lifecycle.MutableLiveData<java.lang.String>) object, fieldId);
            case 3 :
                return onChangeViewModelFromInitials((androidx.lifecycle.MutableLiveData<java.lang.String>) object, fieldId);
            case 4 :
                return onChangeViewModelToValue((androidx.lifecycle.MutableLiveData<java.lang.String>) object, fieldId);
            case 5 :
                return onChangeViewModelFromName((androidx.lifecycle.MutableLiveData<java.lang.String>) object, fieldId);
            case 6 :
                return onChangeViewModelToName((androidx.lifecycle.MutableLiveData<java.lang.String>) object, fieldId);
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
    private boolean onChangeViewModelToInitials(androidx.lifecycle.MutableLiveData<java.lang.String> ViewModelToInitials, int fieldId) {
        if (fieldId == BR._all) {
            synchronized(this) {
                    mDirtyFlags |= 0x4L;
            }
            return true;
        }
        return false;
    }
    private boolean onChangeViewModelFromInitials(androidx.lifecycle.MutableLiveData<java.lang.String> ViewModelFromInitials, int fieldId) {
        if (fieldId == BR._all) {
            synchronized(this) {
                    mDirtyFlags |= 0x8L;
            }
            return true;
        }
        return false;
    }
    private boolean onChangeViewModelToValue(androidx.lifecycle.MutableLiveData<java.lang.String> ViewModelToValue, int fieldId) {
        if (fieldId == BR._all) {
            synchronized(this) {
                    mDirtyFlags |= 0x10L;
            }
            return true;
        }
        return false;
    }
    private boolean onChangeViewModelFromName(androidx.lifecycle.MutableLiveData<java.lang.String> ViewModelFromName, int fieldId) {
        if (fieldId == BR._all) {
            synchronized(this) {
                    mDirtyFlags |= 0x20L;
            }
            return true;
        }
        return false;
    }
    private boolean onChangeViewModelToName(androidx.lifecycle.MutableLiveData<java.lang.String> ViewModelToName, int fieldId) {
        if (fieldId == BR._all) {
            synchronized(this) {
                    mDirtyFlags |= 0x40L;
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
        java.lang.String viewModelFromNameGetValue = null;
        java.lang.String viewModelToValueGetValue = null;
        androidx.lifecycle.MutableLiveData<java.lang.Boolean> viewModelLoadingVisibility = null;
        int viewModelLoadingVisibilityViewGONEViewVISIBLE = 0;
        androidx.lifecycle.MutableLiveData<java.lang.String> viewModelToInitials = null;
        androidx.lifecycle.MutableLiveData<java.lang.String> viewModelFromInitials = null;
        int viewModelLoadingVisibilityViewVISIBLEViewGONE = 0;
        java.lang.String viewModelToInitialsGetValue = null;
        java.lang.String viewModelMessageGetValue = null;
        java.lang.String viewModelFromInitialsGetValue = null;
        androidx.lifecycle.MutableLiveData<java.lang.String> viewModelToValue = null;
        androidx.lifecycle.MutableLiveData<java.lang.String> viewModelFromName = null;
        java.lang.Boolean viewModelLoadingVisibilityGetValue = null;
        java.lang.String viewModelToNameGetValue = null;
        leandro.com.leandroteste.viewmodel.ConvertViewModel viewModel = mViewModel;
        androidx.lifecycle.MutableLiveData<java.lang.String> viewModelToName = null;

        if ((dirtyFlags & 0x1ffL) != 0) {


            if ((dirtyFlags & 0x181L) != 0) {

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
            if ((dirtyFlags & 0x182L) != 0) {

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
                if((dirtyFlags & 0x182L) != 0) {
                    if(androidxDatabindingViewDataBindingSafeUnboxViewModelLoadingVisibilityGetValue) {
                            dirtyFlags |= 0x400L;
                            dirtyFlags |= 0x1000L;
                    }
                    else {
                            dirtyFlags |= 0x200L;
                            dirtyFlags |= 0x800L;
                    }
                }


                    // read androidx.databinding.ViewDataBinding.safeUnbox(viewModel.loadingVisibility.getValue()) ? View.GONE : View.VISIBLE
                    viewModelLoadingVisibilityViewGONEViewVISIBLE = ((androidxDatabindingViewDataBindingSafeUnboxViewModelLoadingVisibilityGetValue) ? (android.view.View.GONE) : (android.view.View.VISIBLE));
                    // read androidx.databinding.ViewDataBinding.safeUnbox(viewModel.loadingVisibility.getValue()) ? View.VISIBLE : View.GONE
                    viewModelLoadingVisibilityViewVISIBLEViewGONE = ((androidxDatabindingViewDataBindingSafeUnboxViewModelLoadingVisibilityGetValue) ? (android.view.View.VISIBLE) : (android.view.View.GONE));
            }
            if ((dirtyFlags & 0x184L) != 0) {

                    if (viewModel != null) {
                        // read viewModel.toInitials
                        viewModelToInitials = viewModel.getToInitials();
                    }
                    updateLiveDataRegistration(2, viewModelToInitials);


                    if (viewModelToInitials != null) {
                        // read viewModel.toInitials.getValue()
                        viewModelToInitialsGetValue = viewModelToInitials.getValue();
                    }
            }
            if ((dirtyFlags & 0x188L) != 0) {

                    if (viewModel != null) {
                        // read viewModel.fromInitials
                        viewModelFromInitials = viewModel.getFromInitials();
                    }
                    updateLiveDataRegistration(3, viewModelFromInitials);


                    if (viewModelFromInitials != null) {
                        // read viewModel.fromInitials.getValue()
                        viewModelFromInitialsGetValue = viewModelFromInitials.getValue();
                    }
            }
            if ((dirtyFlags & 0x190L) != 0) {

                    if (viewModel != null) {
                        // read viewModel.toValue
                        viewModelToValue = viewModel.getToValue();
                    }
                    updateLiveDataRegistration(4, viewModelToValue);


                    if (viewModelToValue != null) {
                        // read viewModel.toValue.getValue()
                        viewModelToValueGetValue = viewModelToValue.getValue();
                    }
            }
            if ((dirtyFlags & 0x1a0L) != 0) {

                    if (viewModel != null) {
                        // read viewModel.fromName
                        viewModelFromName = viewModel.getFromName();
                    }
                    updateLiveDataRegistration(5, viewModelFromName);


                    if (viewModelFromName != null) {
                        // read viewModel.fromName.getValue()
                        viewModelFromNameGetValue = viewModelFromName.getValue();
                    }
            }
            if ((dirtyFlags & 0x1c0L) != 0) {

                    if (viewModel != null) {
                        // read viewModel.toName
                        viewModelToName = viewModel.getToName();
                    }
                    updateLiveDataRegistration(6, viewModelToName);


                    if (viewModelToName != null) {
                        // read viewModel.toName.getValue()
                        viewModelToNameGetValue = viewModelToName.getValue();
                    }
            }
        }
        // batch finished
        if ((dirtyFlags & 0x188L) != 0) {
            // api target 1

            androidx.databinding.adapters.TextViewBindingAdapter.setText(this.convertFromInitials, viewModelFromInitialsGetValue);
        }
        if ((dirtyFlags & 0x1a0L) != 0) {
            // api target 1

            androidx.databinding.adapters.TextViewBindingAdapter.setText(this.convertFromName, viewModelFromNameGetValue);
        }
        if ((dirtyFlags & 0x184L) != 0) {
            // api target 1

            androidx.databinding.adapters.TextViewBindingAdapter.setText(this.convertToInitials, viewModelToInitialsGetValue);
        }
        if ((dirtyFlags & 0x1c0L) != 0) {
            // api target 1

            androidx.databinding.adapters.TextViewBindingAdapter.setText(this.convertToName, viewModelToNameGetValue);
        }
        if ((dirtyFlags & 0x190L) != 0) {
            // api target 1

            androidx.databinding.adapters.TextViewBindingAdapter.setText(this.convertToValueEdt, viewModelToValueGetValue);
        }
        if ((dirtyFlags & 0x182L) != 0) {
            // api target 1

            this.mainContent.setVisibility(viewModelLoadingVisibilityViewGONEViewVISIBLE);
            this.mainLoading.setVisibility(viewModelLoadingVisibilityViewVISIBLEViewGONE);
            this.mainMessage.setVisibility(viewModelLoadingVisibilityViewGONEViewVISIBLE);
        }
        if ((dirtyFlags & 0x181L) != 0) {
            // api target 1

            androidx.databinding.adapters.TextViewBindingAdapter.setText(this.mainMessage, viewModelMessageGetValue);
        }
    }
    // Listener Stub Implementations
    // callback impls
    // dirty flag
    private  long mDirtyFlags = 0xffffffffffffffffL;
    /* flag mapping
        flag 0 (0x1L): viewModel.message
        flag 1 (0x2L): viewModel.loadingVisibility
        flag 2 (0x3L): viewModel.toInitials
        flag 3 (0x4L): viewModel.fromInitials
        flag 4 (0x5L): viewModel.toValue
        flag 5 (0x6L): viewModel.fromName
        flag 6 (0x7L): viewModel.toName
        flag 7 (0x8L): viewModel
        flag 8 (0x9L): null
        flag 9 (0xaL): androidx.databinding.ViewDataBinding.safeUnbox(viewModel.loadingVisibility.getValue()) ? View.GONE : View.VISIBLE
        flag 10 (0xbL): androidx.databinding.ViewDataBinding.safeUnbox(viewModel.loadingVisibility.getValue()) ? View.GONE : View.VISIBLE
        flag 11 (0xcL): androidx.databinding.ViewDataBinding.safeUnbox(viewModel.loadingVisibility.getValue()) ? View.VISIBLE : View.GONE
        flag 12 (0xdL): androidx.databinding.ViewDataBinding.safeUnbox(viewModel.loadingVisibility.getValue()) ? View.VISIBLE : View.GONE
    flag mapping end*/
    //end
}