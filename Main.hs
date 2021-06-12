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

-- apenas testando, mudar de cor no futuro
genReds :: [(Int,Int,Int)]
genReds = map (\red -> ( (if red >= 255 then 255 else red),0,0) ) $ iterate (newRed+) firstRed
  where newRed = 10
        firstRed = 5


genRectsInLine2 :: Int -> Int -> Int -> [Rect]
genRectsInLine2 largDes altDes numQuad = map (\(x,y) -> ((x*(30+2*largDes'),y*(30+2*altDes')),w,h)) tuplaXeY
  where (w,h) = (50,50)
        largDes' = fromIntegral largDes
        altDes' = fromIntegral altDes
        numQuad' = fromIntegral numQuad
        yDesce = [0 ..numQuad']
        ySobe = [numQuad', (numQuad'-1) .. 0]
        xDireita = [0.. (2*numQuad'+1)]
        xEsquerda = [((2*numQuad')+1), (2*numQuad')..0]
        yDesceSobe = concat [yDesce, ySobe]
        ySobeDesce = concat[ySobe,yDesce]
        yTotal = concat [yDesceSobe,ySobeDesce]
        tuplaXeY = zip (concat[xDireita,xEsquerda]) yTotal


-- coordenadas de cada retângulo
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
  where svgstrs = svgBegin w h ++ svgfigs1 ++ svgEnd
        -- tons de vermelho
        svgfigs1 = svgElements svgRect rects1 (map svgStyle palette1)
        rects1 = genRectsInLine2 larguraDesenho alturaDesenho numQuadrados
        palette1 = genReds

        numQuadrados = 10
        larguraDesenho = 2
        alturaDesenho = 10

        (w,h) = (2000,2000) -- width,height da imagem SVG