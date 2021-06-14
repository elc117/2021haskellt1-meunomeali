-- Trabalho 1 de Haskell
-- Nome: Álisson Braga Canabarro
import Text.Printf

type Point     = (Float,Float)
type Rect      = (Point,Float,Float)


-- imprime um retângulo
svgRect :: Rect -> String -> String 
svgRect ((x,y),w,h) style = 
  printf "<rect x='%.3f' y='%.3f' width='%.2f' height='%.2f' style='%s' />\n" x y w h style

-- imprime um circulo
svgCircle :: Float -> Float -> Float -> String -> String 
svgCircle x y r style = 
  printf "<circle cx='%.2f' cy='%.2f' r='%.2f' fill='%s' />\n" x y r style

-- String inicial do SVG
svgBegin :: Float -> Float -> String
svgBegin w h = printf "<svg width='%.2f' height='%.2f' xmlns='http://www.w3.org/2000/svg'>\n" w h 

-- String final do SVG
svgEnd :: String
svgEnd = "</svg>"

--------------------- Paleta de cores ---------------------
genReds :: [(Int,Int,Int)]
genReds = map (\red -> ( (if red >= 255 then 255 else red),0,0) ) $ iterate (newRed+) firstRed
  where newRed = 2
        firstRed = 20

genGreen :: [(Int,Int,Int)]
genGreen = map (\green -> ( 0,(if green >= 255 then 255 else green),0) ) $ iterate (newGreen+) firstGreen
  where newGreen = 2
        firstGreen = 20

genBlue :: [(Int,Int,Int)]
genBlue = map (\blue -> ( 0,0,(if blue >= 255 then 255 else blue)) ) $ iterate (newBlue+) firstBlue
  where newBlue = 2
        firstBlue = 20

genPurple :: [(Int,Int,Int)]
genPurple = map (\(red,blue) -> ( (if red >= 255 then 255 else red),0,(if blue >= 255 then 255 else blue)) ) purpleList
  where newColor = 2
        firstRed = 10
        firstBlue = 20
        purpleList = zip (iterate (newColor+) firstRed) (iterate (newColor+) firstBlue)

rainbow :: [(Int,Int,Int)]
rainbow = cycle [r,r,r,o,o,o,y,y,y,g,g,g,b,b,b,p,p,p]
  where r = (255,0,0)
        g = (255,127,0)
        b = (255,255,0)
        y = (0,255,0)
        o = (0,0,255)
        p = (75,0,130)

branco :: [(Int,Int,Int)]
branco = cycle [(255,255,255)]

preto :: [(Int,Int,Int)]
preto = cycle [(0,0,0)]

vermelho :: [(Int,Int,Int)]
vermelho = cycle [(255,0,0)]

verde :: [(Int,Int,Int)]
verde = cycle[(0,255,0)]

azul :: [(Int,Int,Int)]
azul = cycle[(0,0,255)]

amarelo :: [(Int,Int,Int)]
amarelo = cycle[(255,255,0)]

laranja :: [(Int,Int,Int)]
laranja = cycle [(255,100,0)]

-----------------fim paleta de cores -----------------------------

-- cria o fundo da imagem (é um quadrado do tamanho da própria imagem só que colorido)
geraQuad :: Float -> Float -> [Rect]
geraQuad w h  = [((0,0), w, h)]

-- cria o desenho, que é básicamente um 'V' junto de um 'V' invertido
-- pode se escolher o quão aberto, o quão alto e o tamanho de suas linhas
criaV :: Int -> Int -> Int -> [Rect]
-- map pega as as coords (x,y) criadas no "where" e junta com o (w,h) do retângulo (w e h variam de acordo com as
-- entradas, para não ficar muito espaço em branco entre cada retângulo)
criaV largDes altDes numQuad = map (\(x,y) -> ((x*(gap+2*largDes'),y*(gap+2*altDes')),w+largDes',h+altDes')) tuplaXeY
  -- é um "where" gigante, mas antes ficava tudo dentro do "map" de cima, separei em partes pequenas fácil de entender
  where (w,h) = (50,50) -- (w,h) e gap são valores que eu escolhi apenas por achar que encaixavam bem
        gap = 30
        -- apenas mudano a variavel para Float (para não precisar usar "fromIntegral" a todo momento)
        largDes' = fromIntegral largDes
        altDes' = fromIntegral altDes
        numQuad' = fromIntegral numQuad

        -- y variando de 0 a numQuad e de numQuad até 0 para criar um efeito de "V"
        yDesce = [0 ..numQuad']
        ySobe = [numQuad', (numQuad'-1) .. 0]

        -- x indo de 0 até o dobro de numQuad (pois y vai e volta desse valor)
        xDireita = [0.. (2*numQuad'+1)]

        -- x voltando da última posição até 0 (essa parte é desnecessaria para criar o desenho, eu poderia reutilizar
        -- a função anterior, porém eu queria que o efeito de degrade continuasse de onde o outro parou)
        xEsquerda = [((2*numQuad')+1), (2*numQuad')..0]

        -- yDesceSobe cria um 'v' e ySobeDesce cria um '^'
        yDesceSobe = concat [yDesce, ySobe]
        ySobeDesce = concat[ySobe,yDesce]
        -- unindo 'v' com '^'
        yTotal = concat [yDesceSobe,ySobeDesce]

        -- criando as coords [(x,y)]
        tuplaXeY = zip (concat[xDireita,xEsquerda]) yTotal


-- uma das tentativas anteriores, para mostrar como ficava sem o where (cresceu muito mais antes de eu mudar pra map e where):

--genRectsInLine1 :: Int -> Int -> [Rect]
--genRectsInLine1 n aleat = [((m*(25+gap), x*(25+gap)*m), w, h) | m <- [1..fromIntegral (n*n)] , x <- concat [(take n [0 ..fromIntegral aleat]), (take n [fromIntegral aleat,fromIntegral (aleat-1) .. 0])]]
  --where (w,h) = (50,50)
        --gap = 2


--------------------------------------------------------
----- não ler essa parte antes de ver o "README.md" ----
------- e de encontrar ELE (continue na linha 150) -----
--------------------------------------------------------

dHVkbyBlbGUgdsOq :: Int -> Int -> Int -> (Int,Int,Int) -> String
-- só aparece com as entradas certas
dHVkbyBlbGUgdsOq 20 5 10 (r,g,b) = 
  -- essa parte foi todo criada "manualmente", pois são coordenadas fixas, até tentei fazer ele se mover pra acompanhar
  -- o tamanho do desenho dependendo das entradas, mas era dificil achar o cálculo certo então decidi manter fixo.
  svgBegin 2000 2000 ++ 
  (svgCircle 845 280 90 "rgb(0, 0, 0, 1.0)") ++
  (svgCircle 845 280 70 "rgb(255, 0, 0, 1.0)") ++
  (svgCircle 845 280 30 "rgb(0, 0, 0, 1.0)") ++
  printf "<circle cx='845' cy='180' r='60' style='fill:rgb(%d, %d, %d, 1.0)' />\n"r g b ++
  (svgCircle 870 270 10 "rgb(255, 255, 255, 1.0)") ++
  svgBegin 2000 2000 ++
  printf "<text x='80' y='1400' font-size='100' stroke='rgb(255, 0, 0, 1.0)'>Voce encontrou o Espreitador, a unica forma </text>"++
  printf "<text x='200' y='1500' font-size='100' stroke='rgb(255, 0, 0, 1.0)'>de se livrar dele eh me dando nota 10 :)</text>>"++
  svgEnd++
  svgEnd
  -- para qualquer outra entrada não acontece nada
dHVkbyBlbGUgdsOq numQuad largDes altDes (r,g,b)  =
  printf "\n"
--------------------------------------------------------
--------------------------------------------------------
--------------------------------------------------------


-- Estilo definido como cores RGB.
svgStyle :: (Int,Int,Int) -> String
svgStyle (r,g,b) = printf "fill:rgb(%d,%d,%d,1.0)" r g b

-- Gera strings SVG para uma dada lista de figuras e seus atributos de estilo
-- Recebe uma função geradora de strings SVG, uma lista de círculos/retângulos e strings de estilo
svgElements :: (a -> String -> String) -> [a] -> [String] -> String
svgElements func elements styles = concat $ zipWith func elements styles



main :: IO ()
main = do
  writeFile "imagem.svg" $ svgstrs
  where svgstrs = svgBegin w h ++ fundo ++ imagem ++ bmFkYSBlc2NhcGE ++ svgEnd
        imagem = svgElements svgRect rects (map svgStyle corDesenho)
        rects = criaV larguraDesenho alturaDesenho numQuadrados

        -- gera a cor de fundo da imagem (cor sólida do tamanho de w e h)
        fundo = svgElements svgRect quadFundo (map svgStyle corFundo)
        quadFundo = geraQuad w h

        -- (???)
        bmFkYSBlc2NhcGE = dHVkbyBlbGUgdsOq numQuadrados larguraDesenho alturaDesenho (head corFundo)


        -- cor de fundo do desenho
        --------------possibilidades--------------
        --  -branco =     fundo branco          --
        --  -preto =      fundo preto           --
        --  -vermelho =   apenas vermelho       --
        --  -verde =      apenas verde          --
        --  -azul =       apenas azul           --
        --  -amarelo =    apenas amarelo        --
        --  -laranja =    apenas laranja        --
        ---------- fim cores de fundo -------------

        -- cor do desenho
        --------------possibilidades---------------
        --  - genReds =    degrade de vermelho   --
        --  - genPurple =  degrade roxo          --
        --  - genGreen =   degrade verde         --
        --  - genBlue =    degrade azul          --
        --  - rainbow =    colorido              --
        --  - todas cores sólidas de "corFundo"  --
        ----------- fim cores do desenho ----------

        -- escolher da lista "cor de fundo do desenho"
        corFundo = branco
        -- escolher da lista "cor do desenho"
        corDesenho = genPurple
        
        -- os valores podem parecer confusos de começo, mas é fácil notar o que cada um faz ao mudar seu valor:
        
        -- define quantos quadrados tera cada linha
        numQuadrados = 21
        -- define a largura do desenho
        larguraDesenho = 5
        -- define a altura do desenho
        alturaDesenho = 10

        (w,h) = (2000,2000) -- width,height da imagem SVG