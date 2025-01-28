# 📈 MATLAB Financial Pricers Portfolio

## Overview

This project is a **MATLAB-based portfolio of financial pricers** used to evaluate options, bonds, and derivatives using different pricing methodologies. The collection includes implementations of **Black-Scholes-Merton (BSM), Binomial Trees, Monte Carlo Simulation, and Bond Pricing Models**.

### Key Technologies:

- **📊 MATLAB** – Primary tool for numerical computing and financial modeling
- **⚖️ Financial Derivatives** – Options, bonds, and structured products pricing
- **📈 Computational Finance** – Numerical methods for pricing and risk analysis

## Features

- ✅ **Black-Scholes-Merton Model (BSM)** – Pricing vanilla European options & implied volatility calculations
- ✅ **Binomial Pricing Model** – American/European options with discrete-time tree models
- ✅ **Monte Carlo Simulation** – Estimating option prices with randomized paths
- ✅ **Bond Pricing Models** – Valuing coupon bonds using discounting methods
- ✅ **Interest Rate Conversions** – Discrete to continuous compounding transformations

---

## 📁 Project Structure

### 1️⃣ **Black-Scholes-Merton (BSM) Pricers**

- **📝 `bsmpricer.m`** – Vanilla European option pricer using the Black-Scholes-Merton model
- **📝 `bsm_ivol.m`** – Computes implied volatility from observed market prices
- **📝 `binary_bsmpricer.m`** – Prices binary options using the BSM framework

### 2️⃣ **Binomial Tree Pricers**

- **📝 `binomial_pricer.m`** – Prices American/European options using a binomial tree approach

### 3️⃣ **Monte Carlo Simulations**

- **📝 `montecarlo_pricer_vanilla.m`** – Simulates stock price movements to estimate option prices

### 4️⃣ **Bond Pricing Models**

- **📝 `bondpricer.m`** – Prices coupon bonds using present value of cash flows
- **📝 `bondpricer1.m`** – Alternative bond pricer with a different cash flow timeline structure
- **📝 `dis2cont.m`** – Converts discrete interest rates into continuously compounded rates

---

## 🛠️ How It Works

- 1️⃣ **Run MATLAB Scripts**: Execute the `.m` files in MATLAB to calculate prices based on user-defined parameters.
- 2️⃣ **Input Financial Data**: Define stock prices, interest rates, volatility, and option parameters.
- 3️⃣ **Compute Prices & Sensitivities**: Get outputs including option prices, implied volatility, and bond valuations.
- 4️⃣ **Adjust Parameters**: Modify input values to see how different variables affect pricing outcomes.

---

## 🚀 Future Improvements

- 🔹 **Incorporate Stochastic Volatility Models** – Enhance realism for options pricing
- 🔹 **Add Greek Calculations** – Compute Delta, Gamma, Vega, and Theta for risk management
- 🔹 **Optimize Performance** – Improve computational efficiency for large datasets

---

## 📩 Contact

For questions or collaboration, feel free to reach out! 🚀
