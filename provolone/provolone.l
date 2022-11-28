%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
}%

%%

"PROGRAMA"  {return PROGRAMA;}
"ENTRADA"   {return ENTRADA;}
"SAIDA"     {return SAIDA;}
"ENQUANTO"  {return ENQUANTO;}
"FIM"       {return FIM;}
"FACA"      {return FACA;}
"SE"        {return SE;}
"ENTAO"     {return ENTAO;}
"SENAO"     {return SENAO;}

%%