### A Pluto.jl notebook ###
# v0.20.18

using Markdown
using InteractiveUtils

# ╔═╡ e21902d8-be4d-49d3-bec5-e18fb16de225
md"""

# Oi, Mundo (Hello World)

O famoso **"oi mundo"** (ou *"hello world"*) costuma ser o primeiro código que uma pessoa escreve ao começar a programar. É um simples teste para verificar se tudo está funcionando corretamente — e também uma forma simbólica de dar as boas-vindas ao mundo da programação. Nesse arquivo temos 3 maneiras de falar "oi mundo".

No **Pluto.jl**, cada execução de uma célula é acompanhada pela medição do tempo necessário para rodar o código daquela célula.  
Uma **célula** é um espaço onde escrevemos e executamos código.  
Você pode executá-la de duas formas:
- Salvando (por exemplo, pressionando `CMD + S` ou `Ctrl + S`), ou  
- Clicando no botão **"play"** ao lado da célula.  

Logo ao lado do botão *play*, o Pluto mostra o tempo de execução — ou seja, quanto tempo o código levou para rodar.  

> 💡 Ao longo destas notas, você perceberá que a **medição do tempo** é um tema recorrente e importante para mim.
"""

# ╔═╡ 2a16e8ac-a358-11f0-0fe1-937470035778
print("oi mundo")

# ╔═╡ c8b37a74-90b1-4478-a958-f2efde640d7a
println("oi mundo")

# ╔═╡ 9c2b1012-6921-4985-a9f3-a259729dfff8
@show "oi mundo"

# ╔═╡ 8f641ccf-f4a4-4708-8e3f-5887e3b47e43
md"""
### Tempo

| Unidade de tempo | Símbolo | Escala |
|:------------------|:---------:|:-------:|
| 1 picosegundo | $ps$ | $10^{-12}$ |
| 1 nanosegundo | $ns$ | $10^{-9}$ |
| 1 microssegundo | $\mu s$ | $10^{-6}$ |
| 1 milissegundo | $ms$ | $10^{-3}$ |
| **———** | **———** | **———** |
| **1 segundo** | $s$ | $10^0$ |
| **———** | **———** | **———** |
| 1 quilosegundo | $ks$ | $10^3$ |
| 1 megassegundo | $Ms$ | $10^6$ |

**Referencia:** ["Ordens de magnitude para o tempo"](https://pt.wikipedia.org/wiki/Ordens_de_magnitude_para_tempo)
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
# ╟─e21902d8-be4d-49d3-bec5-e18fb16de225
# ╠═2a16e8ac-a358-11f0-0fe1-937470035778
# ╠═c8b37a74-90b1-4478-a958-f2efde640d7a
# ╠═9c2b1012-6921-4985-a9f3-a259729dfff8
# ╟─8f641ccf-f4a4-4708-8e3f-5887e3b47e43
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
