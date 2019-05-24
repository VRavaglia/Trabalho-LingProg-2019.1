use strict;
use warnings FATAL => 'all';
use Data::Dumper;
use English qw' -no_match_vars ';
use Scalar::Util qw(looks_like_number);
use Term::ReadKey;

use lib './';
use GerenciamentoDeDados;

#my @teste = GerenciamentoDeDados::listaPontuacoesMaiores("dadosTeste.txt", 3);
#print Dumper @teste;
#GerenciamentoDeDados::salvaPerfil("dadosTeste.txt","raposo","666","1");

sub printMenu{
    print "|================================|\n";
    print "|           Trabalho 2           |\n";
    print "|================================|\n";
    print "| 0 ------------------------ Sair|\n";
    print "| 1 -- Lista N maiores pontuacoes|\n";
    print "| 2 ------------- Salva progresso|\n";
    print "| 3 --------------- Le jogo salvo|\n";
    print "| 4 ---- Le pontuacoes de jogador|\n";
    print "|================================|\n";
}

sub clear{
    if($OSNAME eq "MSWin32"){
        system("cls");
    }else{
        system("clear");
    }
}

sub continuar{
    print "\nAperte \{ENTER\} para voltar ao menu principal...\n";
    my $key = <STDIN>;
}

my $opcao;
my $rodando = 1;
my $debug = 1;


while($rodando > 0){
    clear();
    printMenu();
    print "Digite um numero de 0 a 5:\n";
    $opcao = <STDIN>;
    chomp $opcao;
    if(looks_like_number($opcao)){
        clear();
        if($opcao == 0){
            print "Saindo...\n";
            $rodando = 0;
        }
        elsif($opcao == 1){
          # Lista N maiores pontuacoes
            print "Digite o nome do arquivo de pontuacoes:\n";
            my $arquivo = <STDIN>;
            chomp $arquivo;
            print "Digite o numero maximo de pontuacoes:\n";
            my $n = <STDIN>;
            chomp $n;
            my @pontuacoes = GerenciamentoDeDados::listaPontuacoesMaiores($arquivo, $n);
            my $size = scalar @pontuacoes;
            print "Pontuacoes encontradas (" . $size ."):\n";
            for my $i (0 .. $size - 1){
                print "Nome: ". $pontuacoes[$size - $i - 1]{"nome"} . ", pontos: " . $pontuacoes[$size - $i - 1]{"pontos"} . "\n";
            }
            continuar();
        }elsif ($opcao == 2){
          # Salva progresso
            print "Digite o nome do arquivo de pontuacoes:\n";
            my $arquivo = <STDIN>;
            chomp $arquivo;
            print "Digite o nome do perfil:\n";
            my $nome = <STDIN>;
            chomp $nome;
            print "Digite a pontuacao atual:\n";
            my $pontos = <STDIN>;
            chomp $pontos;
            print "Digite a dificuldade atual:\n";
            my $dificuldade = <STDIN>;
            chomp $dificuldade;
            my $status = GerenciamentoDeDados::salvaPerfil($arquivo,$nome,$pontos,$dificuldade);
            if ($status == 0){
                print "Perfil alterado com   sucesso.\n";
            }elsif($status == 1){
                print "Perfil criado com sucesso.\n";
            }
            else{
                print "Ocorreu um erro de numero: " . $status;
            }
            continuar();
        }elsif ($opcao == 3){
        # Le jogo salvo
          my $status;
          my $pontuacao;
          #print "Digite o nome do arquivo de pontuacoes:\n";
          #my $arquivo = <STDIN>;
          #chomp $arquivo;
          my $arquivo = "dadosTeste.txt";
          print "Digite o nome do perfil:\n";
          my $nome = <STDIN>;
          chomp $nome;
          print "Digite a dificuldade atual:\n";
          my $dificuldade = <STDIN>;
          chomp $dificuldade;
          ($pontuacao, $status) = GerenciamentoDeDados::leJogoEmAndamento($nome, $dificuldade, $arquivo);
          print "Pontuacao: $pontuacao";
          continuar();
        }elsif ($opcao == 4){
        # Le pontuacoes de jogador
          my $status;
          my @pontuacao;
          #print "Digite o nome do arquivo de pontuacoes:\n";
          #my $arquivo = <STDIN>;
          #chomp $arquivo;
          my $arquivo = "dadosTeste.txt";
          print "Digite o nome do perfil:\n";
          my $nome = <STDIN>;
          chomp $nome;
          print "Digite a restricao atual:\n";
          my $restricao = <STDIN>;
          chomp $restricao;
          (@pontuacao, $status) = GerenciamentoDeDados::listaPontuacoesDeJogador($nome, $restricao, $arquivo);
          print "Lista de pontos: @pontuacao";
          continuar();
        }elsif ($opcao == 5){

        }
    }

}
