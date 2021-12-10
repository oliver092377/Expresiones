#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;
my $user = "alumno";
my $password = "pweb1";
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.1.11";
my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar");;

my $q = CGI->new;
my $nombre = $q->param("nombre");
my $texto = $q->param("texto");
print $q->header("text/html");
print<<BLOCK;
<!DOCTYPE html>
  <html>
    <head>
      <title>Hello FORM</title>
    </head>
    <body>
BLOCK
my $sth = $dbh->prepare("SELECT hiperenlace, edit, detele FROM MarkDown ");
$sth->execute();
while(my @row = $sth->fetchrow_array){
  print "<h1>@row </h1>";  
}
$sth->finish;
$dbh->disconnect;
#   <h2>Hello,busqu
print <<FINAL;
      <a href=../new.html>Crear nueva pagina</a>  
    </body>
  </html>
FINAL
