require 'socket'

# Implementa o Portao de Saida
class PortaoSaida

	# Cria um novo portao.
	# Recebe por parametro a porta que o servidor esta escutando
	def initialize(port)
		@porta = port		
	end

	# Abre o portao para deixar um carro sair.
	# Abre uma nova conexão com o servidor do estacionamento
	# avisando que um carro esta saindo. 
	# Espera confirmacao e fecha a conexao logo em seguida.
	def deixa_sair
		conexao = TCPSocket.new 'localhost', @porta
		conexao.send("sai_carro", 0)
		puts conexao.recv 30
		conexao.shutdown
	end
end

portao = PortaoSaida.new 9000

puts '''Portao de Saida do Estacionamento
Pressione:
	1 - Para deixar um carro sair.
	0 - Para terminar'''

a = 2
until a == 0
	a = gets.to_i
	portao.deixa_sair if a == 1
end