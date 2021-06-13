-- testando

import Text.Printf

type Point     = (Float,Float)
type Rect      = (Point,Float,Float)


svgRect :: Rect -> String -> String 
svgRect ((x,y),w,h) style = 
  printf "<rect x='%.3f' y='%.3f' width='%.2f' height='%.2f' style='%s' />\n" x y w h style

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

genPurple :: [(Int,Int,Int)]
genPurple = map (\(red,blue) -> ( (if red >= 255 then 255 else red),0,(if blue >= 255 then 255 else blue)) ) purpleList
  where newColor = 2
        firstRed = 10
        firstBlue = 20
        purpleList = zip (iterate (newColor+) firstRed) (iterate (newColor+) firstBlue)

branco :: [(Int,Int,Int)]
branco = cycle [(255,255,255)]

preto :: [(Int,Int,Int)]
preto = cycle [(0,0,0)]

--------------------------------------------------------
geraQuad :: Float -> Float -> [Rect]
geraQuad w h  = [((0,0), w, h)]

genRectsInLine2 :: Int -> Int -> Int -> [Rect]
-- map pega as as coords (x,y) (criadas no "where") e juntando com o (w,h) do retângulo.
genRectsInLine2 largDes altDes numQuad = map (\(x,y) -> ((x*(gap+2*largDes'),y*(gap+2*altDes')),w+largDes',h+altDes')) tuplaXeY
  -- é um "where" gigante, mas antes ficava tudo dentro do "map" de cima, separei em partes pequenas fácil de entender
  where (w,h) = (50,50)
        gap = 30
        -- apenas mudano a variavel para Float (para nao precisar usar "fromIntegral" a todo momento)
        largDes' = fromIntegral largDes
        altDes' = fromIntegral altDes
        numQuad' = fromIntegral numQuad

        -- y variando de 0 a numQuad e de numQuad até 0 para criar um efeito de "onda"
        yDesce = [0 ..numQuad']
        ySobe = [numQuad', (numQuad'-1) .. 0]

        -- x indo de 0 até o dobro de numQuad (pois y vai e volta desse valor)
        xDireita = [0.. (2*numQuad'+1)]
        -- x voltando da última posição até 0 (essa parte é desnecessaria para criar o desenho, eu poderia utilizar
        -- a função anterior, porém eu queria que o efeito de degrade continuasse de onde o outro parou)
        xEsquerda = [((2*numQuad')+1), (2*numQuad')..0]

        -- yDesceSobe cria um 'v' e ySobeDesce cria um '^'
        yDesceSobe = concat [yDesce, ySobe]
        ySobeDesce = concat[ySobe,yDesce]
        -- unindo 'v' com '^'
        yTotal = concat [yDesceSobe,ySobeDesce]

        -- criando as coords (x,y)
        tuplaXeY = zip (concat[xDireita,xEsquerda]) yTotal


-- uma das tentativas anteriores, para mostrar como ficavam as coisas (quando adicionei mais entradas ficou bem maior com map):

--genRectsInLine1 :: Int -> Int -> [Rect]
--genRectsInLine1 n aleat = [((m*(25+gap), x*(25+gap)*m), w, h) | m <- [1..fromIntegral (n*n)] , x <- concat [(take n [0 ..fromIntegral aleat]), (take n [fromIntegral aleat,fromIntegral (aleat-1) .. 0])]]
  --where (w,h) = (50,50)
        --gap = 2


-- Estilo definido como cores RGB.
svgStyle :: (Int,Int,Int) -> String
svgStyle (r,g,b) = printf "fill:rgb(%d,%d,%d,1.0)" r g b

-- Gera strings SVG para uma dada lista de figuras e seus atributos de estilo
-- Recebe uma função geradora de strings SVG, uma lista de círculos/retângulos e strings de estilo
svgElements :: (a -> String -> String) -> [a] -> [String] -> String
svgElements func elements styles = concat $ zipWith func elements styles



main :: IO ()
main = do
  writeFile "teste.svg" $ svgstrs
  where svgstrs = svgBegin w h ++ fundo ++ svgfigs1 ++ svgEnd
        svgfigs1 = svgElements svgRect rects1 (map svgStyle palette1)
        rects1 = genRectsInLine2 larguraDesenho alturaDesenho numQuadrados

        fundo = svgElements svgRect quadFundo (map svgStyle corFundo)
        quadFundo = geraQuad w h

        -- cor do desenho
        --------------possibilidades--------------
        --  -genReds = degrade de vermelho      --
        --  -genPurple = degrade roxo           --
        --  -branco = apenas branco             --
        --  -preto = apenas preto               --
        --  -
        --
        palette1 = genPurple

        -- cor de fundo
        --------------possibilidades--------------
        --  -branco = apenas branco             --

        corFundo = branco

        -- os valores podem parecer confusos de começo, mas é fácil notar o que cada um faz ao mudar seu valor
        -- define quantos quadrados tera cada linha
        numQuadrados = 20
        -- define a largura do desenho
        larguraDesenho = 5
        -- define a altura do desenho
        alturaDesenho = 10

        (w,h) = (2000,2000) -- width,height da imagem SVG, também usado para definir a cor de fundo