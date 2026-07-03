/- Chapter 7 — Primality certificates: exercises.
   The ladder: certify ever-larger primes, watching what each tool costs.
   Requires Mathlib. -/
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.NormNum.Prime

namespace Ch07

/- 7.A: rung one — a two-digit prime. `decide` grinds trial division
   in the kernel; at this size that is instant. -/
example : Nat.Prime 97 := by
  sorry

/- 7.B: rung two — the Fermat prime 65537 = 2^16 + 1 (of RSA fame).
   Try `decide` first and FEEL the pause (kernel trial division is
   quadratic pain). Then switch to `norm_num`, whose prime extension
   builds a certificate instead. Keep whichever is honest AND fast. -/
example : Nat.Prime 65537 := by
  sorry

/- 7.C: rung three — the Mersenne prime 2^31 - 1 (ten digits).
   Kernel trial division is now out of the question; `norm_num`'s
   certificate route answers in seconds. That difference IS the chapter.
   (Curious how far certificates scale? 2^61 - 1 already needs minutes —
   witness trees are cheap to CHECK but costly to FIND.)
   Hint: norm_num's prime extension wants a LITERAL numeral; `show` can
   convert the goal to a definitionally equal one first. -/
example : Nat.Prime (2^31 - 1) := by
  sorry

/- 7.D: your own hands on a Pratt witness (paper + #eval).
   For p = 13: verify that w = 2 satisfies both witness conditions:
     w^(p-1) = 1  (mod p)   and   w^((p-1)/q) ≠ 1 (mod p)
   for each prime q dividing p - 1 = 12 (namely q = 2 and q = 3).
   Fill in the two missing #evals; check against hand computation. -/
#eval (2:ZMod 13)^12    -- must be 1
-- #eval ...           -- w^(12/2): must NOT be 1
-- #eval ...           -- w^(12/3): must NOT be 1

/- 7.E (the finale): the top node of the certificate for the real prime,
   checked with your own modular exponentiation. First, implement fast
   square-and-multiply: at each step, square the base, halve the
   exponent, and fold the base into the accumulator when the exponent
   bit is 1. (The `fuel` argument just guarantees termination; 300 > the
   255 bits we need.) -/
def powModAux : Nat → Nat → Nat → Nat → Nat → Nat
  | 0, _, _, _, acc => acc
  | fuel+1, b, e, m, acc =>
    sorry -- if e = 0 we are done; otherwise recurse as described above

def powMod (b e m : Nat) : Nat :=
  if m ≤ 1 then 0 else powModAux 300 (b % m) e m 1

-- sanity checks for your powMod:
-- #eval powMod 2 12 13    -- expected: 1
-- #eval powMod 3 4 7      -- expected: 4  (81 = 11*7 + 4)

/- …then check the first witness condition for w = 2 at 77 digits.
   Predict the output before you run it. Note the speed: THAT is why
   certificate checking is cheap. -/
def p : Nat := 2^255 - 19
-- #eval powMod 2 (p - 1) p    -- prediction: ?

end Ch07
