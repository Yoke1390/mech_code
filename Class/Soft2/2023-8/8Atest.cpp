#include <iostream>
using namespace std;

class Deposit {
private:
  int balance;

public:
  int open_balance;

  Deposit(int init_balance) {
    balance = init_balance;
    open_balance = balance * 2;
  }

  int withdraw(int amount) {
    if (amount > balance) {
      cerr << "Insufficient funds" << endl;
    } else {
      balance = balance - amount;
      open_balance -= amount * 2;
    }
    return balance;
  }
};

int main() {
  Deposit kei = Deposit(100);
  Deposit bill = Deposit(1000);

  // cout << "kei true balance: " << kei.balance << endl; // compile error
  cout << "kei says: " << kei.open_balance << endl;
  cout << "kei  :" << kei.withdraw(25) << endl;
  cout << "kei says: " << kei.open_balance << endl;
  cout << "bill :" << bill.withdraw(25) << endl;
}
