package com.example.challengecpqi.util

import android.os.Build
import android.widget.ImageView
import androidx.core.content.ContextCompat
import androidx.databinding.BindingAdapter

@BindingAdapter("imageResource")
fun ImageView.setImageResource(resource: Int) {
    this.setImageResource(resource)
}

@BindingAdapter("imageTint")
fun ImageView.setImageTint(resource: Int) {

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
        this.imageTintList = ContextCompat.getColorStateList(context, resource)
    } else {
        this.setColorFilter(ContextCompat.getColor(context, resource), android.graphics.PorterDuff.Mode.SRC_IN)
    }
}