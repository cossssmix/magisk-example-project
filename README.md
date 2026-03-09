<div align="center">
  <h1>Magisk + Zygisk example project</h1>
</div>

This is an example **Magisk + Zygisk** module project.

## Building

You need to download the [Android NDK Tools](https://developer.android.com/ndk/downloads)
place it in a convenient folder, and then add a new environment variable `ANDROID_NDK_HOME` pointing to that folder.

The project is divided into two folders: zygisk-native-lib containing the native library source code, and magisk-module containing the Magisk module itself.

Use the following command to build:

Edit the `module.prop` file.

```ini
id=examplemodule         # Unique module ID used internally by Magisk
name=Example Module      # Display name of the module shown in Magisk
version=v1               # Module version (human-readable)
versionCode=1            # Module version code (integer, used by Magisk to detect updates)
author=me                # Module author
description=none         # Short description of what the module does
```

Now you can modify the code and compile the native library.

```bash
cd zygisk-native-lib
cmake -S . -B build/<architecture> -DCMAKE_SYSTEM_NAME=Android -DCMAKE_SYSTEM_VERSION=21 -DCMAKE_ANDROID_NDK=%ANDROID_NDK_HOME% -DCMAKE_TOOLCHAIN_FILE=%ANDROID_NDK_HOME%/build/cmake/android.toolchain.cmake -DCMAKE_ANDROID_STL_TYPE=c++_static -DCMAKE_ANDROID_ARCH_ABI=<architecture>
cmake --build build/<architecture>
```

Edit the `CMakeLists.txt` file and change the parameter:

```cmake
set(CMAKE_ANDROID_ARCH_ABI <architecture>)
```

`<architecture>` refers to the target CPU architecture. Common options are:

- `armeabi-v7a` – 32-bit ARM
- `arm64-v8a` – 64-bit ARM
- `x86` – 32-bit Intel
- `x86_64` – 64-bit Intel

To check the architecture, run `adb shell uname -a`. By default, the build targets x86_64 for BlueStacks 5 Pie64.

You should use `libcxx` — it is a special library with patches for Zygisk to prevent conflicts. It is located in `zygisk-native-lib/include/libcxx`

To add your module to Magisk, you must enable Zygisk. Then, place the compiled library in:
After that, put everything into a ZIP archive without extra subfolders.

Example archive structure:

```plaintext
magisk_module.zip/
├─ module.prop
├─ customize.sh
├─ zygisk/
│  └─ x86_64.so
```

To test the default module (which logs running processes and apps), run:

```bash
adb logcat -s MyModule
```

The log tag is defined in the code:

```cpp
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, "MyModule", __VA_ARGS__)
```

MyModule is the log tag ID used to filter the module logs.

## Warning

If your IDE complains about paths but the build works fine, add the paths from the `NDK tools folder` to your IDE settings.
