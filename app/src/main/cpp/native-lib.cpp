/**
 * This is a cpp code to protect sensitive data in a lower level language.
 * Before executing the app, you should update the value of currency_layer_api_key
 * with your own value generated on https://currencylayer.com/.
 *
 * after updates use:
 * git update-index --assume-unchanged app/src/main/cpp/native-lib.cpp
 */
#include <jni.h>
#include <string>

extern "C" JNIEXPORT jstring

JNICALL
Java_com_leonardo_convertcoins_config_Keys_apiKey(JNIEnv *env, jobject object) {
    std::string currency_layer_api_key = "<YOUR_API_KEY_HERE>";
    return env->NewStringUTF(currency_layer_api_key.c_str());
}
