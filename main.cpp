#include <iostream>
#include <map>
#include <vector>

int main () {
std::map<int, int> map = { {1,2}, {2, 3}, {3, 5}};
std::vector<int> nums = {1, 2, 3, 4};

    for (int n : nums) {
    std::cout << n << " ";
    }


    for (auto& pair : map) {
    std::cout << pair.first << " " << pair.second << "  ";
}
}