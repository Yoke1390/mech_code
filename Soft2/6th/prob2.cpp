#include <iostream>

auto make_withdraw(auto init_balance) {
  auto balance = init_balance;
  return [balance](auto amount) mutable {
    if (balance >= amount) {
      balance -= amount;
      return balance;
    } else {
      std::cout << "Insufficient funds";
      return 0;
    }
  };
}

int main() {
  auto kei = make_withdraw(100);
  auto bill = make_withdraw(1000);

  std::cout << "kei  :" << kei(25) << std::endl;
  std::cout << "bill :" << bill(25) << std::endl;

  std::cout << "kei  :" << kei(25) << std::endl;
  std::cout << "bill :" << bill(25) << std::endl;

  std::cout << "kei  :" << kei(60) << std::endl;
  std::cout << "bill :" << bill(60) << std::endl;
}
