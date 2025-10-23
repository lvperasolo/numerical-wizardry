### A Pluto.jl notebook ###
# v0.20.18

using Markdown
using InteractiveUtils

# ╔═╡ bee59430-ac14-11f0-24c4-61e1dfd3a69f
md""" # Underlying Story for Numerical Calculus

**author:** Lucas V. Perasolo [(email)](l.perasolovicentim@gmail.com)\
**last_updated:** 23/10/2025

---

## Resources for this Script

1. Personal notes based on Prof. Dr. Christian Ludwig's ideas
2. Refer to specific resources listed in the sections below

---

- In high school and most university modules (e.g., linear algebra and analysis), students are taught to work with **precise** "mathematical instruments" like $(+, -, *)$, etc. In real life and in numerical calculus, we start by accepting the imperfections of our world even in mathematical terms. Thus, we shift our perspective and allow, for instance, perceiving mathematical operations like addition as slightly imprecise operations.  
- A direct consequence of this new perspective is that some mathematical properties do not hold anymore (at least not in the fundamental way we are used to). For example, from Analysis, we are taught to believe that associative and commutative properties are valid in other application settings; however, it suffices to take your calculator and check that the associative property does not hold:

**Associative Property**

$(a + b) + c \overset{(?)}{=} a + (b + c) \quad \forall a,b,c \in \mathbb{R}$

Holds in the world of analysis, linear algebra, etc., but not in the world of computer arithmetic, as the next example portrays:
"""

# ╔═╡ 30fa8b2c-63ae-42b7-89ec-2b5995b1d7b9
let
    a = eps(1.0) / 2        # ~5.551e-17
    println("eps(1.0) = ", eps(1.0))
    println("a        = ", a)
	
    println(1 + a + a == 1)          # → true
    println(1 + (a + a) == 1)        # → false
end

# ╔═╡ 83ba85e7-07b0-41b0-b97d-324e0a7094b1
md""" 
In my opinion, a lot happened in the previous cell. So, I would like to go though it in detail, if this is obvious to you skip. This discussion, but for the interested ones:

Let's start with the expression $1 + a + a == 1$. To understand what is happeing, let's go step by step:

**1. Step:** julia "reads" code from left to right. So, we first add (1+a) and then add the final a, even if we have not specified this with syntax like $(1+a)+a$.

**2. Step:** Now, upon the first addition, we end up with the middle point between [1.0, 1.0 + eps(1.0)]. The floating numbers 1.0 and 1.0 + eps(1.0) are the **closest floats representable around 1.0**. (For now, just believe me that this is the case, I will show why this is the case later).

**3. Step:** Now, because Julia follows the **IEEE-754 standard**, which implies the principle **"round to nearest, ties to even"**, we have to consider the two closest floats in binary and not decimal. Now, because we are equally distant to the two possible floats, we resolve the "tie" by picking the binary representation whose least significant bit is even. With the Julia command 'bitstring(1.0)' we can read the binary representation:
"""

# ╔═╡ 25184638-4b37-4523-8ae3-44fc938c1ae4
let
	print("The bitstring of 1.0 is: \n" , bitstring(1.0), "\n \n") # last bit is "0" (even)
	print("The bitstring of 1.0 + eps(1.0) is: \n" , bitstring(1.0 + eps(1.0))) # last bit is "1" (odd)
end

# ╔═╡ 59820189-80fc-4125-b7e1-b3326510e43c
md""" 
alright, so after the first addition $(1+a)$ (due to IEEE-754) we land back at $1.0$. Now, applying the second addition of $a$, the same happens once more and we land again at $1.0$ and, thus $1.0 == 1.0$ and we get true out.

Ok! We have broken the first operation down to what is happening in the background. Now, let's proceed to the second operation: $1.0 + (a + a)$.

Here, we have enforced the "priority" on adding $(a+a)$ which gives eps(1.0) out, and $1.0 + eps(1.0)$ is the exact "next" float. So, $1.0 + eps(1.0) > 1.0$ and thus the output is false. 

## floats in Binary 
		(that thing with "closest floats and their representability in computer")

- in human imagination (and thus math), we can picture any number in the real line. in the computer, this is not possible, since we have finite resources (e.g. finite memory / storage).
- So, in the computer by representing a finite number of real numbers, we are **discretizing** the space of possible numbers - thus, we never have all real numbers available to us.

- This **discretization** varies by data type 
		(REMEMBER: this is one of the reasons why I meant that script 02 is super important and at first sight trivial when it actually is not).

Let's compare two data types here once more and see their effect on the discretization of possible numbers, Float16 vs. Float64.
"""

# ╔═╡ 3275b053-7f3e-4e72-b372-1cdf0791b94c
let
    println("=== Float16 numbers around 1.0 ===")
    x = Float16(1)
    for i in -5:5
        println(prevfloat(x, -i))  # prevfloat(x, -i) == nextfloat(x, i)
    end

    println("\n=== Float64 numbers around 1.0 ===")
    x = 1.0
    for i in -5:5
        println(prevfloat(x, -i))
    end
end

# ╔═╡ 5cbb7e93-89d2-493b-9226-3cc599f541eb
md""" 
with Float64 we have more real numbers available and hence our precision is higher/granualar/finer. With Float16, we have a slower precision/coarcers but are faster.

- See ["How Floating-Point Numbers Are Represented" (YouTube video)](https://www.youtube.com/watch?v=bbkcEiUjehk) for how floats are represented in binary (i.e. the logic/idea behind the bitstring(...) method in julia.)
"""

# ╔═╡ a6b53703-9e8c-46bb-9504-8a1c4d9706e4
md"""  ## "Bad by Construction"

Some expressions are bad by construction (i.e., they propagate more noise/disturbance compared to a different representation of the same object).

1. **Differential Quotient**

$\frac{f(x+h) - f(x)}{h} \overset{(?)}{=} \frac{f(x+h) - f(x)}{h + x - x}$

From an analysis/algebraic point of view, the left and right hand sides are the same, but from a numerical point of view, they are different:
"""

# ╔═╡ 1a539823-9b11-49be-bb28-285b38e2d0cd
let
    f(x) = sin(x)
    x = (3 * π) / 4
    h = 1e-9

    denominator₁ = h
    denominator₂ = h + x - x

    println("Denominator₁ = ", denominator₁)
    println("Denominator₂ = ", denominator₂)

    diff_coef_are_equal = ((f(x + h) - f(x)) / denominator₁) == ((f(x + h) - f(x)) / 	denominator₂) ? "Yes" : "No"

    println("Differential coefficients are equal? ", diff_coef_are_equal)
end

# ╔═╡ 3a8bdb3a-5a09-4e35-a73a-a7a861ea19ee
md""" 
## "The Questionaire"

All in all, we are interested in the following four questions, to guide us in our numerical exploration:

**Q1:** How many numbers/digits can we rely on? (say, given $0.123456789$ how many are correct?)

**Q2:** Why only this many? (i.e. frequently) why often so few digits?)

**Q3:** Which component of our expressions/algorithm is responsible?

**Q4:**  How should I refactor the code/expression such that I get double as many correct digits (i.e., more digits in general)?

---
 
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.7"
manifest_format = "2.0"
project_hash = "da39a3ee5e6b4b0d3255bfef95601890afd80709"

[deps]
"""

# ╔═╡ Cell order:
# ╟─bee59430-ac14-11f0-24c4-61e1dfd3a69f
# ╠═30fa8b2c-63ae-42b7-89ec-2b5995b1d7b9
# ╟─83ba85e7-07b0-41b0-b97d-324e0a7094b1
# ╠═25184638-4b37-4523-8ae3-44fc938c1ae4
# ╟─59820189-80fc-4125-b7e1-b3326510e43c
# ╠═3275b053-7f3e-4e72-b372-1cdf0791b94c
# ╟─5cbb7e93-89d2-493b-9226-3cc599f541eb
# ╟─a6b53703-9e8c-46bb-9504-8a1c4d9706e4
# ╠═1a539823-9b11-49be-bb28-285b38e2d0cd
# ╟─3a8bdb3a-5a09-4e35-a73a-a7a861ea19ee
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
