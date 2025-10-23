### A Pluto.jl notebook ###
# v0.20.18

using Markdown
using InteractiveUtils

# ╔═╡ 4c79a447-fb0e-4f15-9a68-beb96bbb596b
md"""
# Objetos vs. Variáveis

⚠️ Aviso: o conteúdo deste script talvez seja o mais importante de todos. Ele parece simples à primeira vista, mas aposto que muitas pessoas (inclusive eu) acabam revisitando esse assunto com certa frequência — especialmente quando vêm de outra linguagem de programação ou não tiveram um curso introdutório de computação com foco em tipos de objetos/variáveis.

---

**author:** Lucas V. Perasolo [(email)](l.perasolovicentim@gmail.com)\
**last_updated:** 23/10/2025

---

## Recursos

1. Veja as respectivas fontes utilizadas nos links abaixo.

---
"""

# ╔═╡ 14702fb0-a360-11f0-11a0-b96ecbd2512e
md"""

## 1. Objetos

### Em Julia 
vive-se pelo **princípio** de que *tudo é um objeto* (*everything is an object*).

### O que é um objeto?

Um **objeto** é um pedaço de memória no computador que possui duas características/atributos:

1. um **Estado** — definido pelo seu conteúdo em *bits* (zeros e uns);
2. um **Tipo** — definido pela forma como esses bits devem ser interpretados.
---
"""


# ╔═╡ 57dab13d-634e-4d78-b811-95f31d01d708
let
    println("Começamos com um exemplo, o número 8. Qual é o seu tipo e seu tamanho?")
    println("O objeto 8 é do tipo $(typeof(8)) e tem $(sizeof(8)) bytes.")
end

# ╔═╡ df8bb3ca-5260-473d-acde-79a41189ca5e
md"""

### Scopes em Julia

No bloco acima, observe que agrupamos dois comandos na mesma célula. Por definição/construção, o Pluto não deixa você executar mais de um comando por célula [Veja: Pluto Forum](https://discourse.julialang.org/t/pluto-begin-end-usage/79559/2). 

Caso você ainda queira executar mais de um comando por célula, você deve definir um **"scope"**. Eu penso em scopes como uma região no meu arquivo onde meus objetos "vivem"/são definidos. Se eu tentar acessá-los fora de seu scope, eu não consigo. A definição formal de **scopes** está aqui: [Julia Scopes](https://docs.julialang.org/en/v1/manual/variables-and-scoping/).

Existem diferentes maneiras de criar scopes em Julia, por exemplo através de `begin {...} end` ou `let {...} end`.

---

"""

# ╔═╡ 502a6f91-dbda-4b99-b8e5-bd9cf05624b8
md"""
### (Breve) Excursão: Bits & Bytes

No computador, nós tentamos representar informação. Por exemplo, a expressão **"oi mundo"**.  
Na linguagem do computador, "oi mundo" é representado por bits e bytes. 

📜 Veja: [Bit (wikipedia)](https://pt.wikipedia.org/wiki/Bit)

- O **Bit** é a menor unidade de medida no computador  
- Um Bit pode ter dois estados ${0,1}$ — esse fato nos motiva a usar uma base numérica diferente da que usamos no dia a dia (a base decimal), respectivamente a **base binária**  
  📜 Veja: [Conversão de base numérica (wikipedia)](https://pt.wikipedia.org/wiki/Convers%C3%A3o_de_base_num%C3%A9rica)

📜 Veja: [Byte (wikipedia)](https://pt.wikipedia.org/wiki/Byte)

- Um **Byte** também é uma unidade de medida de informação no computador.  
- Um Byte é exatamente 8 bits.

Dessa forma, com o pouco que vimos sobre bits e bytes, já é possível estabelecer a seguinte visão sobre como a informação é representada no computador.  
Se pegarmos o número $8$ e reescrevermos ele da seguinte forma:

$$8 = 2*2*2 = 2^3 = 1*2^3 = 0 + 1*2^3 + 0$$

Agora observamos que:

1. Ao escrever 8 como potências de 2, obtivemos a representação do 8 em base binária (isto é, escrita em termos de 2)  
2. A expressão $0 + 1*2^3 + 0$ é estranha (ninguém em sua consciência escreve assim no dia a dia), mas pode revelar a diferença entre tipos de dados (a seguir).

## Tipos de dados

⚠️ **Aviso:** Eu ignoro números racionais/decimais nesse script. Eles terão um script dedicado somente a eles, já que lidar com eles é mais difícil.

Bom, apesar de existirem inúmeros tipos de dados em Julia, em primeiro lugar vamos olhar somente o tipo de dado chamado **unsigned integer** (número inteiro sem sinal).  
As colunas a seguir são:

1. **Tipo**: descreve o tipo da variável armazenada `UInt<Número de bits à disposição>`  
2. **Bits**: número de bits à disposição  
3. **Valor Máximo**: dado o número de bits à disposição, o valor máximo é a quantidade de informação que pode ser armazenada nesse objeto  
4. **Exemplo de representação: Número 8** — como o número 8 é representado no computador  
5. **Uso de memória em Byte** — se 1 Byte = 8 bits, então o número de bits dividido por 8 nos dá o espaço em memória (em bytes) reservado para o objeto.

### Tabela:

| Tipo     | Bits | Intervalo de valores | Exemplo de representação: Número $8$ | Uso de memória em Byte |
|-----------|------|----------------------|--------------------------------------|-------------------------|
| `UInt8`   | 8    | $[0, 2^8 - 1] = [0, 255]$ | `0000 1000`  | 1 Byte |
| `UInt16`  | 16   | $[0, 2^{16} - 1]$ | `0000 0000 0000 1000` | 2 Bytes |
| `...`     | ...  | ... | ... | ... |
| `UInt128` | 128  | $[0, 2^{128} - 1]$ | `...0000 1000` (com 120 zeros à esquerda) | 16 Bytes |

---

**Observações/Perguntas:**

- Com a notação $[0,255]$, refiro-me a todos os números $0,\dots,255$  

- Se na verdade $2^8 = 256$, então por que nos falta 1 bit?  
  **Resposta:**  

- E se usarmos o tipo **Int8** ao invés do **UInt8**, qual é o intervalo de números?  

- “Bom, eu sei que o meu computador tem uma memória finita. Então faz sentido viver pelo princípio de sempre usar o tipo de dado que menos reserva espaço na memória. Olhando a tabela, o **UInt8**.”  
  Esse pensamento faz sentido?  
  **Resposta:**  
  1. Faz sentido ter em mente que queremos escrever código eficiente e tirar o melhor dos nossos recursos (ex.: minimizar o uso de memória).  
  2. Mas considere agora o código: descomente temporariamente `y = UInt8(256)`  
"""

# ╔═╡ cd1c6865-042a-43a8-8eaa-dcd4e8883982
begin 
	x = UInt8(255)
	print("O valor de x é ", x, " e seu tipo é ", typeof(x))
	# y = UInt8(256) ## Descomentando esse código e executando a célula deve levantar um erro
	z = 256
	print("\nO valor de z é ", z, " e seu tipo é ", typeof(z)) 
end	

# ╔═╡ a51bbc6e-6b1f-4756-b83a-bec9f4651f48
md"""
O output da célula acima é "0xff", o número 255 representado em base 16 (hexadecimal). Isso significa: $255 = 15 \times 16^1 + 15 \times 16^0$. Agora adicionemos $1$ a $255$, em hexadecimal: 

$255 + 1 = 0\text{xff} + 0\text{x}1$

O que devemos esperar da adição? Eu diria 256...
"""

# ╔═╡ bea47ada-f306-4928-8ece-11b0989cf48a
x + 0x1

# ╔═╡ 437614d8-8bbc-43a7-80c0-8f857e2d4f38
md"""
... na verdade ganhamos 
$0\text{x}00 = 0$. Qual é o sentido disso ??? Bom, isso revela uma característica de Julia chamada **"wrap around"** ("voltamos para o  começo"). Uma forma de ver o "wrap around" é imaginar estar andando em uma escada com um limite de degraus (ex.: 10 degraus). Se andarmos 11 degraus, voltamos para o primeiro andar e não chegamos ao 11º degrau (ex.: [escada de Penrose](https://mathworld.wolfram.com/PenroseStairway.html)).

![Escada de Penrose](https://imgs.search.brave.com/dnnAEqcFpIXsDOxRacNW-rShDecL_EPpfrt5QUrqXYU/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly91cGxv/YWQud2lraW1lZGlh/Lm9yZy93aWtpcGVk/aWEvY29tbW9ucy8z/LzM0L0ltcG9zc2li/bGVfc3RhaXJjYXNl/LnN2Zw)

📜 Fonte: [Wikipedia](https://pt.wikipedia.org/wiki/Escada_de_Penrose)

---

⚠️ **Observe**

1. que Julia escolheu o tipo de dado para o número 256. 64 Bits é o mínimo necessário para representar o número 256, já que: $2^8 = 256$ e $8 \times 8 = 64$

2. que ao criarmos o scope por meio do comando `begin`, eu posso acessar o objeto `x` na célula seguinte àquela na qual foi definido.

3. Existem vários motivos pelos quais usamos a representação hexadecimal. Em linhas gerais, usamos essa base especialmente porque ela é uma forma compacta de representar grandes números e ela se encaixa bem com a base binária. Se você se interessa sobre números hex mais a fundo, seguem algumas fontes de informação:

- [Discussão no Stack Overflow sobre por que usamos hex em memória?](https://stackoverflow.com/questions/5329916/why-are-memory-addresses-are-represented-using-hexadecimal-numbers)
- [Tripleto Hexadecimal](https://pt.wikipedia.org/wiki/Tripleto_hexadecimal)
---
"""

# ╔═╡ a21e0838-e961-4574-b219-90ab1f667974
md"""
## "Uma regra de bolso"

Até onde eu entendo, a decisão de qual tipo de dado usar para um objeto não é simples — especialmente se o objeto não é constante. Caso o objeto seja constante, podemos formular a seguinte "regra de bolso" para programação **em Julia**:

**Regra de bolso**: o tipo do objeto

1. é no mínimo, o mínimo necessário; 
2. é no máximo, o tamanho do CPU da sua máquina 

**Note**: caso você esteja trabalhando com números onde o sinal deles ("$\pm$") importa, também é importante diferenciar entre tipos **signed** (com sinal) vs. **unsigned** (sem sinal).

**⚠️ Aviso:** para código fonte ("in source code"), Julia mesmo escolherá o tipo para você.

----
"""

# ╔═╡ 4cb9ef6c-7cbb-4ee8-936e-d8cc3348e586
md"""
### Classes de objetos: "mutable vs. immutable"

O tipo de um objeto determina se ele pertence à classe de objetos mutáveis (mutable) ou imutáveis (immutable). Para não me estender aqui, eu escolho listar objetos que são, em linhas gerais, mutáveis ou não, e adicionar recursos para o leitor ver os detalhes desse assunto extenso:

- Objetos **mutáveis** incluem: Big Integers, Big Floats e específicos tipos de arrays.

- Objetos **imutáveis** incluem: números inteiros, floats, complexos, racionais (sem o termo "Big" no nome), funções, Tuples, e alguns tipos específicos de arrays (ex.: Ranges).


📜 Veja mais:
1. [Julia Notes: "Immutable and mutable variables"](https://m3g.github.io/JuliaNotes.jl/stable/immutable/)
2. [Julia: "Types"](https://docs.julialang.org/en/v1/manual/types/)
3. [Julia: Mutable composite types](https://docs.julialang.org/en/v1/manual/types/#Mutable-Composite-Types)
4. [Julia: Integers and Floats](https://docs.julialang.org/en/v1/manual/integers-and-floating-point-numbers/)
5. [Julia: Complex and rational numbers](https://docs.julialang.org/en/v1/manual/complex-and-rational-numbers/)
6. [Julia: Funções](https://docs.julialang.org/en/v1/manual/functions/)
7. [Julia: Tuples](https://docs.julialang.org/en/v1/manual/functions/#Tuples)

---

"""

# ╔═╡ 489ca8d6-85de-44c1-9cdb-657e3a756509
md""" ## 2. Variáveis 
[Variáveis](https://docs.julialang.org/en/v1/manual/variables/) em Julia são simplesmente um "nome" associado ("bounded" — por isso variáveis são chamadas de "binding" também) a um valor. Uma maneira de visualizar essa associação é por meio de uma flecha que aponta para o objeto real. Por exemplo, consideremos o caso de um array (mutável) com as primeiras 4 potências de 2:
"""

# ╔═╡ 8e59111c-c502-46e8-9e98-f286c3297248
let
    x = [1, 2, 4, 8]
    println("📦 Informações da Variável")
    println("--------------------------")
    println("Valor: ", x)
    println("Tipo: ", typeof(x))
    println("Tamanho em bytes (do objeto array): ", sizeof(x))
    println("Endereço de memória (objeto no heap): ", pointer_from_objref(x))
    println("Endereço do primeiro elemento (dados): ", pointer(x))
    println("--------------------------")
    println("⚠️ Observação:")
    println("  O primeiro endereço acima aponta para o objeto 'Array' em si (estrutura de metadados).")
    println("  Já o segundo endereço aponta para o bloco de memória onde os números [2, 4, 8] estão armazenados.")
end

# ╔═╡ aa0ef774-2069-42ee-8211-075d748b9c95
md""" 

⚠️ **Importante**

Nesse script, a gente beira o tema de administração de memória (um dos temas mais importantes do campo de sistemas operacionais). Eu recomendo a todos interessados explorar um pouco de administração de memória, especialmente na linguagem de programação C — já que esta está por detrás de como memória é administrada em inúmeros outros projetos como Python, Linux, etc. 

Eu tenho a sensação de que entender administração de memória diferencia o programador. Mas isso pode ser uma concepção errada minha...

Em Julia, nós não administramos memória manualmente (pelo menos não por definição), porque Julia tem um **[garbage collector](https://pt.wikipedia.org/wiki/Coletor_de_lixo_(inform%C3%A1tica))** (coletor de lixo) — isto é, um processo que automaticamente cuida da administração de memória para você. Se você quiser saber mais sobre administração de memória, o que se torna relevante quando nós enfrentamos problemas de precisão significativos, veja:

0. [Tutorial Youtube (EN): "Memory Management High Performance Computing (HPC) in Julia"](https://www.youtube.com/watch?v=NrW4SGNBdIY)
1. [Tutorial Youtube (EN): "What are variables?" & other basics](https://www.youtube.com/watch?v=LmP_dc-00SI)
2. [Julia: How variables are stored? (EN)](https://discourse.julialang.org/t/understanding-how-variables-are-stored/46491)
3. [Julia: Understanding memory usage (EN)](https://discourse.julialang.org/t/understanding-memory-usage-in-julia/101647)

⚠️ **Recursos adicionais e gerais sobre memória**

1. [Stack vs. Heap](https://www.geeksforgeeks.org/dsa/stack-vs-heap-memory-allocation/)

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
# ╟─4c79a447-fb0e-4f15-9a68-beb96bbb596b
# ╟─14702fb0-a360-11f0-11a0-b96ecbd2512e
# ╠═57dab13d-634e-4d78-b811-95f31d01d708
# ╟─df8bb3ca-5260-473d-acde-79a41189ca5e
# ╟─502a6f91-dbda-4b99-b8e5-bd9cf05624b8
# ╠═cd1c6865-042a-43a8-8eaa-dcd4e8883982
# ╟─a51bbc6e-6b1f-4756-b83a-bec9f4651f48
# ╠═bea47ada-f306-4928-8ece-11b0989cf48a
# ╟─437614d8-8bbc-43a7-80c0-8f857e2d4f38
# ╟─a21e0838-e961-4574-b219-90ab1f667974
# ╟─4cb9ef6c-7cbb-4ee8-936e-d8cc3348e586
# ╟─489ca8d6-85de-44c1-9cdb-657e3a756509
# ╠═8e59111c-c502-46e8-9e98-f286c3297248
# ╟─aa0ef774-2069-42ee-8211-075d748b9c95
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
