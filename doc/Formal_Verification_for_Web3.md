---
marp: true
theme: default
paginate: true
math: mathjax
style: |
  section {
    font-size: 26px;
  }
  h1 {
    color: #2d3436;
  }
  h2 {
    color: #0984e3;
  }
  code {
    font-size: 20px;
  }
  .columns {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 1rem;
  }
  .small {
    font-size: 18px;
  }
  .exercise {
    background: #ffeaa7;
    padding: 0.8rem;
    border-radius: 8px;
    border-left: 4px solid #fdcb6e;
  }
  .key-point {
    background: #dfe6e9;
    padding: 0.8rem;
    border-radius: 8px;
    border-left: 4px solid #0984e3;
  }
  .ref {
    font-size: 14px;
    color: #636e72;
  }
  a {
    font-size: 18px;
  }
---

# Formal Verification for Web3

**Web3 Experts Brazil**

Christiano Braga &mdash; Universidade Federal Fluminense
Semar Augusto Martins &mdash; Beneficial AI Foundation

---

# About This Workshop

**Duration:** 90 minutes

**Part 1** &mdash; Lean 4: Foundations and Tactics (~45 min)
- Propositions, types, tactics
- Interactive exercises

**Part 2** &mdash; Cryptographic Protocols in Lean 4 (~45 min)
- Deterministic algebraic model
- One-Time Pad, RSA, Diffie-Hellman
- Interactive exercises

---

<!-- _class: lead -->

# Motivation

## The AI Revolution in Software Development

---

# AI Is Writing Our Code

- GitHub Copilot: **46% of code** is now AI-generated, up from 27% at launch in 2022
- **15 million developers** using Copilot &mdash; 400% growth in one year
- AI agents writing entire modules, tests, deployments
- Smart contracts worth billions deployed with AI assistance

> "Move fast and break things" is not acceptable when the thing is a $600M bridge contract.

<div class="ref">

GitHub, "[Octoverse 2024](https://github.blog/news-insights/octoverse/octoverse-2024/)." See also GitClear, "[Coding on Copilot](https://www.gitclear.com/coding_on_copilot_data_shows_ais_downward_pressure_on_code_quality)," 2024.

</div>

---

# The Fundamental Problem

**AI is powerful but not trustworthy by default.**

- LLMs hallucinate &mdash; confidently and fluently
- Code "looks right" but may be subtly wrong
- Testing catches some bugs; formal verification catches **all** bugs in scope

### Who verifies the AI?

---

# AI Meets Web3

- **AI-assisted smart contract development:** Copilot, ChatGPT, and Claude generate Solidity, Move, and Rust contracts daily
- **AI-powered auditing:** tools like [Olympix](https://www.olympix.ai/) and [Cyfrin](https://www.cyfrin.io/) use AI to scan for vulnerabilities
- **The paradox:** AI finds bugs *and* introduces bugs

**Real-world impact:**
- Wormhole bridge hack ($320M, 2022) &mdash; bypassed signature verification
- Euler Finance ($197M, 2023) &mdash; missing health check in donation function
- Could AI have caught these? Could AI have *caused* them?

> Formal verification is the missing layer: it does not matter who writes the code &mdash; human or AI &mdash; the proof must be machine-checked.

<div class="ref">

Halborn, "[Explained: The Wormhole Hack](https://www.halborn.com/blog/post/explained-the-wormhole-hack-february-2022)," 2022.
Cyfrin, "[Euler Finance Hack Analysis](https://www.cyfrin.io/blog/how-did-the-euler-finance-hack-happen-hack-analysis)," 2023.

</div>

---

# Max Tegmark

**MIT Physics, Founder of Beneficial AI Foundation (BAIF)**

- Author of *Life 3.0: Being Human in the Age of Artificial Intelligence* (2017)
- Co-author of "Provably Safe Systems: The Only Path to Controllable AGI" (2023)
- Co-author of "Towards Guaranteed Safe AI" (2024) &mdash; a framework requiring AI systems to provide **mathematical proofs of safety** before each action

> "If we build AI systems that are provably safe, we can verify compliance even for superintelligent AI."

<div class="ref">

Tegmark, M. and Omohundro, S., "[Provably safe systems: the only path to controllable AGI](https://arxiv.org/abs/2309.01933)," arXiv:2309.01933, 2023.
Dalrymple, D. et al., "[Towards Guaranteed Safe AI](https://arxiv.org/abs/2405.06624)," arXiv:2405.06624, 2024.

</div>

---

# Leonardo de Moura

**AWS / Lean FRO, Creator of Lean and Z3**

- Built Lean to scale formal mathematics and software verification
- Z3: the world's most widely used SMT solver
- 2025 ACM SIGPLAN Programming Languages Software Award (for Lean)

> "As AI writes most of the world's software, formal mathematical verification &mdash; not traditional testing &mdash; will become essential. Verification proves software behaves correctly for **all possible inputs**."

<div class="ref">

De Moura, L. and Ullrich, S., "[The Lean 4 Theorem Prover and Programming Language](https://lean-lang.org/papers/lean4.pdf)," CADE-28, 2021.
[ACM SIGPLAN Programming Languages Software Award, 2025](https://www.sigplan.org/Awards/Software/).

</div>

---

# Shaowei Lin

**Chief Scientist, Beneficial AI Foundation (BAIF)**

- Mathematician working on statistical learning theory, spiking neural networks, and dependent type theories for machine reasoning
- Lead author of the **Vericoding Benchmark**: 12,504 formal specifications (7,141 in Lean, 3,029 in Dafny, 2,334 in Verus/Rust) for testing LLM-generated verified code
- Collaborates with Atlas Computing and Topos Institute on AI-assisted formal verification at scale

> Advocates "correct-by-construction" code generation rather than token-by-token synthesis.

<div class="ref">

Bursuc, S. et al., "[A benchmark for vericoding: formally verified program synthesis](https://arxiv.org/abs/2509.22908)," arXiv:2509.22908, 2025.

</div>

---

# Why Formal Verification for Web3?

| Property | Testing | Formal Verification |
|---|---|---|
| Coverage | Sampled inputs | **All** possible inputs |
| Guarantees | Probabilistic | **Mathematical proof** |
| Smart contract bugs | Catches some | Proves absence |
| Cost of failure | High | **Prevented** |

**Web3 is adversarial by design.** Every smart contract is an open invitation to exploit.

<div class="ref">

Runtime Verification, "[Formal Verification 101 for Blockchain Systems and Smart Contracts](https://runtimeverification.com/blog/formal-verification-101-for-blockchain-systems-and-smart-contracts)," 2020.

</div>

---

# The Lean 4 Ecosystem

- **Lean 4** &mdash; programming language + theorem prover (de Moura & Ullrich, AWS/Lean FRO)
- **Mathlib** &mdash; massive mathematical library (300k+ theorems)
- General-purpose functional programming language
- Compiles to C &mdash; production-ready performance

<div class="ref">

Lean: https://lean-lang.org/ &mdash; Mathlib: https://leanprover-community.github.io/
The mathlib Community, "[The Lean Mathematical Library](https://dl.acm.org/doi/10.1145/3372885.3373824)," CPP 2020.

</div>

---

<!-- _class: lead -->

# Part 1

## Lean 4: Foundations and Tactics

---

# Logic Refresher: Connectives

A **proposition** is a statement that is either true or false. We build complex propositions from simpler ones:

| Symbol | Name | Read as | True when |
|---|---|---|---|
| $P \land Q$ | Conjunction | "P and Q" | Both P and Q hold |
| $P \lor Q$ | Disjunction | "P or Q" | At least one holds |
| $P \to Q$ | Implication | "P implies Q" | If P then Q |
| $\lnot P$ | Negation | "not P" | P does not hold |

**Modus ponens:** from $P$ and $P \to Q$, conclude $Q$.
**Proof by cases:** to prove $P \lor Q \to R$, prove $P \to R$ and $Q \to R$ separately.

---

# Logic Refresher: Quantifiers and Equality

**Quantifiers** let us talk about *all* or *some* elements of a type:

| Symbol | Name | Read as | Example |
|---|---|---|---|
| $\forall x, P(x)$ | Universal | "for all x, P(x)" | $\forall n \in \mathbb{N},\; n + 0 = n$ |
| $\exists x, P(x)$ | Existential | "there exists x such that P(x)" | $\exists n \in \mathbb{N},\; n > 5$ |

**Equality** ($=$) is the most common relation:
- **Reflexivity:** $a = a$
- **Symmetry:** if $a = b$ then $b = a$
- **Transitivity:** if $a = b$ and $b = c$ then $a = c$
- **Substitution:** if $a = b$ then $f(a) = f(b)$

These are exactly the reasoning principles that Lean's tactics automate.

---

# What Is Lean 4?

A **dependently-typed** functional programming language that doubles as an interactive theorem prover.

```lean
-- A program
def double (n : Nat) : Nat := 2 * n

-- A theorem
theorem double_is_add_self (n : Nat) : double n = n + n := by
  unfold double
  omega
```

Key idea: **propositions are types, proofs are programs** (Curry-Howard correspondence).

[Try in Lean 4 Web](https://live.lean-lang.org/#code=--%20A%20program%0Adef%20double%20%28n%20%3A%20Nat%29%20%3A%20Nat%20%3A%3D%202%20%2A%20n%0A%0A--%20A%20theorem%0Atheorem%20double_is_add_self%20%28n%20%3A%20Nat%29%20%3A%20double%20n%20%3D%20n%20%2B%20n%20%3A%3D%20by%0A%20%20unfold%20double%0A%20%20omega)

---

# Anatomy of a Lean Proof

```lean
theorem succ_pos (n : Nat) : 0 < n + 1 := by
--       ^name     ^params   ^statement      ^tactic block
  exact Nat.succ_pos n
--^tactic (one step of the proof)
```

| Keyword | Meaning |
|---|---|
| `def` | Define a function or value |
| `theorem` / `lemma` | State and prove a proposition |
| `: T` | Type annotation &mdash; "this has type T" |
| `:= by` | "prove this using tactics" (enters tactic mode) |
| `sorry` | Placeholder &mdash; admits the goal without proof (marks it with a warning) |
| `#check` / `#eval` | Inspect a type / evaluate an expression |

---

# Propositions as Types

| Logic | Lean Type |
|---|---|
| $P \land Q$ | `P × Q` (product) |
| $P \lor Q$ | `P ⊕ Q` (sum) |
| $P \to Q$ | `P → Q` (function) |
| $\forall x, P(x)$ | `(x : α) → P x` |
| $\exists x, P(x)$ | `⟨x, proof⟩` (Sigma type) |
| True | `True` (unit) |
| False | `False` (empty) |

<div class="ref">

Howard, W., "[The formulae-as-types notion of construction](https://www.cs.cmu.edu/~crary/819-f09/Howard80.pdf)," 1969/1980. See also: de Bruijn, N., "AUTOMATH," 1968.

</div>

---

# Basic Types and Terms

```lean
#check (42 : Nat)              -- a natural number
#check Nat.succ 3              -- 4 (successor)
def add_one (n : Nat) : Nat := n + 1
#eval add_one 41               -- 42
#check (2 + 2 = 4 : Prop)     -- a proposition
#check (∀ n : Nat, n + 0 = n) -- also a proposition
```

Types and propositions live in the same world: `Nat` is a type of data, `2 + 2 = 4` is a type of evidence (a `Prop`). A `theorem` is a function that produces evidence.

[Try in Lean 4 Web](https://live.lean-lang.org/#code=%23check%20%2842%20%3A%20Nat%29%0A%23check%20Nat.succ%203%0Adef%20add_one%20%28n%20%3A%20Nat%29%20%3A%20Nat%20%3A%3D%20n%20%2B%201%0A%23eval%20add_one%2041%0A%23check%20%282%20%2B%202%20%3D%204%20%3A%20Prop%29%0A%23check%20%28%E2%88%80%20n%20%3A%20Nat%2C%20n%20%2B%200%20%3D%20n%29)

---

# Structures and Notation

A `structure` bundles named fields (used heavily in Part 2 for crypto parameters):

```lean
structure Point where     -- like a record / named tuple
  x : Nat
  y : Nat

abbrev MyType := Nat      -- type alias (abbrev is transparent)
```

**Key notation** used throughout this workshop:

| Syntax | Meaning |
|---|---|
| `⟨a, b⟩` | Anonymous constructor &mdash; build a struct or existential witness |
| `h.1` / `h.2` | First / second projection (e.g., left / right of `∧`) |
| `x.field` | Structure field access: `params.e`, `m.val` |
| `· + ·` | Anonymous function: `fun a b => a + b` |
| `let x := e` | Local definition inside a proof or program |
| `tac1; tac2` | Tactic chaining &mdash; run `tac1` then `tac2` on same line |
| `_` in `calc` | Stands for the previous expression in a `calc` chain |

---

# What Are Tactics?

A **tactic** is a command that transforms the current proof goal into simpler subgoals, until none remain.

```lean
theorem example_proof (P Q : Prop) (hp : P) (hpq : P → Q) : Q := by
  -- Goal: Q
  exact hpq hp
  -- No goals remain ✓
```

**Why tactics?** Writing proof terms directly (like `hpq hp`) is possible but quickly becomes unreadable for complex proofs. Tactics let us build proofs **step by step**, the way a mathematician would reason on a whiteboard.

For example, `fun h => ⟨h.2, h.1⟩` is a valid term-mode proof, but the tactic version `intro h; exact ⟨h.2, h.1⟩` lets us inspect the goal at each step.

---

# Tactic: `rfl`

**When?** Verifying that two expressions compute to the same value &mdash; e.g., checking a hash function output or a contract's arithmetic.

`rfl` proves goals of the form `a = a` after Lean reduces both sides.

```lean
theorem two_plus_two : 2 + 2 = 4 := by
  rfl

theorem bool_and_true : true && true = true := by
  rfl
```

Lean reduces `2+2` to `4`, then sees `4 = 4`.

[Try in Lean 4 Web](https://live.lean-lang.org/#code=--%20Lean%20can%20compute%20both%20sides%20and%20see%20they%27re%20equal%0Atheorem%20two_plus_two%20%3A%202%20%2B%202%20%3D%204%20%3A%3D%20by%0A%20%20rfl%0A%0Atheorem%20bool_and_true%20%3A%20true%20%26%26%20true%20%3D%20true%20%3A%3D%20by%0A%20%20rfl)

---

# Tactic: `intro`

**When?** Your goal starts with $\forall$ or $\to$. Like saying "let `n` be an arbitrary natural number" or "assume `P` holds."

```lean
theorem identity_eq : ∀ (n : Nat), n = n := by
  intro n   -- now n : Nat is in context, goal is n = n
  rfl

theorem imp_self (P : Prop) : P → P := by
  intro h   -- assume P holds as hypothesis h
  exact h
```

[Try in Lean 4 Web](https://live.lean-lang.org/#code=theorem%20identity_eq%20%3A%20%E2%88%80%20%28n%20%3A%20Nat%29%2C%20n%20%3D%20n%20%3A%3D%20by%0A%20%20intro%20n%0A%20%20rfl%0A%0Atheorem%20imp_self%20%28P%20%3A%20Prop%29%20%3A%20P%20%E2%86%92%20P%20%3A%3D%20by%0A%20%20intro%20h%0A%20%20exact%20h)

---

# Tactic: `exact` and `assumption`

**When?** You have exactly the proof you need in the context. Like citing a known fact to close an argument.

```lean
-- exact: provide the precise proof term
theorem and_intro (P Q : Prop) (hp : P) (hq : Q) : P ∧ Q := by
  exact ⟨hp, hq⟩

-- assumption: let Lean search the context for you
theorem trivial_imp (P : Prop) (h : P) : P := by
  assumption
```

[Try in Lean 4 Web](https://live.lean-lang.org/#code=--%20exact%20provides%20the%20exact%20proof%20term%0Atheorem%20and_intro%20%28P%20Q%20%3A%20Prop%29%20%28hp%20%3A%20P%29%20%28hq%20%3A%20Q%29%20%3A%20P%20%E2%88%A7%20Q%20%3A%3D%20by%0A%20%20exact%20%E2%9F%A8hp%2C%20hq%E2%9F%A9%0A%0A--%20assumption%20searches%20the%20context%20for%20a%20matching%20hypothesis%0Atheorem%20trivial_imp%20%28P%20%3A%20Prop%29%20%28h%20%3A%20P%29%20%3A%20P%20%3A%3D%20by%0A%20%20assumption)

---

# Tactic: `simp`

**When?** The goal involves known simplification rules &mdash; like `x + 0 = x`, `l ++ [] = l`. The workhorse tactic that automates routine rewriting.

```lean
theorem list_append_nil (l : List α) : l ++ [] = l := by
  simp

theorem arith_example (n : Nat) : n + 0 + 0 = n := by
  simp
```

You can supply extra lemmas: `simp [my_lemma]`.

[Try in Lean 4 Web](https://live.lean-lang.org/#code=theorem%20list_append_nil%20%28l%20%3A%20List%20%CE%B1%29%20%3A%20l%20%2B%2B%20%5B%5D%20%3D%20l%20%3A%3D%20by%0A%20%20simp%0A%0Atheorem%20arith_example%20%28n%20%3A%20Nat%29%20%3A%20n%20%2B%200%20%2B%200%20%3D%20n%20%3A%3D%20by%0A%20%20simp)

---

# Tactic: `omega`

**When?** The goal is a linear arithmetic statement over `Nat` or `Int` &mdash; e.g., proving bounds, fee calculations, or index validity.

```lean
theorem omega_demo1 (n : Nat) : n + 1 > n := by
  omega

theorem omega_demo2 (a b : Nat) (h : a ≤ b) :
    a + 1 ≤ b + 1 := by
  omega
```

Decides all true linear arithmetic goals automatically.

[Try in Lean 4 Web](https://live.lean-lang.org/#code=theorem%20omega_demo1%20%28n%20%3A%20Nat%29%20%3A%20n%20%2B%201%20%3E%20n%20%3A%3D%20by%0A%20%20omega%0A%0Atheorem%20omega_demo2%20%28a%20b%20%3A%20Nat%29%20%28h%20%3A%20a%20%E2%89%A4%20b%29%20%3A%20a%20%2B%201%20%E2%89%A4%20b%20%2B%201%20%3A%3D%20by%0A%20%20omega)

---

# Tactic: `ring`

**When?** Proving polynomial or algebraic equalities &mdash; e.g., verifying that a fee formula distributes correctly or that a cryptographic identity holds.

```lean
import Mathlib.Tactic.Ring  -- ring requires Mathlib

theorem ring_demo1 (a b : Nat) :
    (a + b) * (a + b) = a*a + 2*a*b + b*b := by
  ring

theorem ring_demo2 (x : Int) :
    (x + 1) * (x - 1) = x^2 - 1 := by
  ring
```

*Requires Mathlib &mdash; `ring`, `ring_nf`, and `linarith` are Mathlib tactics, not built into core Lean 4.*

---

# Tactic: `have` and `calc`

**When?** A proof needs intermediate steps &mdash; like showing `a = b` then `b = c` to conclude `a = c`. Essential for readable, auditable proofs.

```lean
theorem have_demo (a b c : Nat)
    (h1 : a = b) (h2 : b = c) : a = c := by
  have h3 : a = c := by
    calc a = b := h1
         _ = c := h2
  exact h3
```

`calc` chains are great for step-by-step equational reasoning.

[Try in Lean 4 Web](https://live.lean-lang.org/#code=theorem%20have_demo%20%28a%20b%20c%20%3A%20Nat%29%20%28h1%20%3A%20a%20%3D%20b%29%20%28h2%20%3A%20b%20%3D%20c%29%20%3A%20a%20%3D%20c%20%3A%3D%20by%0A%20%20have%20h3%20%3A%20a%20%3D%20c%20%3A%3D%20by%0A%20%20%20%20calc%20a%20%3D%20b%20%3A%3D%20h1%0A%20%20%20%20%20%20%20%20%20_%20%3D%20c%20%3A%3D%20h2%0A%20%20exact%20h3)

---

# Tactics: `unfold`, `rw`, `ext`

These appear frequently in Part 2's cryptographic proofs:

| Tactic | Purpose | Example use |
|---|---|---|
| `unfold f` | Expand definition `f` in the goal | `unfold otp_encrypt` |
| `rw [h]` | Rewrite using `h : a = b` (left to right) | `rw [pow_mul]` |
| `rw [← h]` | Rewrite in reverse direction | `rw [← add_assoc]` |
| `ext i` | Prove equality component-wise | Two `Vector`s equal element-wise |

---

# Tactic: `decide`

**When?** The goal is a proposition over a **finite** type that Lean can check by trying all cases. Lean enumerates every possibility and verifies the statement holds for each one.

```lean
-- Fin 2 has only two elements: 0 and 1
-- Lean checks both: 0+0=0 ✓, 1+1=0 ✓
theorem fin2_self_add : ∀ (a : Fin 2), a + a = 0 := by
  decide

-- Works for any decidable proposition over finite types
theorem bool_demorgan : ∀ (a b : Bool),
    (!(a && b)) = (!a || !b) := by
  decide   -- checks all 4 combinations of true/false
```

Note: `decide` requires **closed** propositions (no free variables). Use `∀` to quantify.

[Try in Lean 4 Web](https://live.lean-lang.org/#code=--%20Fin%202%20has%20only%20two%20elements%3A%200%20and%201%0Atheorem%20fin2_self_add%20%3A%20%E2%88%80%20%28a%20%3A%20Fin%202%29%2C%20a%20%2B%20a%20%3D%200%20%3A%3D%20by%0A%20%20decide%0A%0Atheorem%20bool_demorgan%20%3A%20%E2%88%80%20%28a%20b%20%3A%20Bool%29%2C%0A%20%20%20%20%28%21%28a%20%26%26%20b%29%29%20%3D%20%28%21a%20%7C%7C%20%21b%29%20%3A%3D%20by%0A%20%20decide)

---

# Tactic Summary

<div class="small">

| Tactic | Purpose | Used in |
|---|---|---|
| `rfl` | Prove `a = a` (definitional equality) | Warm-up |
| `intro` / `exact` | Move quantifiers into context / provide proof term | Warm-up |
| `simp` | Simplification with a lemma database | OTP, DH |
| `omega` | Decide linear arithmetic ($\mathbb{N}$, $\mathbb{Z}$) | RSA |
| `ring` / `ring_nf` | Prove ring equalities / normalize | OTP, RSA, DH |
| `have` / `calc` | Introduce intermediate steps | OTP |
| `unfold` | Expand a definition in the goal | OTP, RSA |
| `rw` / `rw [←]` | Rewrite with an equality | RSA, DH |
| `ext` | Prove equality component-wise | OTP |
| `decide` | Brute-force decidable propositions | OTP |

</div>

---

# Exercise 1: Logic Warmup

<div class="exercise">

```lean
-- 1a. Commutativity of ∧
theorem and_comm_ex (P Q : Prop) : P ∧ Q → Q ∧ P := by
  sorry

-- 1b. Transitivity of implication
theorem imp_trans (P Q R : Prop) :
    (P → Q) → (Q → R) → P → R := by
  sorry

-- 1c. A simple arithmetic fact
theorem exercise_arith (n : Nat) : n + n = 2 * n := by
  sorry
```

**Hint:** For 1a, use `intro h` then `exact ⟨h.2, h.1⟩`

</div>

[Try in Lean 4 Web](https://live.lean-lang.org/#code=--%201a.%20Commutativity%20of%20%E2%88%A7%0Atheorem%20and_comm_ex%20%28P%20Q%20%3A%20Prop%29%20%3A%20P%20%E2%88%A7%20Q%20%E2%86%92%20Q%20%E2%88%A7%20P%20%3A%3D%20by%0A%20%20sorry%0A%0A--%201b.%20Transitivity%20of%20implication%0Atheorem%20imp_trans%20%28P%20Q%20R%20%3A%20Prop%29%20%3A%20%28P%20%E2%86%92%20Q%29%20%E2%86%92%20%28Q%20%E2%86%92%20R%29%20%E2%86%92%20P%20%E2%86%92%20R%20%3A%3D%20by%0A%20%20sorry%0A%0A--%201c.%20A%20simple%20arithmetic%20fact%0Atheorem%20exercise_arith%20%28n%20%3A%20Nat%29%20%3A%20n%20%2B%20n%20%3D%202%20%2A%20n%20%3A%3D%20by%0A%20%20sorry)

---

# Solution 1

```lean
-- 1a
theorem and_comm_ex (P Q : Prop) : P ∧ Q → Q ∧ P := by
  intro h
  exact ⟨h.2, h.1⟩

-- 1b
theorem imp_trans (P Q R : Prop) :
    (P → Q) → (Q → R) → P → R := by
  intro hpq hqr hp
  exact hqr (hpq hp)

-- 1c
theorem exercise_arith (n : Nat) : n + n = 2 * n := by
  omega
```

[Try in Lean 4 Web](https://live.lean-lang.org/#code=--%201a%0Atheorem%20and_comm_ex%20%28P%20Q%20%3A%20Prop%29%20%3A%20P%20%E2%88%A7%20Q%20%E2%86%92%20Q%20%E2%88%A7%20P%20%3A%3D%20by%0A%20%20intro%20h%0A%20%20exact%20%E2%9F%A8h.2%2C%20h.1%E2%9F%A9%0A%0A--%201b%0Atheorem%20imp_trans%20%28P%20Q%20R%20%3A%20Prop%29%20%3A%20%28P%20%E2%86%92%20Q%29%20%E2%86%92%20%28Q%20%E2%86%92%20R%29%20%E2%86%92%20P%20%E2%86%92%20R%20%3A%3D%20by%0A%20%20intro%20hpq%20hqr%20hp%0A%20%20exact%20hqr%20%28hpq%20hp%29%0A%0A--%201c%0Atheorem%20exercise_arith%20%28n%20%3A%20Nat%29%20%3A%20n%20%2B%20n%20%3D%202%20%2A%20n%20%3A%3D%20by%0A%20%20omega)

---

<!-- _class: lead -->

# Part 2

## Cryptographic Protocols in Lean 4

---

# Mathematics refresher

--- 

## Modular Arithmetic

**Integers modulo $n$** ($\mathbb{Z}_n$ or `ZMod n` in Lean/Mathlib): the set $\{0, 1, \ldots, n{-}1\}$ with wrap-around arithmetic.

| Operation | Definition | Example ($\mathbb{Z}_5$) |
|---|---|---|
| $a + b \bmod n$ | Addition mod $n$ | $3 + 4 = 2$ |
| $a \cdot b \bmod n$ | Multiplication mod $n$ | $3 \cdot 4 = 2$ |
| $a^k \bmod n$ | Exponentiation mod $n$ | $2^3 = 3$ |

**Key special case &mdash; $\mathbb{Z}_2$:**
- Only two elements: $0$ and $1$
- Addition mod 2 **is** XOR: $1 + 1 = 0$, $0 + 1 = 1$
- Used in One-Time Pad

---

## Number Theory for Cryptography

**Euler's totient** $\phi(n)$: count of integers in $\{1, \ldots, n\}$ coprime to $n$.
- For primes: $\phi(p) = p - 1$
- For $n = p \cdot q$ (distinct primes): $\phi(n) = (p{-}1)(q{-}1)$

**Euler's theorem:** If $\gcd(m, n) = 1$, then $m^{\phi(n)} \equiv 1 \pmod{n}$

**Consequence for RSA:** If $e \cdot d \equiv 1 \pmod{\phi(n)}$, then:
$$m^{e \cdot d} = m^{1 + k\phi(n)} = m \cdot (m^{\phi(n)})^k \equiv m \pmod{n}$$

**Commutativity of exponents:** $(g^a)^b = g^{ab} = g^{ba} = (g^b)^a$ &mdash; the basis of Diffie-Hellman.

---

# The Deterministic Cryptographic Model

We use a **deterministic algebraic model** of cryptography:

- No probability distributions or computational complexity
- Security properties are stated as **algebraic equalities**
- Focus on **correctness**: decryption inverts encryption
- Focus on **structural properties**: commutativity, key independence

**Not modeled:** computational hardness, random oracles, adversarial games.

<div class="ref">

For computational models see: Blanchet, B., "[A Computationally Sound Mechanized Prover for Security Protocols](https://bblanche.gitlabpages.inria.fr/CryptoVerif/)," IEEE TDSC, 2008; Barthe, G. et al., "[Computer-Aided Security Proofs for the Working Cryptographer](https://link.springer.com/chapter/10.1007/978-3-642-22792-9_5)," CRYPTO, 2011.

</div>

---

# Protocol 1: One-Time Pad (XOR Cipher)

**Idea:** Encrypt by XOR-ing plaintext with a key of equal length.

$$c = m \oplus k \qquad\qquad m = c \oplus k$$

**Perfect secrecy:** With a truly random key used once, the ciphertext reveals nothing about the plaintext.

**What we'll prove:**
1. Correctness: decryption recovers the plaintext
2. XOR algebraic properties (involution, commutativity)

<div class="ref">

Shannon, C.E., "[Communication Theory of Secrecy Systems](https://ieeexplore.ieee.org/document/6769090)," Bell System Technical Journal, 1949.

</div>

---

# OTP in Lean 4: Definitions

```lean
import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Vector.Basic

-- We model bits as ZMod 2 (integers mod 2)
-- XOR is simply addition in ZMod 2
abbrev Bit := ZMod 2

def otp_encrypt (key msg : Vector Bit n) : Vector Bit n :=
  Vector.zipWith (· + ·) key msg

def otp_decrypt (key cipher : Vector Bit n) : Vector Bit n :=
  Vector.zipWith (· + ·) key cipher
```

*Requires Mathlib &mdash; [set up locally](https://leanprover-community.github.io/get_started.html) or use [Gitpod](https://gitpod.io/#/https://github.com/leanprover-community/mathlib4).*

---

# OTP: Correctness Proof

```lean
-- Key property of ZMod 2: a + a = 0
theorem zmod2_self_add : ∀ (a : ZMod 2), a + a = 0 := by
  decide

-- Correctness: decrypt(key, encrypt(key, msg)) = msg
theorem otp_correct (key msg : Vector Bit n) :
    otp_decrypt key (otp_encrypt key msg) = msg := by
  unfold otp_encrypt otp_decrypt
  ext i
  simp [Vector.zipWith]
  -- Goal: key[i] + (key[i] + msg[i]) = msg[i]
  -- By associativity: (key[i] + key[i]) + msg[i]
  -- By self-inverse:  0 + msg[i] = msg[i]
  rw [← add_assoc, zmod2_self_add, zero_add]
```

*Requires Mathlib &mdash; [set up locally](https://leanprover-community.github.io/get_started.html).*

---

# OTP: Key Properties

```lean
-- Encryption is its own inverse (involutory)
theorem otp_involutory (key msg : Vector Bit n) :
    otp_encrypt key (otp_encrypt key msg) = msg :=
  otp_correct key msg  -- encrypt and decrypt are the same!

-- Encryption is commutative in key and message
theorem otp_comm (a b : Vector Bit n) :
    otp_encrypt a b = otp_encrypt b a := by
  unfold otp_encrypt; ext i
  simp [Vector.zipWith]; ring
```

*Requires Mathlib &mdash; [set up locally](https://leanprover-community.github.io/get_started.html).*

---

# Exercise 3: OTP Properties

<div class="exercise">

```lean
-- 3a. Encrypting with the zero key is identity
theorem otp_zero_key (msg : Vector Bit n) :
    otp_encrypt (Vector.replicate n (0 : Bit)) msg
    = msg := by
  sorry

-- 3b. Encrypting a message with itself yields zeros
theorem otp_self_encrypt (msg : Vector Bit n) :
    otp_encrypt msg msg
    = Vector.replicate n (0 : Bit) := by
  sorry
```

**Hint:** `unfold`, `ext i`, `simp`, and `zmod2_self_add`.

</div>

---

# Solution 3

```lean
-- 3a
theorem otp_zero_key (msg : Vector Bit n) :
    otp_encrypt (Vector.replicate n (0 : Bit)) msg
    = msg := by
  unfold otp_encrypt; ext i
  simp [Vector.zipWith, Vector.replicate]

-- 3b
theorem otp_self_encrypt (msg : Vector Bit n) :
    otp_encrypt msg msg
    = Vector.replicate n (0 : Bit) := by
  unfold otp_encrypt; ext i
  simp [Vector.zipWith]
  exact zmod2_self_add (msg.get i)
```

*Requires Mathlib &mdash; [set up locally](https://leanprover-community.github.io/get_started.html).*

---

# Protocol 2: RSA

**Setup:**
- Choose primes $p$, $q$; compute $n = p \cdot q$
- Choose $e$ coprime to $\phi(n) = (p-1)(q-1)$
- Compute $d = e^{-1} \mod \phi(n)$

**Operations:**
$$\text{Encrypt: } c = m^e \bmod n \qquad \text{Decrypt: } m = c^d \bmod n$$

**Correctness relies on Euler's theorem:** $m^{e \cdot d} \equiv m \pmod{n}$

<div class="ref">

Rivest, R., Shamir, A., Adleman, L., "[A Method for Obtaining Digital Signatures and Public-Key Cryptosystems](https://dl.acm.org/doi/10.1145/359340.359342)," CACM, 1978.

</div>

---

# RSA in Lean 4: Definitions

```lean
import Mathlib.Data.ZMod.Basic; import Mathlib.Data.Nat.Prime.Basic

structure RSAParams where
  p : Nat;  q : Nat
  hp : Nat.Prime p;  hq : Nat.Prime q;  hpq : p ≠ q
  e : Nat;  d : Nat;  he_pos : 0 < e
  n : Nat := p * q;  phi : Nat := (p - 1) * (q - 1)
  he : Nat.Coprime e phi;  hed : e * d % phi = 1

def rsa_encrypt (params : RSAParams) (m : ZMod params.n) :=
  m ^ params.e
def rsa_decrypt (params : RSAParams) (c : ZMod params.n) :=
  c ^ params.d
```

---

# RSA: Correctness Statement

```lean
theorem rsa_correct (params : RSAParams)
    (m : ZMod params.n)
    (hm : Nat.Coprime m.val params.n) :
    rsa_decrypt params (rsa_encrypt params m) = m := by
  unfold rsa_encrypt rsa_decrypt
  rw [← pow_mul]
  -- Goal: m ^ (e * d) = m  in ZMod n
  -- e * d ≡ 1 (mod φ(n)) → e * d = 1 + k * φ(n)
  -- By Euler: m ^ φ(n) ≡ 1 (mod n)
  -- So: m ^ (1 + k * φ(n)) = m * 1^k = m
  sorry -- requires Euler's theorem from Mathlib
```

The `sorry` is intentional &mdash; the full proof chains through `ZMod.pow_totient` in Mathlib.
Note: `hm` assumes $\gcd(m,n)=1$. The general case ($\forall m$) follows from CRT but requires a longer proof.

---

# RSA: Algebraic Properties

```lean
-- RSA is homomorphic: E(m1) * E(m2) = E(m1 * m2)
theorem rsa_homomorphic (params : RSAParams)
    (m1 m2 : ZMod params.n) :
    rsa_encrypt params m1 * rsa_encrypt params m2
    = rsa_encrypt params (m1 * m2) := by
  unfold rsa_encrypt; rw [← mul_pow]

-- Encrypt and decrypt commute
theorem rsa_commute (params : RSAParams)
    (m : ZMod params.n) :
    (m ^ params.e) ^ params.d
    = (m ^ params.d) ^ params.e := by
  rw [← pow_mul, ← pow_mul]; ring_nf
```

*Requires Mathlib &mdash; [set up locally](https://leanprover-community.github.io/get_started.html).*

---

# Exercise 4: RSA Properties

<div class="exercise">

```lean
-- 4a. Encrypting 1 always gives 1
theorem rsa_one (params : RSAParams) :
    rsa_encrypt params (1 : ZMod params.n) = 1 := by
  sorry

-- 4b. Encrypting 0 always gives 0
theorem rsa_zero (params : RSAParams) :
    rsa_encrypt params (0 : ZMod params.n) = 0 := by
  sorry
```

**Hint:** Unfold `rsa_encrypt` and use `one_pow` / `zero_pow`.

</div>

---

# Solution 4

```lean
-- 4a
theorem rsa_one (params : RSAParams) :
    rsa_encrypt params (1 : ZMod params.n) = 1 := by
  unfold rsa_encrypt
  exact one_pow params.e

-- 4b
theorem rsa_zero (params : RSAParams) :
    rsa_encrypt params (0 : ZMod params.n) = 0 := by
  unfold rsa_encrypt
  exact zero_pow params.he_pos.ne'
```

*Requires Mathlib &mdash; [set up locally](https://leanprover-community.github.io/get_started.html).*

---

# Protocol 3: Diffie-Hellman Key Exchange

**Setup:** Public prime $p$, generator $g$ of $\mathbb{Z}_p^*$

1. Alice chooses secret $a$, sends $A = g^a \bmod p$
2. Bob chooses secret $b$, sends $B = g^b \bmod p$
3. **Shared secret:** $s = B^a = A^b = g^{ab} \bmod p$

**Key property:** Both parties compute the same shared secret.

<div class="ref">

Diffie, W. and Hellman, M., "[New Directions in Cryptography](https://ieeexplore.ieee.org/document/1055638)," IEEE Trans. Info. Theory, 1976.

</div>

---

# DH in Lean 4: Definitions

```lean
import Mathlib.Data.ZMod.Basic

structure DHParams where
  p : Nat
  hp : Nat.Prime p
  g : ZMod p          -- generator (in ZMod p, not Z_p^*)

structure DHKeyPair (params : DHParams) where
  secret : Nat
  public_key : ZMod params.p := params.g ^ secret

def dh_shared_secret (params : DHParams)
    (my_secret : Nat) (their_public : ZMod params.p)
    : ZMod params.p :=
  their_public ^ my_secret
```

*Requires Mathlib &mdash; [set up locally](https://leanprover-community.github.io/get_started.html).*

---

# DH: Correctness Proof

```lean
-- Both sides compute the same shared secret
theorem dh_shared_secret_agree (params : DHParams)
    (a b : Nat) :
    let alice_pub := params.g ^ a
    let bob_pub   := params.g ^ b
    dh_shared_secret params a bob_pub =
    dh_shared_secret params b alice_pub := by
  simp [dh_shared_secret]
  -- Goal: (g ^ b) ^ a = (g ^ a) ^ b
  rw [← pow_mul, ← pow_mul]
  -- Goal: g ^ (b * a) = g ^ (a * b)
  ring_nf
```

The proof hinges on a single algebraic fact: multiplication of natural numbers is commutative ($b \cdot a = a \cdot b$), so $g^{ba} = g^{ab}$. This is why both parties end up with the same shared secret.

Note: We work in `ZMod p` (all residues mod $p$) rather than $\mathbb{Z}_p^*$ (the multiplicative group of units). This is a simplification &mdash; the real protocol requires $g$ to be a generator of $\mathbb{Z}_p^*$. However, the exponent identity $(g^b)^a = g^{ba}$ holds in any monoid, so our algebraic correctness proof is valid regardless.

---

# DH: Additional Properties

```lean
-- Extends to 3-party key agreement
theorem dh_three_party (params : DHParams) (a b c : Nat) :
    ((params.g ^ a) ^ b) ^ c
    = ((params.g ^ a) ^ c) ^ b := by
  rw [← pow_mul, ← pow_mul, ← pow_mul, ← pow_mul]
  ring_nf
```

```lean
-- Secret 0 gives trivial key (g^0 = 1)
theorem dh_zero_secret (params : DHParams)
    (their_pub : ZMod params.p) :
    dh_shared_secret params 0 their_pub = 1 := by
  simp [dh_shared_secret]
```

*Requires Mathlib &mdash; [set up locally](https://leanprover-community.github.io/get_started.html).*

---

# Exercise 5: Diffie-Hellman

<div class="exercise">

```lean
-- 5a. Shared secret with yourself: g^(a*a)
theorem dh_self (params : DHParams) (a : Nat) :
    dh_shared_secret params a (params.g ^ a)
    = params.g ^ (a * a) := by
  sorry

-- 5b. Composing exponentiations
theorem dh_compose (params : DHParams) (a b : Nat)
    (their_pub : ZMod params.p) :
    (their_pub ^ a) ^ b = their_pub ^ (a * b) := by
  sorry
```

**Hint:** Use `pow_mul` and `ring_nf`.

</div>

---

# Solution 5

```lean
-- 5a
theorem dh_self (params : DHParams) (a : Nat) :
    dh_shared_secret params a (params.g ^ a)
    = params.g ^ (a * a) := by
  simp [dh_shared_secret]
  rw [← pow_mul]

-- 5b
theorem dh_compose (params : DHParams) (a b : Nat)
    (their_pub : ZMod params.p) :
    (their_pub ^ a) ^ b = their_pub ^ (a * b) := by
  rw [← pow_mul]
```

*Requires Mathlib &mdash; [set up locally](https://leanprover-community.github.io/get_started.html).*

---

# Comparing the Three Protocols

| | OTP | RSA | Diffie-Hellman |
|---|---|---|---|
| **Type** | Symmetric | Asymmetric | Key Exchange |
| **Key idea** | XOR involution | Euler's theorem | Commutativity |
| **Proof core** | $a + a = 0$ in $\mathbb{Z}_2$ | $m^{ed} = m$ in $\mathbb{Z}_n$ | $g^{ab} = g^{ba}$ |
| **Tactic** | `ring`, `ext` | `pow_mul` | `pow_mul`, `ring_nf` |

---

# Beyond This Workshop

Our **deterministic model** is a deliberate starting point &mdash; it proves algebraic correctness cleanly and accessibly. A complete cryptographic treatment would also address:

- **Computational hardness** &mdash; factoring, discrete log assumptions
- **Probabilistic security** &mdash; IND-CPA, IND-CCA game-based definitions
- **Side channels** &mdash; timing, power analysis
- **Key management** &mdash; generation, distribution, revocation

These are active areas of formal verification research:
- **[CryptoVerif](https://bblanche.gitlabpages.inria.fr/CryptoVerif/)** (Blanchet, 2008) &mdash; computational model
- **[EasyCrypt](https://github.com/EasyCrypt/easycrypt)** (Barthe et al., 2011) &mdash; game-based proofs
- **Lean + Mathlib** &mdash; growing support for probability theory

---

# The Vision: Verified Web3 Stack

```
┌──────────────────────────────────────┐
│     Smart Contract (Solidity/Move)   │
├──────────────────────────────────────┤
│     Formal Spec (Lean 4)             │  ← We are here
├──────────────────────────────────────┤
│     Cryptographic Primitives         │  ← We proved these
├──────────────────────────────────────┤
│     Consensus Protocol               │
├──────────────────────────────────────┤
│     Network Layer                    │
└──────────────────────────────────────┘
```

Each layer can be formally verified. Lean 4 is the tool to do it.

---

# Lean Verification in Web3 Today

Projects already using Lean and formal methods for Web3 artifacts:

- **[Nethermind CertiPlonk](https://github.com/NethermindEth/CertiPlonk)** &mdash; extracts and formally verifies ZK circuit constraints from the Plonky3 zkDSL in Lean
- **[Nethermind Halo2 Verification](https://www.nethermind.io/blog/formal-verification-of-halo2-circuits-in-lean)** &mdash; formal verification of Halo2 ZK circuits in Lean
- **[INTMAX2 Financial Safety](https://www.nethermind.io/formal-verification)** &mdash; Nethermind verified the financial safety properties of the INTMAX2 stateless zkRollup in Lean
- **[CertiK zkWasm](https://github.com/CertiKProject/zkwasm-fv)** &mdash; first full formal verification of a zkVM (33k lines of Coq)
- **[ZKProof Verified Verifiers](https://zkproof.org/verifier/)** &mdash; community effort to formally verify ZK proof system verifiers

<div class="ref">

Nethermind, "[Formally Verifying Zero-Knowledge Circuits](https://www.nethermind.io/blog/formally-verifying-zero-knowledge-circuits-introducing-certiplonk)," 2025.

</div>

---

# Key Takeaways

1. **AI writes code; Lean verifies it.** The prover doesn't care who wrote the code &mdash; it only accepts mathematical proof.

2. **Cryptographic correctness is provable.** Even simple algebraic models catch real bugs in protocol logic.

3. **Lean 4 is practical.** A real programming language with a real type checker &mdash; not just academic.

4. **Web3 needs this.** Immutable contracts with billions at stake demand mathematical guarantees.

5. **Start small.** The exercises in this workshop are real Lean 4 &mdash; install it and keep practicing.

---

# References

<div class="small">

- Dalrymple, D. et al., "[Towards Guaranteed Safe AI](https://arxiv.org/abs/2405.06624)," arXiv:2405.06624, 2024.
- Tegmark, M. and Omohundro, S., "[Provably safe systems](https://arxiv.org/abs/2309.01933)," arXiv:2309.01933, 2023.
- De Moura, L. and Ullrich, S., "[The Lean 4 Theorem Prover](https://lean-lang.org/papers/lean4.pdf)," CADE-28, 2021.
- Bursuc, S. et al., "[A benchmark for vericoding](https://arxiv.org/abs/2509.22908)," arXiv:2509.22908, 2025.
- Shannon, C.E., "[Communication Theory of Secrecy Systems](https://ieeexplore.ieee.org/document/6769090)," Bell Syst. Tech. J., 1949.
- Rivest, R., Shamir, A., Adleman, L., "[Digital Signatures and Public-Key Cryptosystems](https://dl.acm.org/doi/10.1145/359340.359342)," CACM, 1978.
- Diffie, W. and Hellman, M., "[New Directions in Cryptography](https://ieeexplore.ieee.org/document/1055638)," IEEE Trans. IT, 1976.
- Blanchet, B., "[Computationally Sound Mechanized Prover](https://bblanche.gitlabpages.inria.fr/CryptoVerif/)," IEEE TDSC, 2008.
- Barthe, G. et al., "[Computer-Aided Security Proofs](https://link.springer.com/chapter/10.1007/978-3-642-22792-9_5)," CRYPTO, 2011.
- The mathlib Community, "[The Lean Mathematical Library](https://dl.acm.org/doi/10.1145/3372885.3373824)," CPP, 2020.

</div>

---

# Resources

- **Lean 4**: https://lean-lang.org/
- **Lean 4 Web IDE**: https://live.lean-lang.org/
- **Mathlib**: https://leanprover-community.github.io/
- **Theorem Proving in Lean 4**: https://lean-lang.org/theorem_proving_in_lean4/
- **Mathematics in Lean**: https://leanprover-community.github.io/mathematics_in_lean/
- **BAIF Research**: https://www.beneficialaifoundation.org/research

---

# Thank You

## Questions?

**Christiano Braga** &mdash; Universidade Federal Fluminense
**Semar Augusto Martins** &mdash; Beneficial AI Foundation

Web3 Experts Brazil &mdash; March 2026

*"In mathematics we trust &mdash; but only if it's machine-checked."*

---

# Appendix: Setting Up Lean 4

```bash
# Install elan (Lean version manager)
curl https://elan.lean-lang.org/install.sh -sSf | sh

# Create a new project
lake new my_crypto_proofs

# Add Mathlib dependency (in lakefile.lean)
# require mathlib from git
#   "https://github.com/leanprover-community/mathlib4"

# Build
lake build
```

**Recommended editor:** VS Code with the `lean4` extension.
