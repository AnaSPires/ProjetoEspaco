
package labirinto;
import pilha.*;
import coordenada.*;
import fila.*;
import java.io.PrintWriter;
import java.io.FileWriter;

/**
	A classe Labirinto � uma classe clon�vel que armazena os dados de um labirinto e
	cria m�todos para encontrar o caminho para a resolu��o do labirinto.

	Inst�ncias desta classe permitem o armazenamento de characteres numa matriz.
	Nela encontramos os m�todos necess�rios para a inser��o dos caracteres do labirinto
	numa matriz e para a manuten��o do labirinto com o intuito de resolv�-lo.
	@author Ana Clara Sampaio Pires.
	@since 2018.
	*/

	public class Labirinto implements Cloneable
	{
		/**
				Expressa, em cada instante, a quantidade de linhas
				que o labirinto possui, ou seja a quantidade de linhas da matriz.
		*/

		protected int linhas = 0;

		/**
					Expressa, em cada instante, a quantidade de colunas
					que o labirinto possui, ou seja a quantidade de colunas da matriz.
		*/

		protected int colunas = 0;

		/**
				Mant�m armazenado os caracteres do labirinto, assim como � utilizado
				para a manuten��o deste.
		*/

		protected char[][] matriz;

		/**
			Representa a quantidade de coordenadas armazenadas em caminho, assim podendo descobrir no final
			por quantas coordenadas foi preciso passar para chegar na sa�da.
		*/

		protected int qtd= 0;
		/**
			    Cria a inst�ncia de uma pilha que armazena coordeenadas para a manuten��o
			    das coordenadas que ser� preciso percorrer para chegar at� a sa�da(caminho).
    	*/

		Pilha<Coordenada> caminho;

		/**
				Cria a inst�ncia de uma fila que armazena coordeenadas para a manuten��o
				das coordenadas pelas quais podemos seguir.
    	*/

		Fila<Coordenada> fila;

		/**
				Cria a inst�ncia de uma coordenada que armazena, a cada instante, a coordenada
				atual que estaremos situados no labirinto(atual).
    	*/
		Coordenada atual;

		/**
				Cria a inst�ncia de uma pilha que armazena uma fila de coordeenadas para a
				manuten��o das coordenadas de poss�veis caminhos que podemos seguir
				para que quando houver mais de um rumo a seguir e escolhemos um que leve
				a um lugar errado podemos voltar �quela possibilidade.
    	*/

		Pilha<Fila<Coordenada>> possibilidades; //pilha de filas de coordenadas

		 /**
			    Constroi uma nova inst�ncia da classe Labirinto.
			    Para tanto, deve ser fornecido dois inteiros que ser�o utilizados
			    como atributos da inst�ncia rec�m criada para a capacidade da matriz.
			    @param l o n�mero inteiro que ser� atribuido ao atributo linhas.
			    @param c o n�mero inteiro que ser� atribuido ao atributo colunas.
			    @throws Exception se a linhas ou colunas for negativa ou zero.
   		 */

				public Labirinto (int l, int c) throws Exception
				{
					if( l > 0 && c > 0)
					{
					this.linhas = l;
					this.colunas  = c;
					this.matriz = new char[this.linhas][this.colunas];
					int capacidade = linhas * colunas;

					caminho= new Pilha <Coordenada>(capacidade);

					possibilidades= new Pilha<Fila<Coordenada>>(capacidade);
					}

				}

				/**
					Armazena os caracteres fornecidos na matriz.
					Verifica antes se o dado passado n�o � null.
					@param l o character que ser� armazenada no matriz.
					@param posX a linha em que o character ser� armazenada no matriz.
					@param posY a coluna em que o character ser� armazenada no matriz.
					@throws Exception se o dado passado � null.

				*/


				public void guarde (char l,int posX,int posY ) throws Exception
				    {
						if (l=='\0' )
							throw new Exception ("Informacao ausente");

				        this.matriz[posX][posY] = l;
    				}

    				/**
					Informa a quantidade de linhas e colunas que o labirinto possui.
					Verifica se linhas ou colunas est� vazio, ou seja, se a matriz est� vazia.
					@return a quantidade de linhas e colunas da matriz ou
					vazia caso a matriz esteja vazia.
	  				*/

				    public String toString ()
				    {
						if (this.linhas ==0 || this.colunas ==0)
						    return "Vazia";

						return "O labirinto tem" + this.linhas+" linhas e"+this.colunas+"colunas";
					}

					/**
					Verifica se a classe fornecida � igual � classe atual(this).
					Compara o tipo das classes, os atributos e os dados presentes na matriz.
					Verifica se a classe fornecida n�o � null.
					@param obj o tipo da classe.
					@return o resultado da verifica��o se as classes s�o iguais.
	   				*/

					//compara this e obj
					public boolean equals (Object obj)
					{
						if (this==obj)
						    return true;

						if (obj==null)
						    return false;

						if (this.getClass()!=obj.getClass())
						    return false;

						Labirinto lab = (Labirinto)obj;

						if (this.linhas!=lab.linhas)
						    return false;

						if (this.colunas!=lab.colunas)
						    return false;

						for (int l=0; l<this.linhas; l++)
						{
							for(int c = 0; c< colunas; c++)
							{
								if (this.matriz[l][c] != lab.matriz[l][c])
									return false;
							}
						}

						return true;
					}

					/**
					Cria um valor de endere�o de mem�ria para uma vari�vel.
					@return um valor aleat�rio criado.
	    			*/

					public int hashCode ()
					{
						int ret=666; // so nao pode ser zero

						ret = ret*2 + new Integer(this.linhas).hashCode();
						ret = ret*2 + new Integer(this.colunas).hashCode();

				        for (int l=0; l<this.linhas; l++)
				        {
				         for (int c = 0;c<this.colunas; c++)
								ret = ret*2 + ((Character)this.matriz[l][c]).hashCode();
						}

						return ret;
					}

					/**
					Constroi uma c�pia da inst�ncia da classe Labirinto dada.
					Para tanto, deve ser fornecida uma instancia da classe Labirinto
					para ser utilizada como modelo para a constru��o da nova inst�ncia
					criada.
					@param modelo a inst�ncia da classe Labirinto a ser usada como
					modelo.
					@throws Exception se o modelo for null.
    				*/

					public Labirinto (Labirinto modelo) throws Exception
					{
						if(modelo == null)
							throw new Exception("Modelo ausente");

						this.linhas = modelo.linhas;

						this.colunas = modelo.colunas;

						this.matriz = new char[modelo.linhas][modelo.colunas];

						for (int l=0; l<modelo.linhas; l++)
						{
							for (int c = 0;c<modelo.colunas; c++)
							this.matriz[l][c] = modelo.matriz[l][c];
						}

					}

					/**
					Cria e retorna uma c�pia da inst�ncia chamante do m�todo (this).
					Utiliza o construtor de c�pia para criar uma inst�ncia id�ntica ao
					this para ent�o retorn�-la.
					Para ser utilizada como modelo para a constru��o da nova inst�ncia
   					*/

				public Object clone()
				{
					Labirinto ret = null;
					try
					{
						ret = new Labirinto(this);
					}
					catch(Exception erro)
					{}

					return ret;
				}

				 /**
					    Exibe o conte�do da matriz num arquivo texto passado por par�metro.
					    @param arq o arquivo texto em que ser� escrito a matriz e as coordenadas.
					    @throws Exception se qtd for menor que zero, ou se caminho ou inverso estiverem vazios.
				 */

				public void ExibirNoArq(String arq)throws Exception
				{
					PrintWriter resultado = new PrintWriter(new FileWriter( arq + ".res.txt"));


					for(int l = 0; l<linhas ;l++)
					{
						for(int c = 0; c<colunas; c++)
							resultado.print(matriz[l][c] );

					resultado.println("\n");
					}

					resultado.println("\n");
					resultado.println("\n");

					Pilha<Coordenada> inverso = new Pilha<Coordenada>(qtd);

					resultado.println("O caminho do labirinto para chegar na sa�da passou pelas seguintes coordenadas:");
					resultado.println("");

					for(int i = 0; i< qtd ; i++)
					{
					inverso.guarde(caminho.getUmItem());
					caminho.jogueForaUmItem();
					}

					for(int i = 0; i< qtd ; i++)
					{
					resultado.println("("+inverso.getUmItem().getX()+ ";"+inverso.getUmItem().getY()+")");
					resultado.println("");
					inverso.jogueForaUmItem();
					}


					resultado.close();
				}

				    /**
					Procura o caracter 'E' dentro da matriz.
					Percorrre toda a matriz para achar um caracter para armazenar
					a posi��o que o encontrou numa inst�ncia da vari�vel atual.
					Verifica se encontrou o caracter, sen�o significa que
					n�o h� entrada.
					@throws Exception se n�o encontrou o character 'E'.
    				*/

				public void EncontrarEntrada() throws Exception
				{
						for(int i = 0; i<colunas; i++)
						{
							if(matriz [0][i] == 'E')
								atual = new Coordenada(0,i);

								if(matriz [linhas-1][i] == 'E')
								 atual = new Coordenada(linhas-1,i);
						}

						for(int i = 1; i<linhas-1; i++)
						{
							if(matriz [i][0] == 'E')
								atual = new Coordenada(i,0);

								if(matriz [i][colunas-1] == 'E')
								 atual = new Coordenada(i, colunas-1);

						}

						if(atual == null)
						   throw new Exception(" N�o foi possivel achar a entrada");
				}

				 /**
					Verifica se o character localizado na coordenada atual com uma
					posi��o a menos na coluna � ' ' ou 'S' para que assim ele possa
					armazenar na fila uma inst�ncia da coordenada onde se localiza
					esse caracter.
					@throws Exception se a inst�ncia da coordenada que est� sendo
					guardada na fila � inv�lida.
   				 */

				protected void ParaEsquerda()throws Exception
				{
					if(atual.getY()-1 >=0)
					{
						if(this.matriz[atual.getX()][atual.getY() -1] == ' ' ||
						this.matriz[atual.getX()][atual.getY() -1] == 'S')
						{
						 fila.guarde(new Coordenada(atual.getX(),atual.getY()-1));
						}
				 	}
				}

				/**
				Verifica se o character localizado na coordenada atual com uma
				posi��o a mais na coluna � ' ' ou 'S' para que assim ele possa
				armazenar na fila uma inst�ncia da coordenada onde se localiza
				esse caracter.
				@throws Exception se a inst�ncia da coordenada que est� sendo
				guardada na fila � inv�lida.
   				 */

				protected void ParaDireita()throws Exception
				{
					if(atual.getY()+1 < this.colunas)
					{
						if(this.matriz[atual.getX()][atual.getY()+1] == ' ' ||
						this.matriz[atual.getX()][atual.getY() +1] == 'S')
						{
							 fila.guarde(new Coordenada(atual.getX(),atual.getY()+1));
						}
				 	}
				}

				/**
				Verifica se o character localizado na coordenada atual com uma
				posi��o a menos na linha � ' ' ou 'S' para que assim ele possa
				armazenar na fila uma inst�ncia da coordenada onde se localiza
				esse caracter.
				@throws Exception se a inst�ncia da coordenada que est� sendo
				guardada na fila � inv�lida.
   				 */

				protected void ParaCima()throws Exception
				{
					if(atual.getX()-1>=0)
					{
						if(this.matriz[atual.getX()-1][atual.getY()] == ' ' ||
						this.matriz[atual.getX()-1][atual.getY()] == 'S')
						{
						 	fila.guarde(new Coordenada(atual.getX()-1,atual.getY()));
						}
				 	}
				}

				/**
				Verifica se o character localizado na coordenada atual com uma
				posi��o a mais na linha � ' ' ou 'S' para que assim ele possa
				armazenar na fila uma inst�ncia da coordenada onde se localiza
				esse caracter.
				@throws Exception se a inst�ncia da coordenada que est� sendo
				guardada na fila � inv�lida.
   				 */

				protected void ParaBaixo()throws Exception
				{
					if(atual.getX()+1<this.linhas)
					{
						if(this.matriz[atual.getX() +1][atual.getY()] == ' ' ||
						this.matriz[atual.getX()+1][atual.getY()] == 'S')
						{
							fila.guarde(new Coordenada(atual.getX()+1,atual.getY()));
						}
				 	}
				}

				/**
				Altera o valor da matriz na coordenada do caminho para ' ' e
				altera a coordenada  de atual e altera a ultima coordeenada
				inserida no caminho para null, tudo isso para que podemos chegar
				at� uma posi��o que possua uma coordenada em possibilidades.
				@throws Exception se a inst�ncia  coordenada que est� sendo usada para alterar
				atual for inv�lida, se caminho estiver vazio e se possibilidades estiver
				vazia.
   				 */

				protected void Regredir() throws Exception
				{
					if(possibilidades.isVazia())
					   throw new Exception("Labirinto n�o tem solu��o");
					this.matriz[caminho.getUmItem().getX()][caminho.getUmItem().getY()] = ' ';
					this.atual.setX(new Coordenada(caminho.getUmItem()).getX());
					this.atual.setY(new Coordenada(caminho.getUmItem()).getY());
					this.caminho.jogueForaUmItem();
					this.qtd--;
					this.fila = possibilidades.getUmItem();
					this.possibilidades.jogueForaUmItem();
				}

				/**
				Faz a manuten��o do labirinto chamando o m�todo EncontrarEntrada()e
				dentro de um loop enquanto n�o encontrar a sa�da, chamando os m�todos
				para preencher caminho e a matriz.
				@throws Exception se atual for igual a null,se a inst�ncia da coordenada
				que est� sendo guardada na fila � inv�lida,se a inst�ncia  coordenada que
				est� sendo usada para alterar atual for inv�lida, se caminho estiver vazio
				,se possibilidades estiver	vazia e se fila estiver vazia.
				*/

				public void Seguir()throws Exception
				{
					boolean achou = false;
					EncontrarEntrada();
					while(!achou)
					{
						fila= new Fila<Coordenada>(3);
						ParaEsquerda();
						ParaDireita();
						ParaCima();
						ParaBaixo();
						while(fila.isVazia())
						   Regredir();
						atual = fila.getUmItem();
						if(matriz[atual.getX()][atual.getY()] == 'S')
							achou =true;
							System.out.println(atual);
						fila.jogueForaUmItem();
						possibilidades.guarde(fila);
						if(!achou)
						{
							matriz[atual.getX()][atual.getY()] = '*';
							caminho.guarde(new Coordenada(atual.getX() ,atual.getY()));
							qtd++;
						}
				    }
				}
}