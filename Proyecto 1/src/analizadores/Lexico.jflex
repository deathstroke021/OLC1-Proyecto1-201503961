package analizadores;
import java_cup.runtime.*;

%%

%class Lexico
%cupsym sym
%cup 
%public
%unicode
%line 
%column
%ignorecase

%init{ 
    
%init}

/*
2.65, 2.5, 100
*, +, -, /
2+5+4*3-2/1
              +
           5      *
                4   3

*/

blancos = [ \t\r\n]+

//letras
letra = [a-zA-Z]
entero = [0-9]+  //0,1,2,3,4,5,6,7,8,9 -> 1111, 125
decimal = [0-9]+ "." [0-9]+
//suma = "+"

//Identificadores
nombre = {letra}+

%{
    
%}

%%

//"(" {return new Symbol(sym.aparen,yycolumn,yyline,yytext());}
//")" {return new Symbol(sym.cparen,yycolumn,yyline,yytext());}
//"," {return new Symbol(sym.comaa,yycolumn,yyline,yytext());}
//"," {return new Symbol(sym.comaa,yycolumn,yyline,yytext());}
"+" {return new Symbol(sym.suma,yycolumn,yyline,yytext());}
"-" {return new Symbol(sym.resta,yycolumn,yyline,yytext());}
"*" {return new Symbol(sym.mult,yycolumn,yyline,yytext());}
"/" {return new Symbol(sym.div,yycolumn,yyline,yytext());}

\n {yycolumn=1;}
{blancos} {/*Se ignoran*/}
//45+98
{nombre} {return new Symbol(sym.nombre,yycolumn,yyline,yytext());}
{entero} {return new Symbol(sym.entero,yycolumn,yyline,yytext());} // almacenando un valor entero en la tabla de simbolos
{decimal} {return new Symbol(sym.decimal,yycolumn,yyline,yytext());}


//CUALQUIER ERROR:           SIMBOLOS NO DEFINIDOS DENTRO DEL LENGUAJE
.   {
	    System.err.println("Error lexico: "+yytext()+ " Linea:"+(yyline)+" Columna:"+(yycolumn));
    }

/*   . {
    addError("tipo lexico", yytext(), yyline, yycolumn)

}

class name{

}

{

}

*/

