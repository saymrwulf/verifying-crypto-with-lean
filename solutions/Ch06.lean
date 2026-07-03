/- Chapter 6 — solutions. -/
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum
import Mathlib.FieldTheory.Finite.Basic

namespace Ch06

#eval (7 + 8 : ZMod 12)     -- 3
#eval (3 - 7 : ZMod 12)     -- 8
#eval (3⁻¹ : ZMod 7)        -- 5   (3 * 5 = 15 = 1 mod 7)
#eval (4⁻¹ : ZMod 11)       -- 3
#eval (4⁻¹ : ZMod 12)       -- 1   (!) no inverse exists, so Lean returns a
                            --      JUNK value (here 1 — and 4 * 1 ≠ 1, check!).
                            --      Junk from total functions is exactly why
                            --      theorems carry hypotheses.

-- 6.A: a ring identity — the modulus is irrelevant.
example (x y : ZMod 7) :
    (x + y)^3 = x^3 + 3*x^2*y + 3*x*y^2 + y^3 := by
  ring

-- 6.B: finite world, decide.
example : ∀ x : ZMod 12, 4 * x ≠ 1 := by
  decide

/- 6.C: mod 13 the statement is false: 4 * 10 = 40 = 3*13 + 1, so 4⁻¹ = 10.
   `decide` fails (correctly) because it finds the counterexample x = 10. -/
#eval (4⁻¹ : ZMod 13)       -- 10

-- Mathlib's Fermat lemma needs to KNOW 11 is prime — as a typeclass
-- fact. This is how you register arithmetic facts for instance search:
instance : Fact (Nat.Prime 11) := ⟨by decide⟩

-- 6.D: Fermat's little theorem, instantiated at p = 11.
example (a : ZMod 11) (h : a ≠ 0) : a^10 = 1 := by
  have := ZMod.pow_card_sub_one_eq_one h
  simpa using this

-- 6.E: the reduction identity behind every curve25519 codebase.
def p : Nat := 2^255 - 19

example : (2^255 : ZMod p) = 19 := by
  have h : ((p : Nat) : ZMod p) = 0 := ZMod.natCast_self p
  have hp : (2^255 : ZMod p) = ((p : Nat) : ZMod p) + 19 := by
    have : (p : Nat) + 19 = 2^255 := by norm_num [p]
    norm_cast
  rw [hp, h, zero_add]

end Ch06
