#include <m3i/m3i.h>
#include <chrono>
#include <cstdint>
#include <iostream>

uint64_t measure(int x, int y, int z) {
    std::chrono::steady_clock::time_point begin =
            std::chrono::steady_clock::now();
    M3i m3i(x, y, z);
    std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now();
    return std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin).count();
}
int main() {
    for (int i=10; i < 1420; i += 100) {
        uint64_t small;
        for (int x = 0; x < N; ++x) {
            small = measure(i, i, i);
            std::cout << NAME << "," << TYPE << "," << i << "," << ((long double) small) / (i * i * i) << "\n";
        }
    }
}
