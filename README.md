(Leia tudo antes de ver o código)

O que cada função importante do código faz já está comentada no próprio código,
por esse motivo não irei repeti-las aqui.

--Importante--  

É recomendado não ler o trecho do código entre as linhas 134 e 155 pois essa é a parte
do EsterEgg da imagem, pelo menos não leia antes de se encontrar com ELE (você saberá quem
é quando encontrá-lo) -- byBFc3ByZWl0YWRvciBlc3BlcmEgcG9yIHZvY8Oq  
Obs.: você é a professora, então pode só ignorar isso de EsterEgg, mas vai perder a graça da imagem

--Funcionamento--  

A main se encontra na linha 169 e os valores que o usuário pode mudar se encontram nela, são eles:

- corFundo (linha 206) = essa função serve para escolher qual cor será o fundo da imagem, você
pode encontrar uma tabela de cores disponiveis na linha 184;

- corDesenho (linha 208) = essa função serve para escolher qual cor será o desenho, você
pode encontrar sua tabela de cores na linha 195 (permite utilizar cores da lista "corFundo")

- numQuadrados (linha 213) = define qual será o tamano do desenho "V", ou seja, quantos retângulos
lhe formarão;

- larguraDesenho (linha 215) = define o quão largo será o "V" (básicamente diz o quão aberta as
"perninhas" do "V" vão estar);

- alturaDesenho (linha 217) = define o quão alto o "V" será.

- (w,h) (última linha) = define o tamanho da imagem (para o EsterEgg recomenda-se tamanho mínimo de 1900 por 1600)

--EsterEgg--  

Ao ler o código é possivel encontrar algumas funções com uma sequências estranhas de caracteres como por
exemplo: "b2kgcHJvZiA8Mw", não é algo aleatório (o que será que significam ?).
Se você quiser ver o potêncial máximo da imagem, precisa encontrar ELE primeiro. Você só irá encontrá-lo
se colocar valores especificos em "numQuadrados", "larguraDesenho" e "alturaDesenho", são eles:  
numQuadrados = ( 4 vezes a metade de alturaDesenho )  
larguraDesenho = ( (alturaDesenho + numQuadrados - (2*alturaDesenho)) / 2 )  
alturaDesenho = 10  
Obs.: se quiser pode só pular para respostas no próximo tópico (sei que tem vários trabalhos para corrigir)  
  
  
  
  
--Respostas--  

(Espero que tenha tentado resolver(e conseguido), mas entendo se não quis)
Para que ELE apareça na imagem, basta definir os valores de "numQuadrados", "larguraDesenho" e "alturaDesenho"
dessa forma:  
numQuadrados = 20  
larguraDesenho = 5  
alturaDesenho = 10  
É apenas um olho, nada de mais (mas demorou pra fazer hein), só fiz para ter algum diferencial no trabalho ao
invés de apenas escolher cores e tamanhos.  
Os códigos estranhos estão codificados em "Base64", mas não tem nada de mais escrito, por exemplo o "b2kgcHJvZiA8Mw"
dizia "oi prof <3"
