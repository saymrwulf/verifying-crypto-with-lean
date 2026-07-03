/- Chapter 6 — Modular Arithmetic: exercises.
   The clock worlds ZMod n, hands on. Requires Mathlib. -/
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum
import Mathlib.FieldTheory.Finite.Basic

namespace Ch06

-- First contact: run these and read the answers.
#eval (7 + 8 : ZMod 12)     -- ?
#eval (3 - 7 : ZMod 12)     -- ? (wraps — no truncation)
#eval (3⁻¹ : ZMod 7)        -- 6.1: your first inverse. Check 3 * answer = 1!
#eval (4⁻¹ : ZMod 11)       -- (the chapter's clock picture says 3)
#eval (4⁻¹ : ZMod 12)       -- what does Lean do when NO inverse exists?

/- 6.A: a cube expansion in a tiny field — one tactic. -/
example (x y : ZMod 7) :
    (x + y)^3 = x^3 + 3*x^2*y + 3*x*y^2 + y^3 := by
  sorry

/- 6.B (exercise 6.2): four has no inverse on the twelve-hour clock —
   twelve cases, and you know the tactic that tries them all. -/
example : ∀ x : ZMod 12, 4 * x ≠ 1 := by
  sorry

/- 6.C: …then change the modulus to 13 and the SAME tactic must refuse:
   the statement becomes false. Find the witness: what is 4⁻¹ mod 13?
   (Answer with an #eval, then explain in one comment line.) -/

-- Mathlib's Fermat lemma needs to KNOW 11 is prime — as a typeclass
-- fact. This is how you register arithmetic facts for instance search:
instance : Fact (Nat.Prime 11) := ⟨by decide⟩

/- 6.D (exercise 6.3): Fermat's little theorem from the library.
   `ZMod.pow_card_sub_one_eq_one` says a^(p-1) = 1 for a ≠ 0.
   Use it (with `show`/`calc`/`rw` as you like) to prove: -/
example (a : ZMod 11) (h : a ≠ 0) : a^10 = 1 := by
  sorry

/- 6.E: the crown fact of the chapter, stated in the real field. -/
def p : Nat := 2^255 - 19

example : (2^255 : ZMod p) = 19 := by
  sorry

end Ch06
