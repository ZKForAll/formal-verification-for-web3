import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Vector.Basic
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Tactic.Ring

/-!
# Formal Verification for Web3

Workshop code for Web3 Experts Brazil.
All Lean 4 code from the workshop slides.
Exercise solutions are provided as comments below each exercise.
-/

-- ============================================================================
-- Part 1: Lean 4 Foundations and Tactics
-- ============================================================================

-- ---------------------------------------------------------------------------
-- What Is Lean 4?
-- ---------------------------------------------------------------------------

-- A program
def double (n : Nat) : Nat := 2 * n

#eval double 5

-- A theorem
theorem double_is_add_self (n : Nat) : double n = n + n := by
  -- ⊢ double n = n + n
  rewrite [double]
  -- ⊢ 2 * n = n + n
  rewrite [Nat.succ_mul]
  -- ⊢ 1 * n + n = n + n
  rewrite [Nat.one_mul]
  -- ⊢ n + n = n + n
  rfl
  /- rw [double, Nat.succ_mul, Nat.one_mul] -/

-- ---------------------------------------------------------------------------
-- Anatomy of a Lean Proof
-- ---------------------------------------------------------------------------

-- Primed to avoid clash with Mathlib's Nat.succ_pos
theorem succ_pos' (n : Nat) : 0 < n + 1 := by
  exact Nat.zero_lt_succ n

-- ---------------------------------------------------------------------------
-- Basic Types and Terms
-- ---------------------------------------------------------------------------

#check (42 : Nat)
#check Nat.succ 3
def add_one (n : Nat) : Nat := n + 1
#eval add_one 41
#check (2 + 2 = 4 : Prop)
#check (∀ n : Nat, n + 0 = n)

-- ---------------------------------------------------------------------------
-- Structures and Notation
-- ---------------------------------------------------------------------------

structure Point where
  x : Nat
  y : Nat

abbrev MyType := Nat

-- ---------------------------------------------------------------------------
-- What Are Tactics?
-- ---------------------------------------------------------------------------

-- ---------------------------------------------------------------------------
-- Tactic: rfl
-- ---------------------------------------------------------------------------

theorem two_plus_two : 2 + 2 = 4 := by
  rfl

theorem bool_and_true : true && true = true := by
  rfl


-- ---------------------------------------------------------------------------
-- Tactic: exact and assumption
-- ---------------------------------------------------------------------------

theorem example_proof (P Q : Prop) (hp : P) (hpq : P → Q) : Q := by
  exact hpq hp

-- Primed to avoid clash with Mathlib's And.intro
theorem and_intro' (P Q : Prop) (hp : P) (hq : Q) : P ∧ Q := by
  exact ⟨hp, hq⟩

theorem trivial_imp (P : Prop) (h : P) : P := by
  assumption

-- ---------------------------------------------------------------------------
-- Tactic: intro
-- ---------------------------------------------------------------------------

theorem identity_eq : ∀ (n : Nat), n = n := by
  intro n
  rfl

-- Primed to avoid clash with Mathlib's imp_self
theorem imp_self' (P : Prop) : P → P := by
  intro h
  exact h


-- ---------------------------------------------------------------------------
-- Tactics: rewrite / rw
-- ---------------------------------------------------------------------------

-- remember: def add_one (n : Nat) : Nat := n + 1

theorem add_one_trivial (n : Nat) : add_one n = n + 1 := by
  rewrite [add_one]
  -- ⊢ n + 1 = n + 1
  rfl

theorem double_is_add_self' (n : Nat) : double n = n + n := by
  rw [double, Nat.succ_mul, Nat.one_mul]

-- ---------------------------------------------------------------------------
-- Tactic: apply
-- ---------------------------------------------------------------------------

theorem p_and_b (P Q : Prop) (h₁ : P) (h₂ : Q) : P ∧ Q := by
  apply And.intro
  · apply h₁
  · apply h₂

-- ---------------------------------------------------------------------------
-- Tactic: simp
-- ---------------------------------------------------------------------------

theorem list_append_nil (l : List α) : l ++ [] = l := by
  simp

theorem arith_example (n : Nat) : n + 0 + 0 = n := by
  simp

theorem double_is_add_self'' (n : Nat) : double n = n + n := by
  simp [double, Nat.succ_mul]

-- ---------------------------------------------------------------------------
-- Tactic: decide
-- ---------------------------------------------------------------------------

theorem fin2_self_add : ∀ (a : Fin 2), a + a = 0 := by
  decide

theorem bool_demorgan : ∀ (a b : Bool),
    (!(a && b)) = (!a || !b) := by
  decide

-- ---------------------------------------------------------------------------
-- Tactic: omega
-- ---------------------------------------------------------------------------

theorem omega_demo1 (n : Nat) : n + 1 > n := by
  omega

theorem omega_demo2 (a b : Nat) (h : a ≤ b) :
    a + 1 ≤ b + 1 := by
  omega

-- ---------------------------------------------------------------------------
-- Tactic: ring (requires Mathlib)
-- ---------------------------------------------------------------------------

theorem ring_demo1 (a b : Nat) :
    (a + b) * (a + b) = a*a + 2*a*b + b*b := by
  ring

theorem ring_demo2 (x : Int) :
    (x + 1) * (x - 1) = x^2 - 1 := by
  ring

-- ---------------------------------------------------------------------------
-- Tactic: have and calc
-- ---------------------------------------------------------------------------

theorem have_demo (a b c : Nat)
    (h1 : a = b) (h2 : b = c) : a = c := by
  have h3 : a = c := by
    calc a = b := h1
         _ = c := h2
  exact h3


-- ---------------------------------------------------------------------------
-- Exercise 1: Logic Warmup
-- ---------------------------------------------------------------------------

-- 1a. Commutativity of ∧
theorem and_comm_ex (P Q : Prop) : P ∧ Q → Q ∧ P := by
  sorry

-- Solution 1a:
--   intro h
--   exact ⟨h.2, h.1⟩

-- 1b. Transitivity of implication
-- Primed to avoid clash with Mathlib's imp_trans
theorem imp_trans' (P Q R : Prop) :
    (P → Q) → (Q → R) → P → R := by
  sorry

-- Solution 1b:
--   intro hpq hqr hp
--   exact hqr (hpq hp)

-- 1c. A simple arithmetic fact
theorem exercise_arith (n : Nat) : n + n = 2 * n := by
  sorry

-- Solution 1c:
  /- rw [Nat.succ_mul, Nat.one_mul] -/


-- ============================================================================
-- Part 2: Cryptographic Protocols in Lean 4
-- ============================================================================

-- ---------------------------------------------------------------------------
-- Protocol 1: One-Time Pad (XOR Cipher)
-- ---------------------------------------------------------------------------

-- We model bits as ZMod 2 (integers mod 2)
-- XOR is simply addition in ZMod 2
abbrev Bit := ZMod 2

def otp_encrypt (key msg : Vector Bit n) : Vector Bit n :=
  Vector.zipWith (· + ·) key msg

def otp_decrypt (key cipher : Vector Bit n) : Vector Bit n :=
  Vector.zipWith (· + ·) key cipher

-- Key property of ZMod 2: a + a = 0
theorem zmod2_self_add : ∀ (a : ZMod 2), a + a = 0 := by
  decide

-- Correctness: decrypt(key, encrypt(key, msg)) = msg
theorem otp_correct (key msg : Vector Bit n) :
    otp_decrypt key (otp_encrypt key msg) = msg := by
  unfold otp_encrypt otp_decrypt
  ext i
  simp only [Vector.getElem_zipWith]
  -- Goal: key[i] + (key[i] + msg[i]) = msg[i]
  -- By associativity: (key[i] + key[i]) + msg[i]
  -- By self-inverse:  0 + msg[i] = msg[i]
  rw [← add_assoc, zmod2_self_add, zero_add]

-- Encryption is its own inverse (involutory)
theorem otp_involutory (key msg : Vector Bit n) :
    otp_encrypt key (otp_encrypt key msg) = msg :=
  otp_correct key msg  -- encrypt and decrypt are the same!

-- Encryption is commutative in key and message
theorem otp_comm (a b : Vector Bit n) :
    otp_encrypt a b = otp_encrypt b a := by
  unfold otp_encrypt; ext i
  simp [Vector.zipWith]; ring

-- ---------------------------------------------------------------------------
-- Exercise 3: OTP Properties
-- ---------------------------------------------------------------------------

-- 3a. Encrypting with the zero key is identity
theorem otp_zero_key (msg : Vector Bit n) :
    otp_encrypt (Vector.replicate n (0 : Bit)) msg
    = msg := by
  sorry

-- Solution 3a:
--   unfold otp_encrypt; ext i
--   simp [Vector.zipWith, Vector.replicate]

-- 3b. Encrypting a message with itself yields zeros
theorem otp_self_encrypt (msg : Vector Bit n) :
    otp_encrypt msg msg
    = Vector.replicate n (0 : Bit) := by
  sorry

-- Solution 3b:
--   unfold otp_encrypt; ext i
--   simp [Vector.zipWith]
--   exact zmod2_self_add (msg.get i)

-- ---------------------------------------------------------------------------
-- Protocol 2: RSA
-- ---------------------------------------------------------------------------

structure RSAParams where
  p : Nat
  q : Nat
  hp : Nat.Prime p
  hq : Nat.Prime q
  hpq : p ≠ q
  e : Nat
  d : Nat
  he_pos : 0 < e
  n : Nat := p * q
  phi : Nat := (p - 1) * (q - 1)
  he : Nat.Coprime e phi
  hed : e * d % phi = 1

def rsa_encrypt (params : RSAParams) (m : ZMod params.n) :=
  m ^ params.e
def rsa_decrypt (params : RSAParams) (c : ZMod params.n) :=
  c ^ params.d

-- Correctness: decrypt(encrypt(m)) = m
-- The sorry is intentional — the full proof chains through ZMod.pow_totient in Mathlib.
-- Note: hm assumes gcd(m,n)=1. The general case (∀ m) follows from CRT.
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

-- ---------------------------------------------------------------------------
-- Exercise 4: RSA Properties
-- ---------------------------------------------------------------------------

-- 4a. Encrypting 1 always gives 1
theorem rsa_one (params : RSAParams) :
    rsa_encrypt params (1 : ZMod params.n) = 1 := by
  sorry

-- Solution 4a:
--   unfold rsa_encrypt
--   exact one_pow params.e

-- 4b. Encrypting 0 always gives 0
theorem rsa_zero (params : RSAParams) :
    rsa_encrypt params (0 : ZMod params.n) = 0 := by
  sorry

-- Solution 4b:
--   unfold rsa_encrypt
--   exact zero_pow params.he_pos.ne'

-- ---------------------------------------------------------------------------
-- Protocol 3: Diffie-Hellman Key Exchange
-- ---------------------------------------------------------------------------

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

-- Both sides compute the same shared secret
theorem dh_shared_secret_agree (params : DHParams)
    (a b : Nat) :
    let alice_pub := params.g ^ a
    let bob_pub   := params.g ^ b
    dh_shared_secret params a bob_pub =
    dh_shared_secret params b alice_pub := by
  simp only [dh_shared_secret]
  -- Goal: (g ^ b) ^ a = (g ^ a) ^ b
  rw [← pow_mul, ← pow_mul]
  -- Goal: g ^ (b * a) = g ^ (a * b)
  ring_nf

-- Extends to 3-party key agreement
theorem dh_three_party (params : DHParams) (a b c : Nat) :
    ((params.g ^ a) ^ b) ^ c
    = ((params.g ^ a) ^ c) ^ b := by
  rw [← pow_mul, ← pow_mul, ← pow_mul, ← pow_mul]
  ring_nf

-- Secret 0 gives trivial key (g^0 = 1)
theorem dh_zero_secret (params : DHParams)
    (their_pub : ZMod params.p) :
    dh_shared_secret params 0 their_pub = 1 := by
  simp [dh_shared_secret]

-- ---------------------------------------------------------------------------
-- Bonus:
-- ---------------------------------------------------------------------------

-- 5a. Shared secret with yourself: g^(a*a)
theorem dh_self (params : DHParams) (a : Nat) :
    dh_shared_secret params a (params.g ^ a)
    = params.g ^ (a * a) := by
  simp only [dh_shared_secret]
  -- try this: rw?
  rw [pow_mul]

-- 5b. Composing exponentiations
theorem dh_compose (params : DHParams) (a b : Nat)
    (their_pub : ZMod params.p) :
    (their_pub ^ a) ^ b = their_pub ^ (a * b) := by
      /- try this: apply? -/
      exact Eq.symm (pow_mul their_pub a b)
