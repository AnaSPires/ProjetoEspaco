
package labirinto;
import pilha.*;
import coordenada.*;
import fila.*;
import java.io.PrintWriter;
import java.io.FileWriter;

/**
	A classe Labirinto é uma classe clonável que armazena os dados de um labirinto e
	cria métodos para encontrar o caminho para a resolução do labirinto.

	Instâncias desta classe permitem o armazenamento de characteres numa matriz.
	Nela encontramos os métodos necessários para a inserção dos caracteres do labirinto
	numa matriz e para a manutenção do labirinto com o intuito de resolvê-lo.
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
				Mantém armazenado os caracteres do labirinto, assim como é utilizado
				para a manutenção deste.
		*/

		protected char[][] matriz;

		/**
			Representa a quantidade de coordenadas armazenadas em caminho, assim podendo descobrir no final
			por quantas coordenadas foi preciso passar para chegar na saída.
		*/

		protected int qtd= 0;
		/**
			    Cria a instância de uma pilha que armazena coordeenadas para a manutenção
			    das coordenadas que será preciso percorrer para chegar até a saída(caminho).
    	*/

		Pilha<Coordenada> caminho;

		/**
				Cria a instância de uma fila que armazena coordeenadas para a manutenção
				das coordenadas pelas quais podemos seguir.
    	*/

		Fila<Coordenada> fila;

		/**
				Cria a instância de uma coordenada que armazena, a cada instante, a coordenada
				atual que estaremos situados no labirinto(atual).
    	*/
		Coordenada atual;

		/**
				Cria a instância de uma pilha que armazena uma fila de coordeenadas para a
				manutenção das coordenadas de possíveis caminhos que podemos seguir
				para que quando houver mais de um rumo a seguir e escolhemos um que leve
				a um lugar errado podemos voltar àquela possibilidade.
    	*/

		Pilha<Fila<Coordenada>> possibilidades; //pilha de filas de coordenadas

		 /**
			    Constroi uma nova instância da classe Labirinto.
			    Para tanto, deve ser fornecido dois inteiros que serão utilizados
			    como atributos da instância recém criada para a capacidade da matriz.
			    @param l o número inteiro que será atribuido ao atributo linhas.
			    @param c o número inteiro que será atribuido ao atributo colunas.
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
					Verifica antes se o dado passado não é null.
					@param l o character que será armazenada no matriz.
					@param posX a linha em que o character será armazenada no matriz.
					@param posY a coluna em que o character será armazenada no matriz.
					@throws Exception se o dado passado é null.

				*/


				public void guarde (char l,int posX,int posY ) throws Exception
				    {
						if (l=='\0' )
							throw new Exception ("Informacao ausente");

				        this.matriz[posX][posY] = l;
    				}

    				/**
					Informa a quantidade de linhas e colunas que o labirinto possui.
					Verifica se linhas ou colunas está vazio, ou seja, se a matriz está vazia.
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
					Verifica se a classe fornecida é igual à classe atual(this).
					Compara o tipo das classes, os atributos e os dados presentes na matriz.
					Verifica se a classe fornecida não é null.
					@param obj o tipo da classe.
					@return o resultado da verificação se as classes são iguais.
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
					Cria um valor de endereço de memória para uma variável.
					@return um valor aleatório criado.
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
					Constroi uma cópia da instância da classe Labirinto dada.
					Para tanto, deve ser fornecida uma instancia da classe Labirinto
					para ser utilizada como modelo para a construção da nova instância
					criada.
					@param modelo a instância da classe Labirinto a ser usada como
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
					Cria e retorna uma cópia da instância chamante do método (this).
					Utiliza o construtor de cópia para criar uma instância idêntica ao
					this para então retorná-la.
					Para ser utilizada como modelo para a construção da nova instância
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
					    Exibe o conteúdo da matriz num arquivo texto passado por parâmetro.
					    @param arq o arquivo texto em que será escrito a matriz e as coordenadas.
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

					resultado.println("O caminho do labirinto para chegar na saída passou pelas seguintes coordenadas:");
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
					a posição que o encontrou numa instância da variável atual.
					Verifica se encontrou o caracter, senão significa que
					não há entrada.
					@throws Exception se não encontrou o character 'E'.
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
						   throw new Exception(" Não foi possivel achar a entrada");
				}

				 /**
					Verifica se o character localizado na coordenada atual com uma
					posição a menos na coluna é ' ' ou 'S' para que assim ele possa
					armazenar na fila uma instância da coordenada onde se localiza
					esse caracter.
					@throws Exception se a instância da coordenada que está sendo
					guardada na fila é inválida.
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
				posição a mais na coluna é ' ' ou 'S' para que assim ele possa
				armazenar na fila uma instância da coordenada onde se localiza
				esse caracter.
				@throws Exception se a instância da coordenada que está sendo
				guardada na fila é inválida.
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
				posição a menos na linha é ' ' ou 'S' para que assim ele possa
				armazenar na fila uma instância da coordenada onde se localiza
				esse caracter.
				@throws Exception se a instância da coordenada que está sendo
				guardada na fila é inválida.
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
				posição a mais na linha é ' ' ou 'S' para que assim ele possa
				armazenar na fila uma instância da coordenada onde se localiza
				esse caracter.
				@throws Exception se a instância da coordenada que está sendo
				guardada na fila é inválida.
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
				até uma posição que possua uma coordenada em possibilidades.
				@throws Exception se a instância  coordenada que está sendo usada para alterar
				atual for inválida, se caminho estiver vazio e se possibilidades estiver
				vazia.
   				 */

				protected void Regredir() throws Exception
				{
					if(possibilidades.isVazia())
					   throw new Exception("Labirinto não tem solução");
					this.matriz[caminho.getUmItem().getX()][caminho.getUmItem().getY()] = ' ';
					this.atual.setX(new Coordenada(caminho.getUmItem()).getX());
					this.atual.setY(new Coordenada(caminho.getUmItem()).getY());
					this.caminho.jogueForaUmItem();
					this.qtd--;
					this.fila = possibilidades.getUmItem();
					this.possibilidades.jogueForaUmItem();
				}

				/**
				Faz a manutenção do labirinto chamando o método EncontrarEntrada()e
				dentro de um loop enquanto não encontrar a saída, chamando os métodos
				para preencher caminho e a matriz.
				@throws Exception se atual for igual a null,se a instância da coordenada
				que está sendo guardada na fila é inválida,se a instância  coordenada que
				está sendo usada para alterar atual for inválida, se caminho estiver vazio
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