local ls = require("luasnip")
-- local s = ls.snippet
-- local t = ls.text_node
-- local i = ls.insert_node
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local f = ls.function_node

-- Conditions
local function in_math()
  local ok, res = pcall(function()
    return vim.fn["vimtex#syntax#in_mathzone"]() == 1
  end)
  return ok and res
end
local function in_text()
  return not in_math()
end

local conds = require("luasnip.extras.conditions.expand")
local function both(...)
  local funcs = { ... }
  return function(...)
    for _, fn in ipairs(funcs) do
      if not fn(...) then
        return false
      end
    end
    return true
  end
end
local line_begin = conds.line_begin

-- Helper to insert the visual selection when present.
local function SELECTED(_, snip)
  return snip.env.SELECT_RAW or ""
end

return {
  -- BEGIN logic
  ls.parser.parse_snippet({ trig = "lor", snippetType = "autosnippet", condition = in_math }, [[\lor $1]]),
  ls.parser.parse_snippet({ trig = "land", snippetType = "autosnippet", condition = in_math }, [[\land $1]]),
  -- END logic
  ls.parser.parse_snippet(
    { trig = "emphh", dscr = "\\emph{}", snippetType = "autosnippet", condition = in_text },
    [[\emph{$1} $0]]
  ),
  -- END text
  -- BEGIN environments
  ls.parser.parse_snippet(
    { trig = "proof", dscr = "begin{proof} / end{proof}", snippetType = "autosnippet", condition = line_begin },
    [[\\begin{proof}
    $1
\\end{proof}]]
  ),
  ls.parser.parse_snippet(
    { trig = "beg", dscr = "begin{} / end{}", snippetType = "autosnippet", condition = line_begin },
    [[\\begin{$1}
	$0
\\end{$1}]]
  ),
  ls.parser.parse_snippet(
    { trig = "sol", dscr = "begin{solution} / end{solution}", snippetType = "autosnippet", condition = line_begin },
    [[\\begin{solution}
	$1
\\end{solution}]]
  ),
  ls.parser.parse_snippet(
    { trig = "exr", dscr = "begin{exercise} / end{exercise}", snippetType = "autosnippet", condition = line_begin },
    [[\\begin{exercise}
	$1
\\end{exercise}
$0]]
  ),
  ls.parser.parse_snippet(
    { trig = "prop", snippetType = "autosnippet", condition = line_begin },
    [[\\begin{proposition}
	$1
\\end{proposition}
$0]]
  ),
  ls.parser.parse_snippet(
    { trig = "exm", snippetType = "autosnippet", condition = line_begin },
    [[\\begin{example}
	$1
\\end{example}
$0]]
  ),
  ls.parser.parse_snippet(
    { trig = "thm", dscr = "begin{theorem} / end{theorem}", snippetType = "autosnippet", condition = line_begin },
    [[\\begin{theorem}[$1]
	$2
\\end{theorem}$0]]
  ),
  ls.parser.parse_snippet(
    { trig = "insg", dscr = "begin{inisight} / end{insight}", snippetType = "autosnippet", condition = line_begin },
    [[\\begin{insight}[$1]
	$2
\\end{insight}$0]]
  ),
  ls.parser.parse_snippet(
    { trig = "def", snippetType = "autosnippet", condition = line_begin },
    [[\\begin{definition}[$1]
	$2
\\end{definition}$0]]
  ),
  ls.parser.parse_snippet(
    { trig = "lemma", snippetType = "autosnippet", condition = line_begin },
    [[\\begin{lemma}[$1]
	$2
\\end{lemma}$0]]
  ),
  -- END environments
  -- BEGIN highlight
  ls.parser.parse_snippet(
    { trig = "yhl", dscr = "highlight yellow", snippetType = "autosnippet", condition = in_text },
    [[\ihlyellow{${1}}$0]]
  ),
  ls.parser.parse_snippet(
    { trig = "rhl", dscr = "highlight yellow", snippetType = "autosnippet", condition = in_text },
    [[\ihlred{${1}}$0]]
  ),
  ls.parser.parse_snippet(
    { trig = "bhl", dscr = "highlight yellow", snippetType = "autosnippet", condition = in_text },
    [[\ihlblue{${1}}$0]]
  ),
  -- END highlight
  ls.parser.parse_snippet(
    { trig = "ee", dscr = "epislon", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\epsilon ]]
  ),
  --ls.parser.parse_snippet(
  --  { trig = "(", dscr = "()", wordTrig = false, snippetType = "autosnippet", condition = in_math },
  --  [[($1)$0]]
  --),
  ls.parser.parse_snippet({ trig = "...", dscr = "ldots", wordTrig = false, snippetType = "autosnippet" }, [[\ldots]]),
  ls.parser.parse_snippet(
    { trig = "table", dscr = "Table environment", condition = line_begin },
    [[\begin{table}[${1:htpb}]
	\centering
	\caption{${2:caption}}
	\label{tab:${3:label}}
	\begin{tabular}{${5:c}}
	$0${5/((?<=.)c|l|r)|./(?1: & )/g}
	\end{tabular}
\end{table}]]
  ),
  ls.parser.parse_snippet(
    { trig = "fig", dscr = "Figure environment", condition = line_begin },
    [[\begin{figure}[${1:htpb}]
	\centering
	${2:\includegraphics[width=0.8\textwidth]{$3}}
	\caption{${4:$3}}
	\label{fig:${5:${3/\W+/-/g}}}
\end{figure}]]
  ),
  ls.parser.parse_snippet(
    { trig = "enum", dscr = "Enumerate", snippetType = "autosnippet", condition = line_begin },
    [[\begin{enumerate}
	\item $0
\end{enumerate}]]
  ),
  ls.parser.parse_snippet(
    { trig = "aenum", dscr = "Enumerate", snippetType = "autosnippet", condition = line_begin },
    [[\begin{enumerate}{\alpha*)}
	\item $0
\end{enumerate}]]
  ),
  ls.parser.parse_snippet(
    { trig = "item", dscr = "Itemize", snippetType = "autosnippet", condition = line_begin },
    [[\begin{itemize}
	\item $0
\end{itemize}]]
  ),
  ls.parser.parse_snippet(
    { trig = "desc", dscr = "Description", condition = line_begin },
    [[\begin{description}
	\item[$1] $0
\end{description}]]
  ),
  ls.parser.parse_snippet(
    { trig = "=>", dscr = "implies", wordTrig = false, snippetType = "autosnippet" },
    [[\implies]]
  ),
  ls.parser.parse_snippet(
    { trig = "=<", dscr = "implied by", wordTrig = false, snippetType = "autosnippet" },
    [[\impliedby]]
  ),
  ls.parser.parse_snippet(
    { trig = "iff", dscr = "iff", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\iff]]
  ),
  ls.parser.parse_snippet(
    { trig = "mk", dscr = "Math", snippetType = "autosnippet", condition = in_text },
    [[$${1}$ $2]]
  ),
  ls.parser.parse_snippet(
    { trig = "dm", dscr = "Math", snippetType = "autosnippet", condition = in_text },
    [[\[
    $1
\] $0]]
  ),
  ls.parser.parse_snippet(
    { trig = "ali", dscr = "Align", snippetType = "autosnippet", condition = both(in_math, line_begin) },
    [[\begin{align*}
.\end{align*}]]
  ),
  ls.parser.parse_snippet(
    { trig = "//", dscr = "Fraction", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\\frac{$1}{$2}$0]]
  ),
  ls.parser.parse_snippet(
    { trig = "/", dscr = "Fraction", wordTrig = false, condition = in_math },
    [[\\frac{${VISUAL}}{$1}$0]]
  ),
  ls.parser.parse_snippet({
    trig = "'((\\d+)|(\\d*)(\\\\)?([A-Za-z]+)((\\^|_)(\\{\\d+\\}|\\d))*)/'",
    dscr = "symbol frac",
    regTrig = true,
    snippetType = "autosnippet",
    condition = in_math,
  }, [[\\frac{ }{$1}$0]]),
  ls.parser.parse_snippet(
    { trig = "'^.*\\)/'", dscr = "() frac", regTrig = true, snippetType = "autosnippet", condition = in_math },
    [[ {$1}$0]]
  ),
  ls.parser.parse_snippet({
    trig = "'([A-Za-z])(\\d)'",
    dscr = "auto subscript",
    regTrig = true,
    snippetType = "autosnippet",
    condition = in_math,
  }, [[ _ ]]),
  ls.parser.parse_snippet({
    trig = "'([A-Za-z])_(\\d\\d)'",
    dscr = "auto subscript2",
    regTrig = true,
    snippetType = "autosnippet",
    condition = in_math,
  }, [[ _{ }]]),
  ls.parser.parse_snippet(
    { trig = "==", dscr = "equals", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[&= $1 \\\\]]
  ),
  ls.parser.parse_snippet(
    { trig = "!=", dscr = "equals", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\neq ]]
  ),
  ls.parser.parse_snippet(
    { trig = "ceil", dscr = "ceil", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\left\lceil $1 \right\rceil $0]]
  ),
  ls.parser.parse_snippet(
    { trig = "floor", dscr = "floor", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\left\lfloor $1 \right\rfloor$0]]
  ),
  ls.parser.parse_snippet(
    { trig = "pmat", dscr = "pmat", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\begin{pmatrix} $1 \end{pmatrix} $0]]
  ),
  ls.parser.parse_snippet(
    { trig = "bmat", dscr = "bmat", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\begin{bmatrix} $1 \end{bmatrix} $0]]
  ),
  ls.parser.parse_snippet(
    { trig = "lr", dscr = "left( right)", wordTrig = false, condition = in_math },
    [[\left( $1 \right) $0]]
  ),
  ls.parser.parse_snippet(
    { trig = "lr{", dscr = "left\\{ right\\}", wordTrig = false, condition = in_math },
    [[\left\\{ $1 \right\\} $0]]
  ),
  ls.parser.parse_snippet(
    { trig = "lr[", dscr = "left[ right]", wordTrig = false, condition = in_math },
    [[\left[ $1 \right] $0]]
  ),
  ls.parser.parse_snippet(
    { trig = "lra", dscr = "leftangle rightangle", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\left<$1 \right>$0]]
  ),
  ls.parser.parse_snippet(
    { trig = "conj", dscr = "conjugate", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\overline{$1}$0]]
  ),
  ls.parser.parse_snippet(
    { trig = "sum", dscr = "sum", condition = in_math },
    [[\sum_{n=${1:1}}^{${2:\infty}} ${3:a_n z^n}]]
  ),
  ls.parser.parse_snippet(
    { trig = "taylor", dscr = "taylor", condition = in_math },
    [[\sum_{${1:k}=${2:0}}^{${3:\infty}} ${4:c_$1} (x-a)^$1 $0]]
  ),
  ls.parser.parse_snippet({ trig = "lim", dscr = "limit", condition = in_math }, [[\lim_{${1:n} \to ${2:\infty}} ]]),
  ls.parser.parse_snippet(
    { trig = "limsup", dscr = "limsup", condition = in_math },
    [[\limsup_{${1:n} \to ${2:\infty}} ]]
  ),
  ls.parser.parse_snippet(
    { trig = "prod", dscr = "product", condition = in_math },
    [[\prod_{${1:n=${2:1}}}^{${3:\infty}} ${4:${VISUAL}} $0]]
  ),
  ls.parser.parse_snippet(
    { trig = "part", dscr = "d/dx", condition = in_math },
    [[\frac{\partial ${1:V}}{\partial ${2:x}} $0]]
  ),
  ls.parser.parse_snippet(
    { trig = "sq", dscr = "\\sqrt{}", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\sqrt{$1} $0]]
  ),
  ls.parser.parse_snippet(
    { trig = "sr", dscr = "^2", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[^2]]
  ),
  ls.parser.parse_snippet(
    { trig = "cb", dscr = "^3", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[^3]]
  ),
  ls.parser.parse_snippet(
    { trig = "td", dscr = "to the ... power", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[^{$1}$0]]
  ),
  ls.parser.parse_snippet(
    { trig = "rd", dscr = "to the ... power", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[^{($1)}$0]]
  ),
  ls.parser.parse_snippet(
    { trig = "__", dscr = "subscript", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[_{$1}$0]]
  ),
  ls.parser.parse_snippet(
    { trig = "ooo", dscr = "\\infty", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\infty]]
  ),
  ls.parser.parse_snippet(
    { trig = "rij", dscr = "mrij", wordTrig = false, condition = in_math },
    [[(${1:x}_${2:n})_{${3:$2}\\in${4:\\N}}$0]]
  ),
  ls.parser.parse_snippet(
    { trig = "leq", dscr = "leq", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\leq ]]
  ),
  ls.parser.parse_snippet(
    { trig = "geq", dscr = "geq", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\geq ]]
  ),
  ls.parser.parse_snippet(
    { trig = "EE", dscr = "geq", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\exists ]]
  ),
  ls.parser.parse_snippet(
    { trig = "AA", dscr = "forall", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\forall ]]
  ),
  ls.parser.parse_snippet(
    { trig = "xnn", dscr = "xn", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[x_{n}]]
  ),
  ls.parser.parse_snippet(
    { trig = "ynn", dscr = "yn", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[y_{n}]]
  ),
  ls.parser.parse_snippet(
    { trig = "xii", dscr = "xi", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[x_{i}]]
  ),
  ls.parser.parse_snippet(
    { trig = "yii", dscr = "yi", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[y_{i}]]
  ),
  ls.parser.parse_snippet(
    { trig = "xjj", dscr = "xj", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[x_{j}]]
  ),
  ls.parser.parse_snippet(
    { trig = "yjj", dscr = "yj", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[y_{j}]]
  ),
  ls.parser.parse_snippet(
    { trig = "xp1", dscr = "x", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[x_{n+1}]]
  ),
  ls.parser.parse_snippet(
    { trig = "xmm", dscr = "x", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[x_{m}]]
  ),
  ls.parser.parse_snippet(
    { trig = "R0+", dscr = "R0+", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\\R_0^+]]
  ),
  ls.parser.parse_snippet(
    { trig = "plot", dscr = "Plot", condition = in_math },
    [[\begin{figure}[$1]
	\centering
	\begin{tikzpicture}
		\begin{axis}[
			xmin= ${2:-10}, xmax= ${3:10},
			ymin= ${4:-10}, ymax = ${5:10},
			axis lines = middle,
		]
			\addplot[domain=$2:$3, samples=${6:100}]{$7};
		\end{axis}
	\end{tikzpicture}
	\caption{$8}
	\label{${9:$8}}
\end{figure}]]
  ),
  ls.parser.parse_snippet(
    { trig = "nn", dscr = "Tikz node", condition = in_math },
    [[\node[$5] (${1/[^0-9a-zA-Z]//g}${2}) ${3:at (${4:0,0}) }{$${1}$};
$0]]
  ),
  ls.parser.parse_snippet(
    { trig = "mcal", dscr = "mathcal", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\mathcal{$1}$0]]
  ),
  ls.parser.parse_snippet(
    { trig = "lll", dscr = "l", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\ell]]
  ),
  ls.parser.parse_snippet(
    { trig = "nabl", dscr = "nabla", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\nabla ]]
  ),
  ls.parser.parse_snippet(
    { trig = "xx", dscr = "cross", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\times ]]
  ),
  ls.parser.parse_snippet(
    { trig = "**", dscr = "cdot", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\cdot ]]
  ),
  ls.parser.parse_snippet(
    { trig = "norm", dscr = "norm", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\norm{$1}$0]]
  ),
  ls.parser.parse_snippet(
    { trig = "ip", dscr = "inner product", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\ip{$1}$0]]
  ),
  ls.parser.parse_snippet(
    { trig = ":=", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\coloneqq]]
  ),
  ls.parser.parse_snippet({
    trig = "'(?<!\\\\)(sin|cos|arccot|cot|csc|ln|log|exp|star|perp)'",
    dscr = "ln",
    regTrig = true,
    snippetType = "autosnippet",
    condition = in_math,
  }, [[\\ ]]),
  ls.parser.parse_snippet(
    { trig = "dint", dscr = "integral", snippetType = "autosnippet", condition = in_math },
    [[\int_{${1:-\infty}}^{${2:\infty}} ${3:${VISUAL}} $0]]
  ),
  ls.parser.parse_snippet({
    trig = "'(?<!\\\\)(arcsin|arccos|arctan|arccot|arccsc|arcsec|pi|zeta|int)'",
    dscr = "ln",
    regTrig = true,
    snippetType = "autosnippet",
    condition = in_math,
  }, [[\\ ]]),
  ls.parser.parse_snippet(
    { trig = "->", dscr = "to", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\to ]]
  ),
  ls.parser.parse_snippet(
    { trig = "<->", dscr = "leftrightarrow", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\leftrightarrow]]
  ),
  ls.parser.parse_snippet(
    { trig = "!>", dscr = "mapsto", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\mapsto ]]
  ),
  ls.parser.parse_snippet(
    { trig = "invs", dscr = "inverse", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[^{-1}]]
  ),
  ls.parser.parse_snippet(
    { trig = "compl", dscr = "complement", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[^{c}]]
  ),
  ls.parser.parse_snippet(
    { trig = "\\\\\\", dscr = "setminus", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\setminus]]
  ),
  ls.parser.parse_snippet(
    { trig = ">>", dscr = ">>", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\gg]]
  ),
  ls.parser.parse_snippet(
    { trig = "<<", dscr = "<<", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\ll]]
  ),
  ls.parser.parse_snippet(
    { trig = "~~", dscr = "~", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\sim ]]
  ),
  ls.parser.parse_snippet(
    { trig = "set", dscr = "set", snippetType = "autosnippet", condition = in_math },
    [[\\{$1\\} $0]]
  ),
  ls.parser.parse_snippet(
    { trig = "||", dscr = "mid", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[ \mid ]]
  ),
  ls.parser.parse_snippet(
    { trig = "cq", dscr = "subset", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\subseteq ]]
  ),
  ls.parser.parse_snippet(
    { trig = "cc", dscr = "subset", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\subset ]]
  ),
  ls.parser.parse_snippet(
    { trig = "notin", dscr = "not in ", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\not\in ]]
  ),
  ls.parser.parse_snippet(
    { trig = "inn", dscr = "in ", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\in ]]
  ),
  ls.parser.parse_snippet(
    { trig = "NN", dscr = "n", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\N]]
  ),
  ls.parser.parse_snippet(
    { trig = "Nn", dscr = "cap", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\cap ]]
  ),
  ls.parser.parse_snippet(
    { trig = "UU", dscr = "cup", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\cup ]]
  ),
  ls.parser.parse_snippet(
    { trig = "uuu", dscr = "bigcup", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\bigcup_{${1:i \in ${2: I}}} $0]]
  ),
  ls.parser.parse_snippet(
    { trig = "nnn", dscr = "bigcap", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\bigcap_{${1:i \in ${2: I}}} $0]]
  ),
  ls.parser.parse_snippet(
    { trig = "OO", dscr = "emptyset", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\O]]
  ),
  ls.parser.parse_snippet(
    { trig = "RR", dscr = "real", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\R]]
  ),
  ls.parser.parse_snippet(
    { trig = "QQ", dscr = "Q", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\Q]]
  ),
  ls.parser.parse_snippet(
    { trig = "ZZ", dscr = "Z", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\Z]]
  ),
  ls.parser.parse_snippet(
    { trig = "<!", dscr = "normal", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\triangleleft ]]
  ),
  ls.parser.parse_snippet(
    { trig = "<>", dscr = "hokje", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\diamond ]]
  ),
  ls.parser.parse_snippet({
    trig = "'(?<!i)sts'",
    dscr = "text subscript",
    wordTrig = false,
    regTrig = true,
    snippetType = "autosnippet",
    condition = in_math,
  }, [[_\text{$1} $0]]),
  ls.parser.parse_snippet(
    { trig = "tt", dscr = "text", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\text{$1}$0]]
  ),
  ls.parser.parse_snippet(
    { trig = "case", dscr = "cases", snippetType = "autosnippet", condition = in_math },
    [[\begin{cases}
	$1
\end{cases}]]
  ),
  ls.parser.parse_snippet(
    { trig = "SI", dscr = "SI", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\SI{$1}{$2}]]
  ),
  ls.parser.parse_snippet(
    { trig = "bigfun", dscr = "Big function", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\begin{align*}
	$1: $2 &\longrightarrow $3 \\\\
	$4 &\longmapsto $1($4) = $0
.\end{align*}]]
  ),
  ls.parser.parse_snippet(
    { trig = "cvec", dscr = "column vector", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\begin{pmatrix} ${1:x}_${2:1}\\\\ \vdots\\\\ $1_${2:n} \end{pmatrix}]]
  ),
  ls.parser.parse_snippet(
    { trig = '"bar"', dscr = "bar", wordTrig = false, regTrig = true, snippetType = "autosnippet", condition = in_math },
    [[\overline{$1}$0]]
  ),
  ls.parser.parse_snippet({
    trig = '"([a-zA-Z])bar"',
    dscr = "bar",
    wordTrig = false,
    regTrig = true,
    snippetType = "autosnippet",
    condition = in_math,
  }, [[\overline{ }]]),
  ls.parser.parse_snippet(
    { trig = '"hat"', dscr = "hat", wordTrig = false, regTrig = true, snippetType = "autosnippet", condition = in_math },
    [[\hat{$1}$0]]
  ),
  ls.parser.parse_snippet({
    trig = '"([a-zA-Z])hat"',
    dscr = "hat",
    wordTrig = false,
    regTrig = true,
    snippetType = "autosnippet",
    condition = in_math,
  }, [[\hat{ }]]),
  ls.parser.parse_snippet(
    { trig = "letw", dscr = "let omega", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[Let $\Omega \subset \C$ be open.]]
  ),
  ls.parser.parse_snippet(
    { trig = "HH", dscr = "H", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\mathbb{H}]]
  ),
  ls.parser.parse_snippet(
    { trig = "DD", dscr = "D", wordTrig = false, snippetType = "autosnippet", condition = in_math },
    [[\mathbb{D}]]
  ),
}
