
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.io.FileInputStream;
import java.io.FileReader;
import labirinto.*;

public class Programa
{
	public static void main (String[] args)
    {

		try
		{
			BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
			System.out.print("Digite o nome do arquivo em que se encontra o labirinto: ");
			String arq = reader.readLine();

			FileReader leitura = new FileReader(arq);
			BufferedReader lab = new BufferedReader(leitura);

			int linha = Integer.parseInt(lab.readLine());
			int coluna = Integer.parseInt(lab.readLine());

			Labirinto labirinto = new Labirinto(linha,coluna);

			String li ="";
			for(int l = 0; l<linha; l++)
			{
				li = lab.readLine();
				 for(int c = 0; c < coluna; c++)
					labirinto.guarde(li.charAt(c),l,c);
			}

			labirinto.Seguir();
			System.out.print("Digite o nome do arquivo para armazenar a resposta: ");
			String resp = reader.readLine();
			labirinto.ExibirNoArq(resp);
		}

		 catch (Exception erro)
		{
			System.err.println (erro);
		}
	}
}