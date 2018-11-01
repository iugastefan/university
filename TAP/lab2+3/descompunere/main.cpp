// Problema 8
#include <iostream>
#include <vector>

using namespace std;

int main() {
    vector<int> pachet{11, 13, 10, 15, 12, 7};
    vector<vector<int>> gramada;
    for (auto x: pachet) {
        bool adaugat = false;
        for (auto &y:gramada) {
            if (x < y.back()) {
                y.push_back(x);
                adaugat = true;
                break;
            }
        }
        if (!adaugat)
            gramada.push_back(vector<int>{x});
    }
    for (auto x:gramada) {
        for (auto y:x)
            cout << y << " ";
        cout << endl;
    }
}
