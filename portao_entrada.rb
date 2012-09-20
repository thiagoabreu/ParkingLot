require 'socket'

# Implementa o Portao de Entrada.
class PortaoEntrada

	# Cria um novo portao.
	# [port] E a porta que o servidor esta escutando
	def initialize(port)
		@porta = port.to_i
	end

	# Abre o portao para deixar um carro entrar.
	# Abre uma nova conexão com o servidor do estacionamento
	# avisando que um carro esta entrando. 
	# Espera confirmacao e fecha a conexao logo em seguida.
	def deixa_entrar
		conexao = TCPSocket.new 'localhost', @porta
		conexao.send("entra_carro", 0)
		puts conexao.recv 30
		conexao.shutdown	
	end
end

#Criar portao
portao = PortaoEntrada.new (ARGV.shift || 9000)

puts '''Portao de Entrada para o Estacionamento
Pressione:
	1 - Para deixar um carro entrar.
	0 - Para terminar'''

a = 2
until a == 0
	a = gets.to_i
	portao.deixa_entrar if a == 1
end