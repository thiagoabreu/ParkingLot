require 'socket'

# Implementa o Estacionamento.
class Estacionamento

	# Cria um novo estacionamento. Com o numero passado de vagas
	def initialize(vagas = 5)
		@vagas = vagas
		@atual = 0
		print "Novo Estacionamento com #{@vagas} vagas.\n"
	end
	
	# Retorna um array dizendo se esta lotado
	# e quantas vagas livres ainda restam
	def estado
		cheio = @atual >= @vagas
		mensagem = if cheio 
			"Lotado." 
		else
			"Ha #{@vagas - @atual} vagas livres."
		end
		[cheio, mensagem]
	end

	# Incrementa a quantidade de carros estacionados
	# a nao ser que esteja lotado.
	# Imprime na tela a acao correspondente
	# e o estado logo em seguida.
	def entra_carro
		unless estado[0]
			@atual += 1
			retorna = "Um carro estacionou."
		else
			retorna = "Lotado."
		end
		puts retorna
		puts "Status: #{estado[1]}"
		retorna
	end

	# Decrementa a quantidade de carros estacionados
	# a nao ser que nao haja mais carros.
	# Imprime na tela a acao correspondente
	# e o estado logo em seguida.
	def sai_carro
		if @atual > 0
			@atual -= 1	
			retorna = "Um carro saiu."
		else
			retorna = "Nao ha carros para sair."
		end
		print retorna + "\n"
		print "Status: #{estado[1]}\n"
		retorna
	end
	
end

estacionamento = Estacionamento.new
servidor = TCPServer.new('localhost', 9000)

while(sessao = servidor.accept)
	mensagem = sessao.recv 15
	resposta = estacionamento.send(mensagem) # Chamada dinâmica de metodo
	sessao.send resposta, 0
end