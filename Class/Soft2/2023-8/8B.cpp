#include <iostream>
using namespace std;

auto make_withdraw(auto init_balance) {
  auto balance = init_balance;
  return [balance](auto amount) mutable {
    if (amount > balance) {
      cerr << "Insufficient funds" << endl;
    } else {
      balance = balance - amount;
    }
    return balance;
  };
}

int main() {
  auto kei = make_withdraw(100);
  auto bill = make_withdraw(1000);

  cout << "kei  :" << kei(25) << endl;
  cout << "bill :" << bill(25) << endl;
}
