package analizadores;
import java_cup.runtime.*;
import proyecto.*;

%%

%{
    String cadena="";

%}

%class Lexico
%cupsym sym
%cup
%state STRNG STRNG2 STRNG3 COMENT_SIMPLE COMENT_MULTI 
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
espacios = [ \t\r]+

//letras
letra = [a-zA-Z]
entero = [0-9]+  //0,1,2,3,4,5,6,7,8,9 -> 1111, 125
decimal = [0-9]+ "." [0-9]+
id ={letra}({letra}|"_"|[0-9])*
simbolo = [!-}]
cadena1 = "\"" ({letra}|{entero}|{simbolo}|{espacios})* "\""
cadena2 = "\”" ({letra}|{entero}|{simbolo}|{espacios})* "\”"
cadena3 = "\'" ({letra}|{entero}|{simbolo}|{espacios})* "\'"
cadena = {cadena1}|{cadena2}|{cadena3}
//suma = "+"

//Identificadores
//nombre = {letra}+

%{
    public void AddError(String tipo, String lexema, int fila, int columna){
        Errores nuevoE= new Errores(tipo, lexema, fila+1, columna+1);
        proyecto.Interfaz.listaErrores.add(nuevoE);
    }
%}

%%

/*<STRNG>{
    [\"] {  String temporal=cadena; cadena=""; yybegin(YYINITIAL);
        System.out.println("\"" + temporal + "\"" );
        return new Symbol(sym.cadena, yycolumn,yyline, temporal);   }
    [^\"] { cadena+=yytext(); }
}

<STRNG2>{
    [\”] {  String temporal=cadena; cadena=""; yybegin(YYINITIAL);
        System.out.println("\"" + temporal + "\"" );
        return new Symbol(sym.cadena, yycolumn,yyline,temporal);   }
    [^\”] { cadena+=yytext(); }
}

<STRNG3>{
    [\'] {  String temporal=cadena; cadena=""; yybegin(YYINITIAL);
        System.out.println("\'" + temporal + "\'" );
        return new Symbol(sym.cadena, yycolumn,yyline,temporal);   }
    [^\'] { cadena+=yytext(); }
}*/

<YYINITIAL> "<!"                {yybegin(COMENT_MULTI);}     // Si la entrada es un comentario inicia aqui
<COMENT_MULTI> "!>"             {yybegin(YYINITIAL);}        // Si se acaba el comentario vuelve a YYINITIAL
<COMENT_MULTI> .                {}
<COMENT_MULTI> [ \t\r\n\f]      {}

<YYINITIAL> "//"                {yybegin(COMENT_SIMPLE);}   // Si la entrada es comentario simple inicia aqui
<COMENT_SIMPLE> [^"\n"]         {}                          // 
<COMENT_SIMPLE> "\n"            {yybegin(YYINITIAL);}       // aqui sale del estado

<YYINITIAL>{
//"(" {return new Symbol(sym.aparen,yycolumn,yyline,yytext());}
//")" {return new Symbol(sym.cparen,yycolumn,yyline,yytext());}
//"," {return new Symbol(sym.comaa,yycolumn,yyline,yytext());}
//"," {return new Symbol(sym.comaa,yycolumn,yyline,yytext());}
"+" {System.out.println(yytext()); return new Symbol(sym.suma,yycolumn,yyline,yytext());}
"-" {System.out.println(yytext());return new Symbol(sym.resta,yycolumn,yyline,yytext());}
"*" {System.out.println(yytext());return new Symbol(sym.mult,yycolumn,yyline,yytext());}
"/" {System.out.println(yytext());return new Symbol(sym.div,yycolumn,yyline,yytext());}
"->" {System.out.println(yytext());return new Symbol(sym.flecha,yycolumn,yyline,yytext());}
"," {System.out.println(yytext());return new Symbol(sym.coma,yycolumn,yyline,yytext());}
";" {System.out.println(yytext());return new Symbol(sym.puntocoma,yycolumn,yyline,yytext());}
"%" {System.out.println(yytext());return new Symbol(sym.porcentaje,yycolumn,yyline,yytext());}
":" {System.out.println(yytext());return new Symbol(sym.dpuntos,yycolumn,yyline,yytext());}
"{" {System.out.println(yytext());return new Symbol(sym.llaveiz,yycolumn,yyline,yytext());}
"}" {System.out.println(yytext());return new Symbol(sym.llaveder,yycolumn,yyline,yytext());}
"~" {System.out.println(yytext());return new Symbol(sym.sconj,yycolumn,yyline,yytext());}
"." {System.out.println(yytext());return new Symbol(sym.conc,yycolumn,yyline,yytext());}
"|" {System.out.println(yytext());return new Symbol(sym.or,yycolumn,yyline,yytext());}
"?" {System.out.println(yytext());return new Symbol(sym.inter,yycolumn,yyline,yytext());}
"\\”" {System.out.println(yytext());return new Symbol(sym.comilla,yycolumn,yyline,yytext());}
"\\'" {System.out.println(yytext());return new Symbol(sym.comilla2,yycolumn,yyline,yytext());}
"\\n" {System.out.println(yytext());return new Symbol(sym.salto,yycolumn,yyline,yytext());}
"conj" {System.out.println(yytext());return new Symbol(sym.conj,yycolumn,yyline,yytext());}
"tld" {System.out.println(yytext());return new Symbol(sym.tld,yycolumn,yyline,yytext());}

\n {yycolumn=1;}
{blancos} {/*Se ignoran*/}
//45+98
//{nombre} {System.out.println(yytext());return new Symbol(sym.nombre,yycolumn,yyline,yytext());}
{entero} {System.out.println(yytext());return new Symbol(sym.entero,yycolumn,yyline,yytext());} // almacenando un valor entero en la tabla de simbolos
{decimal} {System.out.println(yytext());return new Symbol(sym.decimal,yycolumn,yyline,yytext());}
{letra} {System.out.println(yytext());return new Symbol(sym.letra,yycolumn,yyline,yytext());}
{id} {System.out.println(yytext());return new Symbol(sym.id,yycolumn,yyline,yytext());}
{simbolo} {System.out.println(yytext());return new Symbol(sym.simbolo,yycolumn,yyline,yytext());}
{cadena} {System.out.println(yytext());return new Symbol(sym.cadena,yycolumn,yyline,yytext());}
"\"" {yybegin(STRNG);}
"\”" {yybegin(STRNG2);}
"\'" {yybegin(STRNG3);}


//CUALQUIER ERROR:           SIMBOLOS NO DEFINIDOS DENTRO DEL LENGUAJE
.   {
	    System.err.println("Error lexico: "+yytext()+ " Linea:"+(yyline)+" Columna:"+(yycolumn));
            AddError("Error Léxico",yytext(),yyline,yycolumn);
    }

/*   . {
    addError("tipo lexico", yytext(), yyline, yycolumn)

}

class name{

}

{

}

*/
}

