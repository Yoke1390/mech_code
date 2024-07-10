#include <iostream>
using namespace std;

class Deposit {
private:
  int balance;

public:
  Deposit(int init_balance) { balance = init_balance; }
  int withdraw(int amount) {
    if (amount > balance) {
      cerr << "Insufficient funds" << endl;
    } else {
      balance = balance - amount;
    }
    return balance;
  }
};

int main() {
  Deposit kei = Deposit(100);
  Deposit bill = Deposit(1000);

  cout << "kei  :" << kei.withdraw(25) << endl;
  cout << "bill :" << bill.withdraw(25) << endl;
}
