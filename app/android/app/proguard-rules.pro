# tflite_flutter ссылается на GPU-делегат (org.tensorflow.lite.gpu.*),
# который лежит в tensorflow-lite-gpu-api и не включён в сборку.
# Мы используем только CPU-инференс, поэтому классы GPU можно не сохранять —
# достаточно не ронять R8 на отсутствующих классах.
-dontwarn org.tensorflow.lite.gpu.**

# Сохраняем API TF Lite для JNI-вызовов из нативного кода
-keep class org.tensorflow.lite.** { *; }
