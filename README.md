# Amortization Calculator With Rails

Loany McLoany Funds now wants a slight extension to this system. Some clients find it difficult to pay
funds back soon after they borrow them. For these clients, they are going to modify the repayment
process such that for the first 3 months of the loan, only interest-only payments will be expected. Thus
in the same example, the first 3 payments will have no principal payment, significantly reducing the
payment amount. This needs to be asked for as an input – whether the loan is a regular one or has the
interest-only duration.

---

## Problem Description

---

calculator that will help them see the amortization tables given a requested loan amount, interest rate,
term (duration in months) and a request date. Here are some guidelines they have put down:

- Interest is compounded daily.
- The interest amount that accumulates in a particular month is included in the monthly payment
  for that month.
- All monthly payments will be of the same amount.
- All loans are issued on the first of the next month from the requested date.
- Consider a year has 12 months of exactly 30 days each.

The task is to build a system to output a regular schedule that always starts on the first of the
month, displaying:

- the beginning balance at the start of the month
- the principal component of the monthly payment
- the interest component of the monthly payment
- the ending balance assuming the correct payment is made
- the monthly payment itself

---

## Built With

- Ruby

## Getting Started

To get a local copy up and running follow these simple example steps.

```bash
git clode git@github.com:shshamim63/amortization_calculator.git
cd amortization_calculator
```

### Prerequisites

Should have ruby installed

### Setup

```
bundle install
yarn install
rails db:setup
```

### Usage

```
rails s
```

## Authors

👤 **Author1**

- GitHub: [@shshamim63](https://github.com/shshamim63)
- LinkedIn: [LinkedIn](https://www.linkedin.com/in/shakhawathossainshamim/)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Hat tip to anyone whose code was used
- Inspiration
- etc

## 📝 License

This project is [MIT](lic.url) licensed.
