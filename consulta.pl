#!/usr/bin/perl
use strict;
use warnings;
use CGI;

print "Content-type: text/html\n\n";
print <<HTML;
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Busqueda bibliograficas de Programacion Web 1 </title>
    <link rel="stylesheet" type="text/css" href="../css/estilo.css">
  </head>
<body>
HTML
my $q = CGI->new;
my $kind = $q->param("kind");
my $keyword = $q->param("keyword");
my $flag;
if(!($kind eq "") && !($keyword eq "")){
  open(IN,"../universidades.txt") or die "<h1>ERROR: open file</h1>\n";
  while(my $line = <IN>){
    my %dict=matchLine($line);
    my $value = $dict{$kind};
    if(defined($value) && $value =~ /.*$keyword.*/){
      print "<h1>ENCONTRADO:  $line <span>value= $value</span> </h1>\n";
      $flag = 1; #continue the loop
      next;
    }
  }
  close(IN);
}
if(!defined($flag)){
  print "<h1>No encontrado</h1>\n";
}
print <<HTML;
      INGRESE <a href="../consulta.html">aqui </a>para regresar al formulario de busqueda
    </body>
  </html>
HTML

sub matchLine{ 
  my %dict = ();
  my $line = $_[0];
if( $line =~ /(^[0-9A]+)\|([A-ZÁÉÍÓÚ ]+)\|([A-ZÚ]+)\|([A-Z ]+)\|([0-9]+)\|([A-Z0-9]+)\|([A-Z-ÁÉÍÓÚ ]+)\|([A-ZÁÉÍÓÚ ]+)\|([A-ZÁÉÍÓÚ ]+)\|([A-Z0-9]+)\|([A-ZÁÉÍÓÚ ]+)\|([A-ZÁÉÍÓÚ ]+)\|([A-ZÁÉÍÓÚ ]+)\|(.?[0-9]+\.[0-9]+)\|(.?[0-9]+\.[0-9]+)\|([A-Z. ]+)\|([A-ZÁÉÍÚÓ ]+)/){
    $dict{"nombre"} = $2;
    $dict{"periodo"} = $5;
    $dict{"depLocal"} = $11;
    $dict{"denPrograma"} = $17;
  }
  return %dict;
}

