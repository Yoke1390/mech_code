class Account {
  constructor(name, init_balance) {
    this.name = name;
    this.balance = init_balance;
  }

  make_withdraw(amount) {
    if (this.balance >= amount) {
      this.balance -= amount;
      console.log(`${this.name}: ${this.balance}`);
      return;
    } else {
      console.log(`${this.name}: Insufficient funds`);
      return;
    }
  }
}

const kei = new Account("kei", 100);
const bill = new Account("bill", 1000);

kei.make_withdraw(25);
bill.make_withdraw(25);

kei.make_withdraw(25);
bill.make_withdraw(25);

kei.make_withdraw(60);
bill.make_withdraw(60);
