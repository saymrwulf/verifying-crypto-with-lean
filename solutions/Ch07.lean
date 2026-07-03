/- Chapter 7 — solutions. -/
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.NormNum.Prime

namespace Ch07

-- 7.A: small enough for kernel trial division.
example : Nat.Prime 97 := by
  decide

-- 7.B: norm_num's certificate route — instant where decide crawls.
example : Nat.Prime 65537 := by
  norm_num

-- 7.C: certificate or nothing at ten digits. One wrinkle worth knowing:
-- norm_num's prime extension wants a LITERAL, so first change the goal to
-- the (definitionally equal) evaluated numeral with `show`.
example : Nat.Prime (2^31 - 1) := by
  show Nat.Prime 2147483647
  norm_num

/- 7.D: Pratt witness for p = 13, w = 2. Hand computation:
   2^12 = 4096 = 315*13 + 1        → 1   ✓ (first condition)
   2^6  = 64   = 4*13 + 12         → 12  ✓ (≠ 1, q = 2)
   2^4  = 16   = 13 + 3            → 3   ✓ (≠ 1, q = 3)  -/
#eval (2:ZMod 13)^12    -- 1
#eval (2:ZMod 13)^6     -- 12  (not 1)
#eval (2:ZMod 13)^4     -- 3   (not 1)

-- 7.E: square-and-multiply.
def powModAux : Nat → Nat → Nat → Nat → Nat → Nat
  | 0, _, _, _, acc => acc
  | fuel+1, b, e, m, acc =>
    if e = 0 then acc
    else powModAux fuel (b*b % m) (e/2) m (if e % 2 = 1 then acc*b % m else acc)

def powMod (b e m : Nat) : Nat :=
  if m ≤ 1 then 0 else powModAux 300 (b % m) e m 1

#eval powMod 2 12 13    -- 1
#eval powMod 3 4 7      -- 4

/- Fermat's little theorem in action at 77 digits: the answer is 1, in
   milliseconds — this is why certificate CHECKING is cheap. (One node of
   the witness tree; the full kernel-checked certificate for the Pallas
   modulus lives in pasta-pallas-verified.) -/
def p : Nat := 2^255 - 19
#eval powMod 2 (p - 1) p    -- 1

end Ch07
