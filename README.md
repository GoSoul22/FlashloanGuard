# FlashloanGuard

A pattern emerges from our analysis in flash loan attacks.


It is usually the case that attackers will borrow hundreds of millions of dollars from decentralized exchanges or lending platforms; Then, they will deposit the funds on a target contract, perform attacks, withdraw the funds, repay the original loan and pocket profits.

Let’s take the FEG flashloan exploit as an example. The attacker borrowed 915.84 BNB from PancakeSwap, deposited the funds into the FEGexPro contract, and repeatedly called the DepositeInternal() and SwapToSwap() function so that all attacker-controlled contracts got 114.598 fBNB allowances, withdrew all the funds from the FEGexPro contract, repaid the original loan and kept profits. For a detailed explanation, check this post-mortem report.

How to mitigate this kind of attack?

What is the first principle of flash loan attacks? What are the elements that are non-reducible? The answer is that it must be repaid within one single transaction. The funds must be deposited to perform attacks.  The funds must be withdrawn to repay the loans.

The concept is simple. Prohibit deposits and withdrawals within one single transaction. When a fund is deposited into a smart contract, it stores the address that started the transaction and the current block number. When a fund is being withdrawn, it checks the address that sent the transaction against the stored address. If these two addresses match, the current block number must be strictly greater than the stored block number.


Acknowledgment

This method was supported by Dr. Dan She, who provided insight and expertise.
