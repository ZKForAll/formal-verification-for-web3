# Formal Verification for Web3

A [Lean 4](https://lean-lang.org/) + [Mathlib](https://leanprover-community.github.io/) project accompanying a 90-minute workshop on formal verification of cryptographic protocols for Web3.

## What's inside

- **`FormalVerificationForWeb3/Basic.lean`** — All Lean 4 code from the workshop: definitions, theorems, and interactive exercises (with solutions as comments).
- **`doc/Formal_Verification_for_Web3.md`** — [Marp](https://marp.app/) slide deck covering motivation, Lean 4 foundations, and three cryptographic protocols.

### Protocols formalized

| Protocol | Key property | Lean model |
|---|---|---|
| **One-Time Pad** | XOR involution: $a + a = 0$ in $\mathbb{Z}_2$ | `Vector (ZMod 2) n` |
| **RSA** | Euler's theorem: $m^{ed} \equiv m$ | `ZMod (p * q)` |
| **Diffie-Hellman** | Commutativity: $g^{ab} = g^{ba}$ | `ZMod p` |

All proofs use a **deterministic algebraic model** — correctness of protocol operations, not computational security assumptions.

### Lean 4 tactics covered

`rfl`, `intro`, `exact`, `simp`, `omega`, `ring`/`ring_nf`, `have`/`calc`, `unfold`, `rw`, `ext`, `decide`

## Building

Requires [elan](https://github.com/leanprover/elan) (Lean version manager).

```bash
lake build
```

On first build, Mathlib will be fetched and its cache decompressed. Subsequent builds are fast.

## Rendering the slides

Requires [Marp CLI](https://github.com/marp-team/marp-cli) and Node.js >= 20.

```bash
# Install Marp CLI globally
npm install -g @marp-team/marp-cli

# Install Shiki (for Lean 4 syntax highlighting) in doc/
cd doc && npm install && cd ..

# Generate PDF with Lean 4 syntax highlighting
marp --no-stdin --engine ./doc/engine.mjs doc/Formal_Verification_for_Web3.md -o doc/Formal_Verification_for_Web3.pdf --allow-local-files

# Generate HTML
marp --no-stdin --engine ./doc/engine.mjs doc/Formal_Verification_for_Web3.md -o doc/Formal_Verification_for_Web3.html --allow-local-files
```

The custom engine (`doc/engine.mjs`) replaces Marp's default highlighter with [Shiki](https://shiki.style/), which supports the Lean 4 TextMate grammar. Comments are rendered in green.

## License

[MIT](LICENSE)
