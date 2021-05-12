## CONVERT COINS





|Home Screen|Currencies List|Converted Value|Searching Currency
|----|-------|-------|--------|
|<img width=400 src="https://user-images.githubusercontent.com/17517057/117727661-b72cc800-b1be-11eb-95ba-1f041d2d4b0f.png"/>|<img width=400 src="https://user-images.githubusercontent.com/17517057/117729096-c0b72f80-b1c0-11eb-9ca0-13d92bd8cfc8.png">|<img width=400 src="https://user-images.githubusercontent.com/17517057/117729344-14c21400-b1c1-11eb-9656-8a621dd725ab.png"/>|<img width=400 src="https://user-images.githubusercontent.com/17517057/117729429-315e4c00-b1c1-11eb-9a8c-183c6d04ed05.png">


This app is a platform that allows you to convert all kind of coins and see it's current value related to another.

It uses this concept in order to show Kotlin programming and serves as a example on how to use the following features:

    * Shared preferences to keep user last currencies choice
    * SQLite to save last quotes and last available coins
    * Compatible with dark theme


All live data is retrieved from https://currencylayer.com/ and it's public API. You can set a paid subscription API KEY
and your code will work as expected too. Keep in mind that if you use a free API KEY your app will have a limit on the number of calls, so it will stop working with live data in the future.

As mentioned, you need a API KEY for the app to work. To insert that information on the code, check the following steps:

    1) generate one on https://currencylayer.com/
    2) past it inside native-lib.cpp file changing <YOUR_API_KEY_HERE> with the value of your API KEY
    3) run git update-index --assume-unchanged app/src/main/cpp/native-lib.cpp to never upload this changes

Feel free to enjoy the app :)

# references
- currency layer: https://currencylayer.com/documentation
- cpp api_key: https://www.codementor.io/blog/kotlin-apikeys-7o0g54qk5b
- recycler view: https://www.raywenderlich.com/1560485-android-recyclerview-tutorial-with-kotlin
- extensions: https://antonioleiva.com/kotlin-android-extensions/
- RecyclerView Empty Observer: https://stackoverflow.com/a/43953603/10526869
- Scroll view to bottom without loosing focus: https://stackoverflow.com/a/34866634/10526869
- View tags: https://stackoverflow.com/a/15021758/10526869
- ImageButton: https://developer.android.com/reference/android/widget/ImageButton
- Data binding:
    https://developer.android.com/topic/libraries/data-binding/index.html#includes
    https://developer.android.com/topic/libraries/view-binding#activities
